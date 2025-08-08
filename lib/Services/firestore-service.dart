import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_parking_app/Models/parking-slot-model.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _collection = _db.collection("parking_slots");

  static Future<List<ParkingSlotModel>> fetchSlots() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((doc) => ParkingSlotModel.fromDoc(doc)).toList();
  }

  static Future<void> bookSlot(String slotId, String name) async {
    await _collection.doc(slotId).set({'bookedBy': name});
  }

  static Future<void> freeSlot(String slotId) async {
    await _collection.doc(slotId).delete();
  }

  /// Real-time stream of slots
  static Stream<List<ParkingSlotModel>> slotsStream() {
    return _collection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ParkingSlotModel.fromDoc(doc)).toList());
  }
}
