import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../model/my_bids.dart';
import 'more/post_details_new.dart';

Widget buildPostBidDialog(BuildContext context, int postId) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    insetPadding: const EdgeInsets.all(16),
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.80,
      child: FutureBuilder<Map<String, dynamic>>(
        future: getPostAndBidDetails(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Failed to load data"));
          }

          final postBidData = PostBidData.fromJson(snapshot.data!);

          GenericCardsDto? post = postBidData.genericCardsDto;
          List<BidingDetails> bids = postBidData.bidings ?? [];

          if (post == null) {
            return const Center(child: Text("No post data found"));
          }

          return Column(
            children: [
              /// HEADER
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red.shade700, Colors.red.shade400],
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Post & Bidding Details",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: Colors.white),
                    )
                  ],
                ),
              ),

              /// POST CARD
              PostDetailsCard(post: post!),

              const SizedBox(height: 18),

              /// BIDDING HEADER
              Row(
                children: const [
                  Icon(Icons.groups_rounded),
                  SizedBox(width: 6),
                  Text(
                    "Bidding List",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// BIDDING LIST
              bids.isEmpty
                  ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("No bids received yet"),
                ),
              )
                  : Column(
                children: bids
                    .map((bidder) =>
                    BidderCard(bidder: bidder))
                    .toList(),
              ),
            ],
          );
        },
      ),
    ),
  );
}

/// ----------- BID CARD UI ------------
Widget _bidCard(BidingDetails bidObj, Bid? bid) {
  final dateTime = _formatDateTime(bid?.loggedTime);

  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.grey.shade300),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.currency_rupee, size: 20),
            const SizedBox(width: 4),
            Text(
              bid?.amount?.toString() ?? "-",
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: bid?.isAccepted == 1
                    ? Colors.green.withOpacity(.15)
                    : Colors.orange.withOpacity(.15),
              ),
              child: Text(
                bid?.isAccepted == 1 ? "Accepted" : "Pending",
                style: TextStyle(
                  color: bid?.isAccepted == 1
                      ? Colors.green
                      : Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "${bidObj.firstName ?? "-"} ${bidObj.lastName ?? ""}",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 2),
        Text(
          bidObj.companyName ?? "-",
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 14),
            const SizedBox(width: 4),
            Text(dateTime, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ],
    ),
  );
}



/// ----------- FORMAT DATE TIME ------------
String _formatDateTime(int? date) {
  if (date == null) return "-";
  try {
    final dt = DateTime.fromMillisecondsSinceEpoch(date);
    return DateFormat("dd MMM yyyy, hh:mm a").format(dt);
  } catch (e) {
    return "-";
  }
}


/// ----------- API CALL ------------
Future<Map<String, dynamic>> getPostAndBidDetails(int postId) async {
  final url =
      "${AppConstants.BASE_URL}getPostAndBidByPostId?postId=$postId";
  print(url);
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Failed to load post details");
  }
}
