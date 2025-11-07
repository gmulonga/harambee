import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harambee/models/campaign_model.dart';
import 'package:harambee/services/kopokopo_service.dart';
import 'package:harambee/services/local_db_service.dart';

class CampaignController extends GetxController {
  final KopoKopoService _service = KopoKopoService();
  final LocalDBService _db = LocalDBService();

  RxBool isLoading = false.obs;
  RxList<Campaign> campaigns = <Campaign>[].obs;

  @override
  void onInit() {
    fetchCampaigns();
    super.onInit();
  }

  Future<void> createCampaign({
    required String title,
    required double amount,
    required String description,
  }) async {
    try {
      isLoading.value = true;

      final newCampaign = Campaign(
        id: 0,
        title: title,
        description: description,
        targetAmount: amount,
        amountRaised: 0,
      );

      await _db.insertCampaign(newCampaign);
      await fetchCampaigns();

      Get.snackbar("Success 🎉", "Campaign created successfully!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCampaigns() async {
    try {
      isLoading.value = true;
      final list = await _db.getCampaigns();
      campaigns.value = list;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> donateToCampaign({
    required Campaign campaign,
    required String phoneNumber,
    required double amount,
  }) async {
    try {
      isLoading.value = true;

      // Simulate payment in sandbox
      await _service.simulatePayment(
        phoneNumber: phoneNumber,
        amount: amount,
        tillNumber: "K473129"
      );

      campaign.amountRaised += amount;
      await _db.updateCampaign(campaign);
      await fetchCampaigns();

      Get.snackbar(
        "Donation Sent 🎁",
        "Donation of KES $amount sent to ${campaign.title}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Payment Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
