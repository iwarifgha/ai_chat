import 'package:ai_chat/core/constants/colors/colors.dart';
import 'package:flutter/material.dart';

import '../model/business_in_chat.dart';
import 'business_container.dart';

class ChatBotBubble extends StatefulWidget {
  const ChatBotBubble({
    super.key,
    required this.message,
    required this.avatarUrl,
    required this.businesses,
  });

  final String message;
  final String avatarUrl;
  final List<BusinessInChat> businesses;

  @override
  State<ChatBotBubble> createState() => _ChatBotBubbleState();
}

class _ChatBotBubbleState extends State<ChatBotBubble>
    with TickerProviderStateMixin {
  late final Animation<Offset> positionAnimation;
  late final AnimationController positionAnimationController;

  late final Animation<double> fadeAnimation;
  late final AnimationController fadeAnimationController;

  @override
  void initState() {
    positionAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    fadeAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    positionAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: positionAnimationController, curve: Curves.easeInOut));
    fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(fadeAnimationController);

    super.initState();
    positionAnimationController.forward();
    fadeAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final bubbleColor = kColorPrimary;
    return SlideTransition(
      position: positionAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: bubbleColor),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 3),
                      color: kColorGrey.shade100,
                      blurRadius: 9.4,
                    ),
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //AI avatar
                  CircleAvatar(radius: 15, child: Icon(Icons.logo_dev)),
                  const SizedBox(width: 8),

                  //Text message
                  Flexible(
                    child: Column(
                      children: [
                        Text(widget.message,
                            style: TextStyle(color: kColorWhite)),
                        if (widget.businesses.isNotEmpty)
                          Column(
                            spacing: 10,
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(widget.businesses.length,
                                (index) {
                              final business = widget.businesses[index];
                              return BusinessDataContainer(business: business);
                            }),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: SizedBox(
                        height: 10,
                        width: 10,
                        child: Icon(Icons.thumb_up_alt_outlined,
                            color: kColorWhite)),
                    onTap: () {},
                  ),
                  GestureDetector(
                    child: SizedBox(
                        height: 10,
                        width: 10,
                        child: Icon(
                          Icons.thumb_down_off_alt_sharp,
                          color: kColorWhite,
                        )),
                    onTap: () {},
                  ),
                  GestureDetector(
                    child: SizedBox(
                        height: 10,
                        width: 10,
                        child: Icon(Icons.copy, color: kColorWhite)),
                    onTap: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
