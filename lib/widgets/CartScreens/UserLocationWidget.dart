import 'package:flutter/material.dart';

class UserLocationWidget extends StatefulWidget {
  final String userName;
  final String phone;
  final String address;
  const UserLocationWidget(
      {super.key,
      required this.userName,
      required this.phone,
      required this.address});

  @override
  State<UserLocationWidget> createState() => _UserLocationWidgetState();
}

class _UserLocationWidgetState extends State<UserLocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      color: Colors.white,
      padding: EdgeInsets.all(13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              Text(
                widget.phone,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              Text(
                widget.address,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'AddNewAddressPage');
            },
            child: Container(
              height: 20,
              width: 94,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Color(0xFF33907C),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Change',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
