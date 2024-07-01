import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/ProductProvider.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shimmer/shimmer.dart';

import 'search_field.dart'; // Import your SearchField component

class SearchResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search',style: TextStyle(fontSize: 23),),
        centerTitle: true,
        leading: Container(), // Use Container() instead of Text("") for cleaner leading
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  return SearchField(
                    onSearch: productProvider.searchProducts,
                    onSubmit: () {},
                  );
                },
              ),
            ),
            Expanded(
              flex: 10,
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  if (productProvider.isLoading) {
                    return _buildShimmerEffect(); // Show shimmer effect while loading
                  } else if (productProvider.error.isNotEmpty) {
                    return _buildShimmerEffect(); // Show shimmer effect while Error
                    return Center(child: Text('Error: ${productProvider.error}'));
                  } else {
                    return GridView.builder(
                      itemCount: productProvider.searchResults.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        product: productProvider.searchResults[index],
                        onPress: () => Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: ProductDetailsArguments(
                            product: productProvider.searchResults[index],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return GridView.builder(
      itemCount: 12, // Adjust the number of shimmer items as needed
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 0.7,
        mainAxisSpacing: 20,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const ProductCardShimmer(), // Custom shimmer product card widget
      ),
    );
  }
}

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: 100,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 4),
                Container(
                  height: 14,
                  width: 80,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
