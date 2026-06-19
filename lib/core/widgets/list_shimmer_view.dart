/// File: lib/core/widgets/list_shimmer_view.dart
/// Generated Documentation for list_shimmer_view.dart

import 'package:flutter/material.dart';
import 'skeleton_shimmer.dart';

/// Class representing `ListShimmerView`.
/// Auto-generated class documentation.
class ListShimmerView extends StatelessWidget {
  final int count;

  const ListShimmerView({super.key, this.count = 5});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: count,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonBox(width: 48, height: 48, borderRadius: 12),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SkeletonBox(width: double.infinity, height: 16),
                        SizedBox(height: 8),
                        SkeletonBox(width: 150, height: 14),
                        SizedBox(height: 8),
                        SkeletonBox(width: 100, height: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
