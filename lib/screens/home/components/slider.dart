import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key? key}) : super(key: key);

  final List<String> imgList = const [
    'assets/images/3.png',
    'assets/images/2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: imgList.map((item) => _buildImageItem(item)).toList(),
    );
  }

  Widget _buildImageItem(String imagePath) {
    return FutureBuilder(
      future: _loadImage(imagePath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoading();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading image'));
        } else {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
              child: Image.asset(imagePath, fit: BoxFit.cover, width: 1000),
            ),
          );
        }
      },
    );
  }

  Future<void> _loadImage(String imagePath) async {
    // Simulate network image loading
    await Future.delayed(Duration(seconds: 2));
  }
}

class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: 200.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
