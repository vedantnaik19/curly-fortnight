import 'package:flutter/material.dart';

import 'nothing_here.dart';

class NoNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NothingHere(size: 120),
          SizedBox(height: 16),
          Text("No notes found"),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
