import 'package:flutter/material.dart';
import 'package:harambee/utils/constants.dart';
import 'package:harambee/widgets/custom_border_button.dart';
import 'package:harambee/widgets/custom_button.dart';
import 'package:harambee/widgets/custom_header.dart';

class CampaignDetails extends StatelessWidget {
  final String title;
  final String? description;
  final double amountRaised;
  final double goalAmount;

  const CampaignDetails({
    Key? key,
    required this.title,
    this.description,
    required this.amountRaised,
    required this.goalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = goalAmount > 0
        ? (amountRaised / goalAmount).clamp(0.0, 1.0)
        : 0.0;
    final int percentage = (progress * 100).round();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            customHeader(label: "Campaign Details", icon: Icons.info),
            
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      color: kWhite,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 20),
              
                            // Progress bar with percentage
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: Colors.grey[200],
                                    valueColor: AlwaysStoppedAnimation<Color>(kPrimary),
                                    minHeight: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
              
                            // Amount info
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ksh ${amountRaised.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "raised of Ksh ${goalAmount.toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: kPrimary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "$percentage%",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
              
                            // Description
                            if (description != null && description!.isNotEmpty) ...[
                              const SizedBox(height: 20),
                              const Divider(),
                              const SizedBox(height: 20),
                              Text(
                                description!,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 10),
              
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButton(
                      callBackFunction: () {},
                      label: "Donate Now",
                      backgroundColor: kPrimary,
                      txtColor: kWhite,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomBorderButton(
                      callBackFunction: () {},
                      label: "Share",
                      borderColor: kPrimary,
                      txtColor: kPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomBorderButton(
                      callBackFunction: () {
                        Navigator.pop(context);
                      },
                      label: "Back",
                      borderColor: Colors.grey[300]!,
                      txtColor: Colors.grey[700]!,
                    ),
                  ),
              
                  const SizedBox(height: 40),
                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}