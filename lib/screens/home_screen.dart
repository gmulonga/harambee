import 'package:flutter/material.dart';
import 'package:harambee/screens/create_campaign.dart';
import 'package:harambee/utils/constants.dart';
import 'package:harambee/widgets/campaign_card.dart';
import 'package:harambee/widgets/custom_header.dart';
import 'package:animations/animations.dart';

import 'campaign_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgGrey,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            customHeader(label: "Home", icon: Icons.home),
            CampaignCard(title: "John's Wedding", amountRaised: 10000, goalAmount: 20000, description: "This is a sample description",),
            CampaignCard(title: "John's Wedding", amountRaised: 10000, goalAmount: 20000, description: "m Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem I",),
          ],
        ),
      ),

      floatingActionButton: OpenContainer(
        closedElevation: 6,
        closedShape: const CircleBorder(),
        transitionDuration: const Duration(milliseconds: 500),
        openBuilder: (context, _) => const CreateCampaign(),
        closedBuilder: (context, openContainer) => FloatingActionButton(
          onPressed: openContainer,
          backgroundColor: kPrimary,
          child: const Icon(Icons.add, color: kWhite,),
        ),
      ),
    );
  }
}
