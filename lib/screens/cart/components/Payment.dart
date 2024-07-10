import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/provider/loginProvider.dart';
import 'package:shop_app/screens/cart/components/LocationProvider.dart';
import 'package:shop_app/screens/cart/components/MapScreen.dart';
import 'package:shop_app/server/Order.dart'; // Import your OrderServices class

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
  bool _isLoading = false; // Add a loading state variable
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
    double drawerWidth =
        MediaQuery.of(context).size.width; // 80% of screen width
    double drawerHeight =
        MediaQuery.of(context).size.height * 0.5; // Full screen height

    return ChangeNotifierProvider(
      create: (_) => LocationProvider(),
      child: Consumer<LocationProvider>(
        builder: (context, locationProvider, _) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                        hintText: "61",
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 9, // Set the maximum length
                      onChanged: (value) {
                        setState(() {
                          if (value.length <= 9) {
                            _phoneNumber = value;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  _isLoading // Show loading indicator if _isLoading is true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : widget.cartItems.isEmpty // Check if cart is empty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Your cart is empty!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                                child: const Text('Pay'),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true; // Start loading
                                  });
                                  double totalPrice = calculateTotalPrice();
                                  int totalProducts = widget.cartItems.length;
                                  List<String> productNames = widget.cartItems
                                      .map((cartItem) => cartItem.product.title)
                                      .toList();

                                  // Access UserProvider instance and retrieve user ID
                                  String userId = Provider.of<UserProvider>(context,
                                              listen: false)
                                          .userId ??
                                      'Unknown';

                                  // Create an instance of OrderServices
                                  final OrderServices orderServices = OrderServices();

                                  // Construct the order object
                                  Order order = Order(
                                    user: userId,
                                    payment: _paymentMethod,
                                    products: widget.cartItems
                                        .map((cartItem) => cartItem.product)
                                        .toList(),
                                    total: totalPrice,
                                    note:
                                        'Optional note here', // Add your note here if needed
                                    phone: _phoneNumber,
                                  );

                                  try {
                                    // Call the order method from OrderServices
                                    Order newOrder = await orderServices.order(
                                      user: order.user!,
                                      payment: order.payment!,
                                      products: order.products!,
                                      total: order.total!,
                                      note: order.note!,
                                      phone: order.phone!,
                                    );

                                    // Show snackbar for successful order
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Order successful!'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } catch (error) {
                                    // Show snackbar for error
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Failed to place order: $error'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  } finally {
                                    // Stop loading
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }

                                  // Close the drawer
                                  Navigator.pop(context);
                                },
                                child: const Text('Pay'),
                              ),
                            ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
