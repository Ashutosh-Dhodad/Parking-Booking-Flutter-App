import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingSlotModel {
  final String id;
  final String? bookedBy;

  ParkingSlotModel({required this.id, this.bookedBy});

  factory ParkingSlotModel.fromDoc(DocumentSnapshot doc) {
    return ParkingSlotModel(id: doc.id, bookedBy: doc['bookedBy']);
  }
}
