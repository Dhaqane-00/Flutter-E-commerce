import 'package:flutter/material.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
    required this.onNumOfItemsChange,
  }) : super(key: key);

  final Product product;
  final Function(int) onNumOfItemsChange;

  @override
  _ColorDotsState createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int numOfItems = 1;

  void incrementNumOfItems() {
    setState(() {
      numOfItems++;
    });
    widget.onNumOfItemsChange(numOfItems);
    showSnackbar('Item added');
  }

  void decrementNumOfItems() {
    if (numOfItems > 1) {
      setState(() {
        numOfItems--;
      });
      widget.onNumOfItemsChange(numOfItems);
      showSnackbar('Item removed');
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1), // Adjust duration as needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: decrementNumOfItems,
          ),
          const SizedBox(width: 20),
          Text(
            '$numOfItems',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: incrementNumOfItems,
          ),
        ],
      ),
    );
  }
}
