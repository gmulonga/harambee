import 'package:flutter/material.dart';
import 'package:harambee/screens/create_campaign.dart';
import 'package:harambee/utils/constants.dart';
import 'package:harambee/widgets/custom_header.dart';
import 'package:animations/animations.dart';

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
