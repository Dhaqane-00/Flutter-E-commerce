import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:shop_app/server/Product.dart';

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
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
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

                        return const SizedBox.shrink(); // here by default width and height is 0
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
