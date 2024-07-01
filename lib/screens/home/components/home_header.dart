import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/CartProvider.dart';
import 'package:shop_app/provider/ProductProvider.dart';
import 'package:shop_app/screens/home/components/SearchResultsScreen.dart';
import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                return SearchField(
                  onSearch: productProvider.searchProducts,
                  onSubmit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultsScreen(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Consumer<CartNotifier>(
            builder: (context, cartNotifier, child) => IconBtnWithCounter(
              svgSrc: "assets/icons/Cart Icon.svg",
              numOfitem: cartNotifier.itemCount,
              press: () => Navigator.pushNamed(context, CartScreen.routeName),
            ),
          ),
          const SizedBox(width: 8),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
