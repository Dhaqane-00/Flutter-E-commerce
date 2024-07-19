
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset:
                        const Offset(0, 2), // changes position of shadow
                  ),
                ]),
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset:
                        const Offset(0, 2), // changes position of shadow
                  ),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                "https://flutterbackend-production-d4d0.up.railway.app/public/uploads/468aa3ca-d26f-4b85-a268-08db7a96fad1.png",
                fit: BoxFit.cover,
                height: 70,
                width: 70,
              ),
            ),
          )
        ],
      ),
    );
  }
}
