import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size12,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          surfaceTintColor: Colors.grey.shade50,
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text(
            '22796 comments',
          ),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const Icon(
                FontAwesomeIcons.xmark,
              ),
            ),
          ],
        ),
        body: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
              vertical: Sizes.size10,
            ),
            itemCount: 10,
            separatorBuilder: (context, index) => Gaps.v20,
            itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: Sizes.size16,
                      child: Text('JW'),
                    ),
                    Gaps.h10,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'JW',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: Sizes.size12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gaps.v3,
                        const Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          style: TextStyle(
                            fontSize: Sizes.size12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                    Gaps.h10,
                    Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.heart,
                          color: Colors.grey.shade600,
                          size: Sizes.size20,
                        ),
                        Gaps.v2,
                        Text(
                          '52.2K',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: Sizes.size12,
                          ),
                        )
                      ],
                    )
                  ],
                )),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Row(
            children: [
              CircleAvatar(
                radius: Sizes.size16,
                child: Text('JW'),
              ),
              Gaps.h10,
              Expanded(child: TextField())
            ],
          ),
        ),
      ),
    );
  }
}
