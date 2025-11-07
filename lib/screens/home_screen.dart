import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harambee/controllers/create_campaign_controller.dart';
import 'package:harambee/screens/create_campaign.dart';
import 'package:harambee/utils/constants.dart';
import 'package:harambee/widgets/campaign_card.dart';
import 'package:harambee/widgets/custom_header.dart';
import 'package:animations/animations.dart';
import 'package:harambee/models/campaign_model.dart';

class HomeScreen extends StatelessWidget {
  final CampaignController controller = Get.put(CampaignController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgGrey,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            customHeader(label: "Home", icon: Icons.home),

            Expanded(
              child: Obx(() {
                if (controller.campaigns.isEmpty) {
                  return const Center(child: Text("No campaigns yet."));
                }

                return ListView.builder(
                  itemCount: controller.campaigns.length,
                  itemBuilder: (context, index) {
                    final Campaign campaign = controller.campaigns[index];
                    return CampaignCard(campaign: campaign);
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: OpenContainer(
        closedElevation: 6,
        closedShape: const CircleBorder(),
        transitionDuration: const Duration(milliseconds: 500),
        openBuilder: (context, _) => CreateCampaign(),
        closedBuilder: (context, openContainer) => FloatingActionButton(
          onPressed: openContainer,
          backgroundColor: kPrimary,
          child: const Icon(Icons.add, color: kWhite),
        ),
      ),
    );
  }
}
