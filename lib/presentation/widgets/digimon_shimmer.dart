import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DigimonShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: Container(width: 50, height: 50, color: Colors.grey),
              title: Container(width: 150, height: 20, color: Colors.grey),
              subtitle: Container(width: 100, height: 15, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
