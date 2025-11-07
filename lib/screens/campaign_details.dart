import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harambee/controllers/create_campaign_controller.dart';
import 'package:harambee/models/campaign_model.dart';
import 'package:harambee/utils/constants.dart';
import 'package:harambee/widgets/custom_border_button.dart';
import 'package:harambee/widgets/custom_button.dart';
import 'package:harambee/widgets/custom_header.dart';

class CampaignDetails extends StatelessWidget {
  final Campaign campaign;
  final CampaignController controller = Get.find<CampaignController>();

  CampaignDetails({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    final double progress = campaign.targetAmount > 0
        ? (campaign.amountRaised / campaign.targetAmount).clamp(0.0, 1.0)
        : 0.0;
    final int percentage = (progress * 100).round();

    final _phoneController = TextEditingController();
    final _amountController = TextEditingController();

    void _handleDonation() async {
      final phone = _phoneController.text.trim();
      final amount = double.tryParse(_amountController.text.trim()) ?? 0;

      if (phone.isEmpty || amount <= 0) {
        Get.snackbar("Error", "Please provide phone number and amount.");
        return;
      }

      await controller.donateToCampaign(
        campaign: campaign,
        phoneNumber: phone,
        amount: amount,
      );

      _phoneController.clear();
      _amountController.clear();
    }

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
                padding: const EdgeInsets.all(15),
                children: [
                  Card(
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
                          Text(
                            campaign.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(kPrimary),
                            minHeight: 12,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ksh ${campaign.amountRaised.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "raised of Ksh ${campaign.targetAmount.toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                          if (campaign.description.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            const Divider(),
                            const SizedBox(height: 20),
                            Text(
                              campaign.description,
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

                  const SizedBox(height: 20),

                  // Donation Input Fields
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Amount",
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Obx(() => CustomButton(
                    callBackFunction: controller.isLoading.value ? null : _handleDonation,
                    label: controller.isLoading.value ? "Processing..." : "Donate Now",
                    backgroundColor: controller.isLoading.value ? Colors.grey : kPrimary,
                    txtColor: kWhite,
                  )),

                  const SizedBox(height: 12),
                  CustomBorderButton(
                    callBackFunction: () => Navigator.pop(context),
                    label: "Back",
                    borderColor: Colors.grey[300]!,
                    txtColor: Colors.grey[700]!,
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
