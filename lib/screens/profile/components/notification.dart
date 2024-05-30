import 'package:flutter/material.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});
  static String routeName = "/notification";
  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: const Center(
        child: Text("No notifications available"),
      ),
    );
  }
}