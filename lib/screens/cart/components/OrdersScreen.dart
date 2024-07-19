import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';
import 'package:shop_app/screens/cart/components/ComponentsOrder/MyProfile.dart';

// Example data structure for ordered products
class Product {
  final String name;
  final String imageUrl;
  final double price;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      imageUrl: json['images'][0],
      price: json['salePrice'].toDouble(),
    );
  }
}

class Order {
  final String id;
  final String status;
  final List<Product> products;
  final int itemCount;

  Order({
    required this.id,
    required this.status,
    required this.products,
    required this.itemCount,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<Product> products = (json['products'] as List)
        .map((item) => Product.fromJson(item['product']))
        .toList();

    return Order(
      id: json['_id'],
      status: "Packed", // assuming the status is packed for simplicity
      products: products,
      itemCount: products.length,
    );
  }
}

class OrdersScreen extends StatelessWidget {
  static String routeName = '/OrdersScreen';

  // Example order data
  final List<Order> orders = [
    Order.fromJson({
      "_id": "668fa6341b2069589c3fe62f",
      "products": [
        {
          "product": {
            "name": "PUMA x LAMELO BALL",
            "images": [
              "https://flutterbackend-production-d4d0.up.railway.app/public/uploads/f97f77b8-34e5-4d09-800c-35a13d0d9156.png"
            ],
            "salePrice": 0.01,
          }
        },
        {
          "product": {
            "name": "Nike Air Max",
            "images": [
              "https://flutterbackend-production-d4d0.up.railway.app/public/uploads/468aa3ca-d26f-4b85-a268-08db7a96fad1.png"
            ],
            "salePrice": 120.00,
          }
        },
        {
          "product": {
            "name": "Adidas Ultra Boost",
            "images": [
              "https://flutterbackend-production-d4d0.up.railway.app/public/uploads/4f98d2c5-80d4-4eb9-823c-b329a603b906.jpg"
            ],
            "salePrice": 180.00,
          }
        },
      ],
    }),
  ];

  OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //clip react
          MyProfile(),
          //list view
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("TO Receive",style: TextStyle(fontSize: 20), ),
                Text("Abdilaahi",style: TextStyle(fontSize: 20),),
              ],
            ),
          ),

          //Buttons Navigation
          MyAppicons(
            imageUrl: "assets/icons/Messages Icon.svg",
          )
          
        ],
      ),
    );
  }
}

class MyAppicons extends StatelessWidget {
  final String imageUrl;
  const MyAppicons({
    super.key,required this.imageUrl,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 120.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(imageUrl,width: 40,height: 40),
          ),
        ],
      ),
    );
  }
}
