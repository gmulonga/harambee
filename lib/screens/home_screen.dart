import 'package:flutter/material.dart';
import 'package:harambee/utils/constants.dart';
import 'package:harambee/widgets/custom_header.dart';

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
      body: SafeArea(child: Column(children: [
        SizedBox(height: 10,),
        customHeader(label: "Home", icon: Icons.home),
      ],))
    );
  }
}
