import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import
import 'package:new_parking_app/Controllers/auth-controller.dart';
import 'package:new_parking_app/Models/parking-slot-model.dart';
import 'package:new_parking_app/Services/firestore-service.dart';
import 'package:new_parking_app/Services/handle-slot-tap-serivece.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // We no longer keep a local slots list; we listen to the stream instead.

 Stream<List<ParkingSlotModel>> getSlotsStream() {
  return FirestoreService.slotsStream().map((slots) {
    final existingIds = slots.map((s) => s.id).toSet();
    for (int i = 1; i <= 10; i++) {
      final id = "P$i";
      if (!existingIds.contains(id)) {
        slots.add(ParkingSlotModel(id: id, bookedBy: null));
      }
    }
    slots.sort((a, b) {
      int aNum = int.tryParse(a.id.substring(1)) ?? 0;
      int bNum = int.tryParse(b.id.substring(1)) ?? 0;
      return aNum.compareTo(bNum);
    });
    return slots;
  });
}


  bool isBooked(List<ParkingSlotModel> slots, String id) {
    return slots.any((slot) => slot.id == id && slot.bookedBy != null);
  }

  String? bookedBy(List<ParkingSlotModel> slots, String id) {
    final slot = slots.firstWhere((slot) => slot.id == id, orElse: () => ParkingSlotModel(id: id));
    return slot.bookedBy;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double slotSize = (screenWidth - (16 * 2) - (10 * 4)) / 6; // Responsive slot width

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Parking Slots",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 59, 30, 206),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () => AuthController.logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height - 450,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 86, bottom: 8),
                child: StreamBuilder<List<ParkingSlotModel>>(
                  stream: getSlotsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final slots = snapshot.data!;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        String id = "P${index + 1}";
                        bool booked = isBooked(slots, id);

                        return GestureDetector(
                          onTap: () => handleSlotTap(
                            context: context,
                            id: id,
                            isBooked: booked,
                            bookedBy: (id) => bookedBy(slots, id),
                            reloadSlots: () async {}, // no need to reload manually, stream does it
                          ),
                          child: Container(
                            width: slotSize,
                            height: slotSize,
                            decoration: BoxDecoration(
                              color: booked ? Colors.redAccent.shade100 : Colors.greenAccent.shade100,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  booked ? Icons.car_repair : Icons.local_parking,
                                  color: booked ? Colors.red.shade900 : Colors.green.shade900,
                                  size: 25,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
