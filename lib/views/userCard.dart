import 'package:flutter/material.dart';
import 'package:kronos/constants.dart';
import 'package:kronos/models/user.dart';

class userCard extends StatefulWidget {
  final User? user;

  const userCard({Key? key, required this.user}) : super(key: key);

  @override
  State<userCard> createState() => _userCardState();
}

class _userCardState extends State<userCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: greyLightColor,
      width: size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.24,
              child: Image.network(
                widget.user!.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 204,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            padding: const EdgeInsets.only(
              bottom: 20.0,
              top: 18.0,
              left: 14.0,
              right: 8.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lat: " + widget.user!.lat.toString(),
                  style: kronosH1Black,
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  "lon: " + widget.user!.lon.toString(),
                  style: kronosH1Black,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.phone, size: 12.0, color: primaryColor),
                    SizedBox(width: 4.0),
                    Text(
                      widget.user!.phone.toString(),
                      style: kronosH2Black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.email, size: 12.0, color: secondaryColor),
                    SizedBox(width: 4.0),
                    Text(
                      widget.user!.email.toString(),
                      style: kronosH2Black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  widget.user!.name + " " + widget.user!.lastname,
                  style: kronosH4Black,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
