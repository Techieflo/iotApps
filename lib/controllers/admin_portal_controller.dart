import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:liquid_dispenser/controllers/notification_controller.dart';
import 'package:intl/intl.dart';
import 'package:liquid_dispenser/variables.dart';

class AdminPortalController extends GetxController {
  var accessRequests = <dynamic>[].obs;
  var connected = true.obs;
  var requestHistory = <Map<String, dynamic>>[].obs;
  var usefulaccesssRequest = <Map<String, dynamic>>[].obs; // Holds useful requests
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final NotificationService _notificationService = NotificationService();

  @override
  void onInit() async {
    super.onInit();
    _notificationService.init();
    _fetchAccessRequests();
    _listenForScanSuccess();
    _getDeviceName();
    _checkInternetConnection();
  }

  void _checkInternetConnection() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      connected.value = status == InternetConnectionStatus.connected;
      if (!connected.value) {
        _showReconnectingDialog();
      } else {
        _hideReconnectingDialog();
      }
    });
  }

  void _showReconnectingDialog() {
    if (!Get.isDialogOpen!) {
      Get.dialog(
        CupertinoAlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Internet Connection Error",
                style: TextStyle(fontWeight: FontWeight.bold, color: textgreen),
              ),
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(),
              CircularProgressIndicator(
                color: greencolor,
              ),
              const SizedBox(
                width: 9,
              ),
              Text(
                "Reconnecting.......",
                style: TextStyle(fontWeight: FontWeight.bold, color: textgreen),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  void _hideReconnectingDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  Future<String> _getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceName;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.name;
    } else {
      deviceName = "Unknown Device";
    }

    return deviceName;
  }

  // Fetching all access requests
  void _fetchAccessRequests() {
    _dbRef.child("requests").onValue.listen((event) {
      if (event.snapshot.exists) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);

        accessRequests.value = data.keys.toList();

        requestHistory.value = data.entries.map((e) {
          final value = Map<String, dynamic>.from(e.value);
          return {
            'id': e.key,
            'status': value['status'] ?? 'unknown', // Handle missing status
            'user': value['user'] ?? 'Unknown',     // Handle missing user
            'time': value['time'] ?? 'Unknown',     // Handle missing time
            'processed time': value['processed time'] ?? 'N/A',
            'device name': value['device name'] ?? 'Unknown Device',
          };
        }).toList();

        // Sort requestHistory: pending first, accepted second, rejected last
        requestHistory.value.sort((a, b) {
          List<String> order = ['pending', 'accepted', 'rejected'];
          return order.indexOf(a['status']).compareTo(order.indexOf(b['status']));
        });

        // Filter the useful access request list to show only pending requests
        usefulaccesssRequest.value = requestHistory
            .where((item) => item['status'] == 'pending')
            .toList();

        print('Access requests updated: ${accessRequests.value}');
        print('Request history updated: ${requestHistory.value}');
        print('Useful access requests updated: ${usefulaccesssRequest.value}');
      } else {
        print('No access requests found.');
      }
    });
  }

  void _listenForScanSuccess() {
    _dbRef.child("scansuccess").onValue.listen((event) async {
      if (event.snapshot.exists && event.snapshot.value == true) {
        print('Scansuccess detected.');
        _dbRef.child("scansuccess").set(false); // Reset the value

        // Generate a new request ID and add it to Firebase
        String newRequestId = _dbRef.child("requests").push().key!;
        String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        String deviceName = await _getDeviceName();
        print('New request ID: $newRequestId');
        print('Timestamp: $timestamp');

        try {
          await _dbRef.child("requests/$newRequestId").set({
            'user': 'Unknown', // Replace with actual user data if available
            'time': timestamp,
            'status': 'pending',
            'device name': deviceName,
          });
          print('New request added to Firebase.');
          _notificationService.showNotification("New access request created");

          // Update the useful access request list
          _fetchAccessRequests();
        } catch (e) {
          print('Error adding new request to Firebase: $e');
        }
      }
    });
  }

  void acceptRequest(String requestId) async {
    String processedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    // Update request status and processed time
    await _dbRef.child("requests/$requestId").update({
      'status': 'accepted',
      'processed time': processedTime, // Fixed key capitalization
    });

    // Set "opendoor" to true at the root level
    await _dbRef.child("opendoor").set(true);

    // Delay for 5 seconds and then set "opendoor" back to false
    Future.delayed(Duration(seconds: 5), () async {
      await _dbRef.child("opendoor").set(false);
    });

    // Refresh the list after acceptance
    _fetchAccessRequests();
  }

  void rejectRequest(String requestId) async {
    String processedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    // Update request status and processed time
    await _dbRef.child("requests/$requestId").update({
      'status': 'rejected',
      'processed time': processedTime, // Fixed key capitalization
    });

    // Refresh the list after rejection
    _fetchAccessRequests();
  }
}
