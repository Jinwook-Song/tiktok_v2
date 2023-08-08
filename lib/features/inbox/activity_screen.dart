import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const List tabs = [
  {
    "title": "All activity",
    "icon": FontAwesomeIcons.solidMessage,
  },
  {
    "title": "Likes",
    "icon": FontAwesomeIcons.solidHeart,
  },
  {
    "title": "Comments",
    "icon": FontAwesomeIcons.solidComments,
  },
  {
    "title": "Mentions",
    "icon": FontAwesomeIcons.at,
  },
  {
    "title": "Followers",
    "icon": FontAwesomeIcons.solidUser,
  },
  {
    "title": "From TikTok",
    "icon": FontAwesomeIcons.tiktok,
  }
];

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  bool _dismissed = false;
  final List<String> _notifications = List.generate(
    20,
    (index) => '${index}h',
  );

  bool _showTopPannel = false;
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 300,
    ),
  );

  late final Animation<double> _rotationAnimation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  late final Animation<Offset> _pannelAnimation = Tween(
    begin: const Offset(0, -1),
    end: const Offset(0, 0),
  ).animate(_animationController);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTitleTap() {
    if (_showTopPannel) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    _showTopPannel = !_showTopPannel;
    setState(() {});
  }

  void _onDismissed(String notification) {
    _notifications.removeWhere((element) => element == notification);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onTitleTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('All activity'),
              Gaps.h2,
              RotationTransition(
                turns: _rotationAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size12,
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                  vertical: Sizes.size10,
                ),
                child: Text(
                  'New',
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: Sizes.size12,
                      fontWeight: FontWeight.w600),
                ),
              ),
              if (!_dismissed)
                Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: const ValueKey(0),

                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(onDismissed: () {
                      _dismissed = true;
                      setState(() {});
                    }),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (context) => {},
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (context) => {},
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 2,
                        onPressed: (context) => {},
                        backgroundColor: const Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.archive,
                        label: 'Archive',
                      ),
                      SlidableAction(
                        onPressed: (context) => {},
                        backgroundColor: const Color(0xFF0392CF),
                        foregroundColor: Colors.white,
                        icon: Icons.save,
                        label: 'Save',
                      ),
                    ],
                  ),

                  // The child of the Slidable is what the user sees when the
                  // component is not dragged.
                  child: const ListTile(title: Text('Slide me')),
                ),
              for (var notification in _notifications)
                Dismissible(
                  key: Key(notification),
                  onDismissed: (direction) => _onDismissed(notification),
                  background: Container(
                    padding: const EdgeInsets.only(
                      left: Sizes.size20,
                    ),
                    alignment: Alignment.centerLeft,
                    color: Colors.green,
                    child: const FaIcon(
                      FontAwesomeIcons.check,
                      size: Sizes.size20,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    padding: const EdgeInsets.only(
                      right: Sizes.size20,
                    ),
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const FaIcon(
                      FontAwesomeIcons.trashCan,
                      size: Sizes.size20,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: Sizes.size16,
                    leading: Container(
                      width: Sizes.size48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: const Center(
                        child: FaIcon(FontAwesomeIcons.bell),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: 'Account updates: ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.size14,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Upload longer videos ',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: notification,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: Sizes.size14,
                    ),
                  ),
                ),
            ],
          ),
          SlideTransition(
            position: _pannelAnimation,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    Sizes.size5,
                  ),
                  bottomRight: Radius.circular(
                    Sizes.size5,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in tabs)
                    ListTile(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Sizes.size32,
                              child: FaIcon(
                                tab['icon'],
                                size: Sizes.size16,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              tab['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
