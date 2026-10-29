import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/my_bids.dart';

class PostDetailsCard extends StatelessWidget {
  final GenericCardsDto post;

  const PostDetailsCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.topicName ?? "",
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage:
                post.companyLogo != null && post.companyLogo!.isNotEmpty
                    ? CachedNetworkImageProvider(post.companyLogo!)
                    : const AssetImage(
                    "assets/images/company_placeholder.png")
                as ImageProvider,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.companyName ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("Posted by: ${post.nameOfPerson ?? ""}",
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 13)),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 14, color: Colors.red),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${post.source} → ${post.destination}",
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _chip(post.mainTag),
              _chip("Cargo: ${post.cargoType}"),
              _chip("Weight: ${post.vehicleWeight}"),
            ],
          ),

          const SizedBox(height: 8),

          Text("Content: ${post.content ?? "-"}",
              style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _chip(String? text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text ?? "-",
          style: const TextStyle(fontSize: 11)),
    );
  }
}

class BidderCard extends StatelessWidget {
  final BidingDetails bidder;

  const BidderCard({Key? key, required this.bidder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bid = bidder.bidings;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: bidder.profileImage != null
                ? CachedNetworkImageProvider(bidder.profileImage!)
                : const AssetImage("assets/images/user_placeholder.png")
            as ImageProvider,
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("₹ ${bid?.amount ?? 0}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold,color: Colors.green)),
                Text(
                  "${bidder.firstName ?? ""} ${bidder.lastName ?? ""}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(bidder.companyName ?? "",
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 13, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      _formatDateTime(bid?.loggedTime),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          _statusBadge(bid?.isAccepted),
        ],
      ),
    );
  }

  Widget _statusBadge(int? status) {
    final bool accepted = status == 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: accepted
            ? Colors.green.withOpacity(.15)
            : Colors.orange.withOpacity(.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        accepted ? "Accepted" : "Pending",
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: accepted ? Colors.green : Colors.orange,
        ),
      ),
    );
  }
}

String _formatDateTime(int? date) {
  if (date == null) return "-";
  try {
    final dt = DateTime.fromMillisecondsSinceEpoch(date);
    return DateFormat("dd MMM yyyy, hh:mm a").format(dt);
  } catch (_) {
    return "-";
  }
}
