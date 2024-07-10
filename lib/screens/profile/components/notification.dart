import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  static String routeName = "/notification";

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  PermissionStatus _permissionStatus = PermissionStatus.restricted;

  @override
  void initState() {
    super.initState();
    _checkNotificationPermission();
  }

  Future<void> _checkNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> _requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();
    setState(() {
      _permissionStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_permissionStatus == PermissionStatus.granted)
              const Text("You have permission to receive notifications."),
            if (_permissionStatus == PermissionStatus.denied)
              const Text("Notification permissions are denied."),
            if (_permissionStatus == PermissionStatus.permanentlyDenied)
              const Text("Notification permissions are permanently denied."),
            if (_permissionStatus == PermissionStatus.restricted)
              const Text("Notification permissions are restricted."),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestNotificationPermission,
              child: const Text("Request Notification Permission"),
            ),
          ],
        ),
      ),
    );
  }
}
