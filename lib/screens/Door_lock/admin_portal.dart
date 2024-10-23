import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_dispenser/controllers/admin_portal_controller.dart';

class AdminPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AdminPortalController controller = Get.put(AdminPortalController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Admin Portal'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Current Requests'),
                Tab(text: 'Request History'),
              ],
            ),
          ),
          body: TabBarView(children: [
            // Tab 1: Current Requests
            Obx(() {
              if (controller.usefulaccesssRequest.isEmpty) {
                return const Center(
                  child: Text("No Access requests at the moment....."),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.usefulaccesssRequest.length,
                  itemBuilder: (context, index) {
                    final request = controller.usefulaccesssRequest[index];
                    String requestId = request['id'];
                    String deviceName =
                        request['device name'] ?? 'Unknown Device';

                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: const Text(
                                  'A user is trying to access your house.'),
                              subtitle: Text(
                                  'Request ID: $requestId\nDevice: $deviceName'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    controller.acceptRequest(requestId);
                                  },
                                  child: const Text('Accept',
                                      style: TextStyle(color: Colors.green)),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () {
                                    controller.rejectRequest(requestId);
                                  },
                                  child: const Text('Reject',
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),

            // Tab 2: Request History
            Obx(() => ListView.builder(
                      itemCount: controller.requestHistory.length,
                      itemBuilder: (context, index) {
                        final request = controller.requestHistory[index];

                        // Debugging: Print the data structure
                        print('Request history data at index $index: $request');

                        if (request is Map<String, dynamic>) {
                          return Card(
                            color: request['status'] == 'accepted'
                                ? Colors.green[100]
                                : request['status'] == 'rejected'
                                    ? Colors.red[100]
                                    : Colors.yellow[100],
                            margin: const EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text('Request ID: ${request['id']}'),
                                    subtitle:
                                        Text('Status: ${request['status']}'),
                                  ),
                                  Text(
                                    'Initiation Time: ${request['time']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Processed Time: ${request['processed time']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const Card(
                            margin: EdgeInsets.all(8),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text('Invalid request data'),
                                    subtitle:
                                        Text('Check your Firebase structure.'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    )

                // return ListTile(
                //   title: Text('Request ID: ${historyItem['id']}'),
                //   subtitle: Text('User: ${historyItem['user']}'),
                //   tileColor: status == 'accepted'
                //       ? Colors.green.withOpacity(0.2)
                //       : Colors.red.withOpacity(0.2),
                // );
                )
          ])),
    );
  }
}
