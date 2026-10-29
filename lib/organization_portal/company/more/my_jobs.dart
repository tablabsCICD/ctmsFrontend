
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../locator.dart';
import '../../../pages/widget/card/base_widgets.dart';
import '../../base_widget/all_cards.dart';
import '../../base_widget/custom_textview.dart';
import '../../dialog/animated_custom_dialog.dart';
import '../../dialog/my_dialog.dart';
import '../../localization/language_constrants.dart';
import '../../model/auth_api.dart';
import '../../model/my_job_list.dart';
import '../../model/truck_load_model.dart';
import '../../provider/auth_provider.dart';
import '../../provider/buy_sell_provider.dart';
import '../../provider/delete_interface.dart';
import '../../provider/localization_provider.dart';
import '../../util/ResponsiveWidget.dart';
import '../../util/style.dart';
import '../company_provider/more_provider.dart';

class MyJobCard extends StatefulWidget {
  final ConnectUser user;
  final List<MyJobData> jobList;

  const MyJobCard(this.jobList, this.user, {Key? key}) : super(key: key);

  @override
  _MyJobCardState createState() => _MyJobCardState();
}

class _MyJobCardState extends State<MyJobCard> implements DeletePostInf {
  final authProvider = locator<AuthProvider>();

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveWidget.isDesktop(context)
        ? 3
        : ResponsiveWidget.isMobile(context)
        ? 1
        : 2;

    return Consumer<MoreProvider>(
      builder: (context, model, child) {
        if (widget.jobList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.work_outline, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 12),
                Text(
                  "No Jobs Available",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  "Your posted jobs will appear here",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey.shade500),
                ),
              ],
            ),
          );
        }

        return Container(
          margin: ResponsiveWidget.isDesktop(context)
              ? const EdgeInsets.symmetric(horizontal: 35, vertical: 10)
              : const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            itemCount: widget.jobList.length,
            itemBuilder: (context, index) {
              return _buildJobCard(
                index,
                context,
                widget.jobList[index],
                model,
                userId: authProvider.userDetailList.isNotEmpty
                    ? authProvider.userDetailList[0].id ?? 0
                    : 0,
              );
            },
            shrinkWrap: true,
            staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
          ),
        );
      },
    );
  }

  Widget _buildJobCard(
      int index,
      BuildContext context,
      MyJobData myJobPost,
      MoreProvider model, {
        required int userId,
      }) {
    final postJob = myJobPost.postJob;
    final jobType = postJob?.type ?? "";
    final jobTitle = postJob?.topicName ?? "";
    final jobDesc = postJob?.jobDescription ?? "";
    final jobCategory = postJob?.jobType ?? "";

    return Container(
      width: 335,
      padding: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x114A5568),
            blurRadius: 8,
            offset: Offset(0, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Job Type Tag
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100,
              height: 18,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: ShapeDecoration(
                color: const Color(0xFFD35E61),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Center(
                child: Text(
                  jobType,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          /// Job Heading + Description
          BaseWidget().heading(jobTitle, jobCategory, jobDesc),

          const SizedBox(height: 8),

          /// Delete / Share Buttons
          BaseWidget().deleteMyPostButton((val) {
            switch (val) {
              case 1:
              case 10:
                Future.delayed(Duration.zero,
                        () => _showMyDialog(index, myJobPost, model));
                break;
              case 3:
                final description =
                    "Type: $jobType\nSubject: $jobDesc\nPost Title: $jobDesc\nLink: https://api.tkdost.com/postJob/?id=${postJob?.id ?? ''}";
                // await Utils().callShareFunction(description);
                break;
            }
          }),
        ],
      ),
    );
  }

  @override
  void deleteOwnPost(int postId, int index) {
    // Not used here but required by interface
  }

  Future<void> _showMyDialog(
      int index,
      MyJobData myJobData,
      MoreProvider provider,
      ) async {
    return showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: CustomText(
          'Are you sure you want to delete this post?',
          style: Style.title,
        ),
        actions: <Widget>[
          TextButton(
            child: CustomText(
              getTranslated('yes', context) ?? 'Yes',
              style: Style.okButton,
            ),
            onPressed: () {
              provider.deleteJob(myJobData).then((_) {
                showAnimatedDialog(
                  context,
                  MyDialog(
                    icon: Icons.check,
                    title: 'Post Deleted',
                    description: 'Your post has been deleted successfully',
                    isFailed: false,
                    isFromPost: true,
                  ),
                  dismissible: false,
                  isFlip: false,
                );
              });
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: CustomText('No', style: Style.cancelButton),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  void rePost(TruckLoad truckLoad, bool isCityInterchange) {
    // Optional: Implement repost logic if needed
  }
}
