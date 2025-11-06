import 'package:flutter/material.dart';

class CampaignDetails extends StatefulWidget {
  const CampaignDetails({super.key});

  @override
  State<CampaignDetails> createState() => _CampaignDetailsState();
}

class _CampaignDetailsState extends State<CampaignDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Campaign details'),
      ),
    );
  }
}
