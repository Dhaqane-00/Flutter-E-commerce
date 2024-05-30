import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});
  static String routeName = "/setting";

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: const Center(
        child: Text("No settings available wait for update"),
      ),
    );
  }
}