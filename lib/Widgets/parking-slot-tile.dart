import 'package:flutter/material.dart';

class ParkingSlotTile extends StatelessWidget {
  final String id;
  final bool isBooked;
  final String? bookedBy;
  final VoidCallback onTap;

  const ParkingSlotTile({
    required this.id,
    required this.isBooked,
    this.bookedBy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isBooked ? Colors.red : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          id,
          style: TextStyle(
            color: isBooked ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
