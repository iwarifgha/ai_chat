import 'package:flutter/material.dart';

import '../model/business_in_chat.dart';

class BusinessDataContainer extends StatelessWidget {
  const BusinessDataContainer({super.key, required this.business});

  final BusinessInChat business;

  @override
  Widget build(BuildContext context) {
    // final appColor = Theme.of(context).extension<AppColorsExtension>()!;
    // final textStyle = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
        margin: EdgeInsets.only(top: 8),
        height: 160,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 5,
              color: Colors.grey.shade50,
              offset: Offset(9.4, 9.4),
            ),
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 5,
              color: Colors.grey.shade50,
              offset: Offset(-9.4, -9.4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 📌 **Image Row**
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/images/snap_food.jpeg',
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 5), // Proper spacing
                  ClipRRect(
                    borderRadius: BorderRadius.zero,
                    child: Image.asset(
                      'assets/images/snap_food.jpeg',
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 5), // Proper spacing
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/images/snap_food.jpeg',
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            /// 📌 **Business Details**
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **Avatar**
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                  ),
                  SizedBox(width: 8), // Add space between avatar and text

                  /// **Business Name & Info**
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// **Business Name**
                        Text(
                          business.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 4),

                        /// **Business Category & Location**
                        Row(
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(Icons.work,
                                          size: 12, color: Colors.grey),
                                      alignment: PlaceholderAlignment
                                          .middle, // Aligns the icon properly with the text
                                    ),
                                    TextSpan(
                                      text: ' ${business.category.name} ',
                                      // Business category
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    WidgetSpan(
                                      child: Icon(Icons.location_on,
                                          size: 12, color: Colors.grey),
                                      alignment: PlaceholderAlignment
                                          .middle, // Aligns the icon properly with the text
                                    ),
                                    TextSpan(
                                      text:
                                          ' ${business.address ?? 'No address'}',
                                      // Business address
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                                // Ensure it truncates properly
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            /// 📌 **Review Section**
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                spacing: 5,
                children: [
                  /// **Review Average**
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        Text.rich(TextSpan(children: [
                          WidgetSpan(
                              child: Icon(
                            Icons.comment,
                            color: Colors.orangeAccent,
                            size: 12,
                          )),
                          TextSpan(
                            text: ' ${'Reviews:${business.rating}'}',
                            // Business address
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 10),
                          ),
                        ]))
                      ]),
                    ),
                  ),

                  /// **Review Star**
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Row(
                      children:
                          List.generate(business.rating?.toInt() ?? 0, (index) {
                        return Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.orange,
                        );
                      }),
                    ),
                  ),

                  /// **Opening Hours**
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                text: 'Open 24hours',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        color: Colors.green.shade400,
                                        fontSize: 10),
                              )
                            ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
