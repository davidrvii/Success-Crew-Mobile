/// File: lib/core/widgets/home_shimmer_view.dart
/// Generated Documentation for home_shimmer_view.dart

import 'package:flutter/material.dart';
import 'skeleton_shimmer.dart';

/// Class representing `HomeShimmerView`.
/// Auto-generated class documentation.
class HomeShimmerView extends StatelessWidget {
  const HomeShimmerView({super.key});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Brand
            const Center(child: SkeletonBox(width: 120, height: 16)),
            const SizedBox(height: 14),

            // Header Card
            const SkeletonBox(width: double.infinity, height: 120, borderRadius: 22),
            const SizedBox(height: 18),

            // Section Title
            const SkeletonBox(width: 180, height: 24),
            const SizedBox(height: 12),

            // Business Summary Grid (2x2)
            Row(
              children: const [
                Expanded(child: SkeletonBox(width: double.infinity, height: 100, borderRadius: 16)),
                SizedBox(width: 12),
                Expanded(child: SkeletonBox(width: double.infinity, height: 100, borderRadius: 16)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(child: SkeletonBox(width: double.infinity, height: 100, borderRadius: 16)),
                SizedBox(width: 12),
                Expanded(child: SkeletonBox(width: double.infinity, height: 100, borderRadius: 16)),
              ],
            ),
            const SizedBox(height: 18),

            // Section Title
            const SkeletonBox(width: 200, height: 24),
            const SizedBox(height: 12),

            // Service Lists
            const SkeletonBox(width: double.infinity, height: 80, borderRadius: 16),
            const SizedBox(height: 12),
            const SkeletonBox(width: double.infinity, height: 80, borderRadius: 16),
          ],
        ),
      ),
    );
  }
}
