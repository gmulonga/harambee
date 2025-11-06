import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:harambee/utils/constants.dart';
import 'package:harambee/screens/campaign_details.dart';

class CampaignCard extends StatelessWidget {
  final String title;
  final String? description;
  final double amountRaised;
  final double goalAmount;

  const CampaignCard({
    Key? key,
    required this.title,
    this.description,
    required this.amountRaised,
    required this.goalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = goalAmount > 0 ? (amountRaised / goalAmount).clamp(0.0, 1.0) : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: OpenContainer(
        transitionDuration: const Duration(milliseconds: 600),
        openColor: Colors.white,
        closedColor: Colors.white,
        closedElevation: 3,
        openElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        openBuilder: (context, _) => CampaignDetails(
          title: title,
          description: description,
          amountRaised: amountRaised,
          goalAmount: goalAmount,
        ),
        closedBuilder: (context, openContainer) => InkWell(
          onTap: openContainer,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: kPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.volunteer_activism, color: kPrimary, size: 30),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      if (description != null && description!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          description!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(kPrimary),
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ksh ${amountRaised.toStringAsFixed(0)} raised",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            "Goal: Ksh ${goalAmount.toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
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
        ),
      ),
    );
  }
}
