import 'package:flutter/material.dart';
import 'package:shop_app/models/Title.dart';
import 'package:shop_app/server/Title.dart';
import 'package:shimmer/shimmer.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  _DiscountBannerState createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  late Future<List<NewTitle>> _futureTitles;

  @override
  void initState() {
    super.initState();
    // Create an instance of TitleServices and call the fetchTitle method
    TitleServices titleServices = TitleServices();
    _futureTitles = titleServices.fetchTitle();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewTitle>>(
      future: _futureTitles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerEffect(); // Show shimmer effect while waiting
        } else if (snapshot.hasError) {
          return _buildShimmerEffect();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print(snapshot.data);
          return const Text('No titles found');
        } else {
          // Display the data from the snapshot
          NewTitle title = snapshot.data!.first; // Assuming you want to display the first title
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF4A3298),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.title ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title.subtitile ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
