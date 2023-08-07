import 'dart:io';

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
  bool _isWriting = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _onStopWriting() {
    FocusScope.of(context).unfocus();
    _isWriting = false;
    setState(() {});
  }

  void _onStartWriting() {
    _isWriting = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
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
        body: GestureDetector(
          onTap: _onStopWriting,
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.only(
                      left: Sizes.size16,
                      right: Sizes.size16,
                      top: Sizes.size10,
                      bottom: Sizes.size10 + (Platform.isIOS ? 120 : 100),
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
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: Sizes.size16,
                        child: Text('JW'),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: SizedBox(
                          height: Sizes.size44,
                          child: TextField(
                            onTap: _onStartWriting,
                            textInputAction: TextInputAction.newline,
                            expands: true,
                            minLines: null,
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                hintText: 'Add comment...',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      Sizes.size12,
                                    ),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size12,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    right: Sizes.size12,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.at,
                                        color: Colors.grey.shade800,
                                      ),
                                      Gaps.h10,
                                      Icon(
                                        FontAwesomeIcons.gift,
                                        color: Colors.grey.shade800,
                                      ),
                                      Gaps.h10,
                                      Icon(
                                        FontAwesomeIcons.faceSmile,
                                        color: Colors.grey.shade800,
                                      ),
                                      Gaps.h10,
                                      GestureDetector(
                                        onTap: _onStopWriting,
                                        child: Icon(
                                          FontAwesomeIcons.paperPlane,
                                          color: _isWriting
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
