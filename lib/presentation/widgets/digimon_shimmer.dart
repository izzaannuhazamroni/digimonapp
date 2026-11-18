import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DigimonShimmer extends StatelessWidget {
  final int crossAxisCount;

  const DigimonShimmer({Key? key, this.crossAxisCount = 3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.68,
          crossAxisSpacing: crossAxisCount == 3 ? 6.0 : 10.0,
          mainAxisSpacing: crossAxisCount == 3 ? 8.0 : 12.0,
        ),
        itemCount: crossAxisCount * 3, // 3 rows of placeholder cards
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(crossAxisCount == 3 ? 6 : 8),
              border: Border.all(color: Colors.grey[400]!, width: 2),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    color: Colors.grey[200],
                  ),
                ),
                Container(
                  height: crossAxisCount == 3 ? 20 : 28,
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: Colors.grey[300],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
