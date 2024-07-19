import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/provider/OrderProvider.dart';
import 'package:shop_app/provider/loginProvider.dart';
import 'package:shop_app/screens/cart/components/LocationProvider.dart';
import 'package:shop_app/screens/cart/components/MapScreen.dart';
import 'package:shop_app/screens/cart/components/PaymentSuccessScreen.dart';

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
  TextEditingController _locationController = TextEditingController();

  double calculateTotalPrice() {
    double total = 0;
    for (var item in widget.cartItems) {
      total += item.product.price * item.numOfItem;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double drawerWidth = MediaQuery.of(context).size.width;
    double drawerHeight = MediaQuery.of(context).size.height * 0.5;

    return Consumer2<LocationProvider, OrderProvider>(
      builder: (context, locationProvider, orderProvider, _) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            width: drawerWidth,
            height: drawerHeight,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: <Widget>[
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Payment Method',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 20),
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
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      hintText: "61",
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength: 9,
                    onChanged: (value) {
                      setState(() {
                        if (value.length <= 9) {
                          _phoneNumber = value;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _locationController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Location',
                          ),
                          readOnly: true,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          tooltip: 'Get Location',
                          icon: Icon(Icons.location_on, color: Colors.white),
                          onPressed: () async {
                            await locationProvider.getLocation(
                              context,
                              _locationController,
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          tooltip: 'Show Map',
                          icon: Icon(Icons.map, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MapScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ElevatedButton(
                        onPressed: widget.cartItems.isEmpty || orderProvider.orderState == OrderState.loading
                            ? null
                            : () async {
                                double totalPrice = calculateTotalPrice();
                                List<Map<String, dynamic>> products = widget.cartItems.map((cartItem) {
                                  return {
                                    'product': cartItem.product.id,
                                    'quantity': cartItem.numOfItem,
                                  };
                                }).toList();

                                String userId = Provider.of<UserProvider>(context, listen: false).userId ?? 'Unknown';

                                Order order = Order(
                                  user: userId,
                                  payment: _paymentMethod,
                                  products: products,
                                  total: totalPrice,
                                  note: _locationController.text,
                                  phone: _phoneNumber,
                                );

                                await orderProvider.placeOrder(
                                  order: order,
                                  onSuccess: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Order successful!'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    Navigator.pushNamed(context, PaymentSuccessScreen.routeName);
                                  },
                                  
                                  onError: (errorMessage) {
                                    print('Failed to place order: $errorMessage');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Failed to place order: $errorMessage'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                                );
                              },
                        child: const Text('Pay'),
                      ),
                    ),
                    if (orderProvider.orderState == OrderState.loading)
                      Positioned(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
