import 'package:flutter/material.dart';

import '../../pages/StoreProfileScreens/StoreProfilePage.dart';

class CartStoreWidget extends StatefulWidget {
  final String id;
  final String name;
  final String url;
  const CartStoreWidget(
      {super.key, required this.id, required this.name, required this.url});

  @override
  State<CartStoreWidget> createState() => _CartStoreWidgetState();
}

class _CartStoreWidgetState extends State<CartStoreWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Container(
        width: MediaQuery.of(context).size.height,
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  foregroundColor: Color(0xFF33907C),
                  backgroundColor: Color(0xFF33907C),
                  backgroundImage: NetworkImage(widget.url),
                ),
                const SizedBox(width: 22),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'StoreProfilePage',
                      arguments: StoreProfileData(
                        widget.id,
                      ),
                    );
                  },
                  child: Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      //do thing
                    },
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Color(0xFF33907C),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
