import 'package:flutter/material.dart';

class BottomSheetExample extends StatelessWidget {
  //const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                color: Colors.white,
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.photo,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Take Photo",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.photo_camera,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Take Photo",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
