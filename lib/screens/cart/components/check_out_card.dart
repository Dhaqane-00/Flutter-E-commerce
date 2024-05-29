import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/provider/loginProvider.dart';

import '../../../constants.dart';

class CheckoutCard extends StatelessWidget {
  final List<Cart> cartItems;

  const CheckoutCard({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  double calculateTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += item.product.price * item.numOfItem;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                const Spacer(),
                const Text("Add voucher code"),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "\$${calculateTotalPrice().toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return DrawerWidget(
                            cartItems: cartItems,
                          );
                        },
                      );
                    },
                    child: const Text("Check Out"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerWidget extends StatefulWidget {
  final List<Cart> cartItems;

  const DrawerWidget({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String _paymentMethod = 'EVC';
  String _phoneNumber = '';

  double calculateTotalPrice() {
    double total = 0;
    for (var item in widget.cartItems) {
      total += item.product.price * item.numOfItem;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double drawerWidth =
        MediaQuery.of(context).size.width ; // 80% of screen width
    double drawerHeight =
        MediaQuery.of(context).size.height * 0.4; // Full screen height

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        width: drawerWidth,
        height: drawerHeight,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Payment Method',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: const Text('EVC'),
              leading: Radio(
                value: 'EVC',
                groupValue: _paymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Cash'),
              leading: Radio(
                value: 'Cash',
                groupValue: _paymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                onPressed: () {
                  double totalPrice = calculateTotalPrice();
                  int totalProducts = widget.cartItems.length;
                  List<String> productNames = widget.cartItems
                      .map((cartItem) => cartItem.product.title)
                      .toList();
              
                  // Access UserProvider instance and retrieve user ID
                  String userId =
                      Provider.of<UserProvider>(context, listen: false).userId ??
                          'Unknown';
              
                  print('Total Amount: \$${totalPrice.toStringAsFixed(2)}');
                  print('Total Products: $totalProducts');
                  print('Product Names: $productNames');
                  print('User ID: $userId');
                  print('Payment Method: $_paymentMethod');
                  print('Phone Number: $_phoneNumber');
                  Navigator.pop(context);
                },
                child: const Text('Pay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
