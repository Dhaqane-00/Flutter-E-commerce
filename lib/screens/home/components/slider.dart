import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key? key}) : super(key: key);

  final List<String> imgList = const [
    'https://via.placeholder.com/600x400.png?text=Image+1',
    'https://via.placeholder.com/600x400.png?text=Image+2',
    'https://via.placeholder.com/600x400.png?text=Image+3',
    'https://via.placeholder.com/600x400.png?text=Image+4',
    'https://via.placeholder.com/600x400.png?text=Image+5',
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
      items: imgList.map((item) => Container(
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
            child: Image.network(item, fit: BoxFit.cover, width: 1000),
          ),
        ),
      )).toList(),
    );
  }
}
