import 'package:flutter/material.dart';
import 'package:harambee/utils/constants.dart';
import 'package:harambee/widgets/custom_border_button.dart';
import 'package:harambee/widgets/custom_button.dart';
import 'package:harambee/widgets/custom_header.dart';
import 'package:harambee/widgets/custom_input.dart';
import 'package:lottie/lottie.dart';

class CreateCampaign extends StatefulWidget {
  const CreateCampaign({super.key});

  @override
  State<CreateCampaign> createState() => _CreateCampaignState();
}

class _CreateCampaignState extends State<CreateCampaign> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _desriptionController = TextEditingController();

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
                SizedBox(height: 20,),
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Lottie.asset(
                    'assets/animations/Marketing.json',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: InputField(
                    hintText: 'Title',
                    prefixIcon: Icons.card_membership_sharp,
                    controller: _titleController,
                    isRequired: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This filed is required";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: InputField(
                    hintText: 'Target Amount',
                    prefixIcon: Icons.attach_money_outlined,
                    controller: _amountController,
                    isRequired: true,
                    integerOnly: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This filed is required";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: InputField(
                    hintText: 'Description',
                    controller: _desriptionController,
                    maxLines: 6,
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButton(callBackFunction: () {},
                        label: "Create Campaign",
                        backgroundColor: kPrimary,
                        txtColor: kWhite),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: CustomBorderButton(callBackFunction: () {
                    Navigator.pop(context);
                  }, label: "back", borderColor: Colors.grey, txtColor: Colors.grey[300]!),
                )

              ],
            ),
          )
        ],
      ))
    );
  }
}
