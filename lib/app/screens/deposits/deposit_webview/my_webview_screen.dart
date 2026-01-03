import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/utils/my_color.dart';
import '../../../components/app-bar/custom_appbar.dart';
import 'webview_widget.dart';

class MyWebViewScreen extends StatefulWidget {
  final String redirectUrl;
  final bool isBoost;

  const MyWebViewScreen({super.key, required this.redirectUrl, required this.isBoost});

  @override
  State<MyWebViewScreen> createState() => _MyWebViewScreenState();
}

class _MyWebViewScreenState extends State<MyWebViewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '',
        isShowBackBtn: true,
      ),
      body: MyWebViewWidget(url: widget.redirectUrl, boost: widget.isBoost),
      floatingActionButton: favoriteButton(),
    );
  }

  Widget favoriteButton() {
    return FloatingActionButton(
      backgroundColor: MyColor.getErrorColor(),
      onPressed: () async {
        Get.back();
      },
      child: Icon(
        Icons.cancel,
        color: MyColor.white,
        size: 30,
      ),
    );
  }

  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.microphone,
      Permission.mediaLibrary,
      Permission.camera,
      Permission.storage,
    ].request();

    return statuses;
  }
}
