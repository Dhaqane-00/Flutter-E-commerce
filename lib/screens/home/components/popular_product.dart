import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:shop_app/server/Product.dart';
import 'package:shimmer/shimmer.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductServices().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Popular Products",
            press: () {
              Navigator.pushNamed(context, ProductsScreen.routeName);
            },
          ),
        ),
        FutureBuilder<List<Product>>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Use ShimmerLoading class while loading
              return const ShimmerLoading(
                itemCount: 5,  // Number of shimmer items to display
                width: 150,    // Width of shimmer item
                height: 200,   // Height of shimmer item
              );
            } else if (snapshot.hasError) {
              return const ShimmerLoading(
                itemCount: 5,  // Number of shimmer items to display
                width: 150,    // Width of shimmer item
                height: 200,   // Height of shimmer item
              );
              print(snapshot.error);
              return const Center(child: Text('Failed to load products'));
            } else {
              List<Product> products = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      products.length,
                      (index) {
                        if (products[index].isPopular) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: ProductCard(
                              product: products[index],
                              onPress: () => Navigator.pushNamed(
                                context,
                                DetailsScreen.routeName,
                                arguments: ProductDetailsArguments(
                                    product: products[index]),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink(); // Default width and height is 0
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}


class ShimmerLoading extends StatelessWidget {
  final int itemCount;
  final double width;
  final double height;

  const ShimmerLoading({
    Key? key,
    this.itemCount = 5, // Default to 5 items
    this.width = 150,   // Default width
    this.height = 200,  // Default height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}