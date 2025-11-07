import 'package:get/get.dart';
import 'package:harambee/controllers/create_campaign_controller.dart';
import 'package:harambee/utils/constants.dart';
import 'package:harambee/widgets/custom_button.dart';
import 'package:harambee/widgets/custom_header.dart';
import 'package:harambee/widgets/custom_input.dart';
import 'package:harambee/widgets/custom_border_button.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class CreateCampaign extends StatelessWidget {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final CampaignController controller = Get.put(CampaignController());

  CreateCampaign({super.key});

  Future<void> _handleCreateCampaign() async {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    final desc = _descriptionController.text.trim();

    if (title.isEmpty || amount <= 0 || desc.isEmpty) {
      Get.snackbar("Error", "Please fill all required fields.");
      return;
    }

    // Call createCampaign from controller
    await controller.createCampaign(
      title: title,
      amount: amount,
      description: desc,
    );

    // Clear inputs only after creation is done
    if (!controller.isLoading.value) {
      _titleController.clear();
      _amountController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            customHeader(label: "Create Campaign", icon: Icons.add),
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Lottie.asset(
                      'assets/animations/Marketing.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: InputField(
                      hintText: 'Title',
                      prefixIcon: Icons.card_membership_sharp,
                      controller: _titleController,
                      isRequired: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: InputField(
                      hintText: 'Target Amount',
                      prefixIcon: Icons.attach_money_outlined,
                      controller: _amountController,
                      isRequired: true,
                      integerOnly: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: InputField(
                      hintText: 'Description',
                      controller: _descriptionController,
                      maxLines: 6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Obx(() => CustomButton(
                      callBackFunction: controller.isLoading.value ? null : _handleCreateCampaign,
                      label: controller.isLoading.value ? "Creating..." : "Create Campaign",
                      backgroundColor: controller.isLoading.value ? Colors.grey : kPrimary,
                      txtColor: kWhite,
                    )),
                  ),

                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: CustomBorderButton(
                      callBackFunction: () {
                        Navigator.pop(context);
                      },
                      label: "Back",
                      borderColor: Colors.grey[300]!,
                      txtColor: kPrimary,
                    ),
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
