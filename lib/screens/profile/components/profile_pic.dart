import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shop_app/provider/loginProvider.dart';
import 'dart:io';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  bool _isUploading = false;

  Future<void> _pickImage(ImageSource source) async {
    final status = await _requestPermission(source);
    if (status != PermissionStatus.granted) {
      print('Permission not granted');
      return;
    }

    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      print("Picked File: ${pickedFile.path}");
      setState(() {
        _imageFile = pickedFile;
      });
      _updateProfilePicture(File(pickedFile.path));
    } else {
      print("No image selected");
    }
  }

  Future<PermissionStatus> _requestPermission(ImageSource source) async {
    PermissionStatus status;
    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else {
      status = await Permission.photos.request();
    }

    if (status.isDenied) {
      status = await _checkStoragePermission();
    }

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return status;
  }

  Future<PermissionStatus> _checkStoragePermission() async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final storageStatus = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;

    if (storageStatus == PermissionStatus.granted) {
      print("Storage permission granted");
    }
    if (storageStatus == PermissionStatus.denied) {
      print("Storage permission denied");
    }
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }

    return storageStatus;
  }

  Future<void> _updateProfilePicture(File imageFile) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      _isUploading = true;
    });
    await userProvider.updateProfilePicture(imageFile);
    setState(() {
      _isUploading = false;
    });
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Choose Profile Photo",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.photo_library, color: Colors.blue, size: 30),
                  title: Text(
                    'Photo Library',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera, color: Colors.green, size: 30),
                  title: Text(
                    'Camera',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final imageUrl = userProvider.user.photo;

        return SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                backgroundImage: _imageFile != null
                    ? FileImage(File(_imageFile!.path))
                    : (imageUrl != null
                            ? NetworkImage(imageUrl)
                            : const AssetImage("assets/images/Profile Image.png"))
                        as ImageProvider,
              ),
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xFFF5F6F9),
                    ),
                    onPressed: () {
                      _showPicker(context);
                    },
                    child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                  ),
                ),
              ),
              if (_isUploading)
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
