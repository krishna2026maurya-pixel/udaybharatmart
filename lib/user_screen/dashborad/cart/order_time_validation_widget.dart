import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/cutom_text.dart';

bool isOrderTimeAllowed() {
  final now = DateTime.now();

  final startTime = DateTime(now.year, now.month, now.day, 8, 0); // 8:00 AM
  final endTime   = DateTime(now.year, now.month, now.day, 20, 0); // 8:00 PM

  return now.isAfter(startTime) && now.isBefore(endTime);
}
void showOrderTimePopup(BuildContext context,{String?message}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.access_time_rounded,
                  color: Colors.orange,
                  size: 60),
              const SizedBox(height: 12),
              Text(
                "Ordering Time Closed",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              CustomText(
                "${message}",
                textAlign: TextAlign.center,
                fontSize: 14,
                color: Colors.grey[700],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK",
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
