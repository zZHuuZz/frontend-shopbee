// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shopbee/pages/StoreProfileScreens/StoreProfilePage.dart';

class FollowStoreWidget extends StatefulWidget {
  final String name;
  final String id;
  final String url;
  const FollowStoreWidget(
      {super.key, required this.name, required this.id, required this.url});

  @override
  State<FollowStoreWidget> createState() => _FollowStoreWidgetState();
}

class _FollowStoreWidgetState extends State<FollowStoreWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(106, 158, 158, 158),
          width: 2,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Align(
              alignment: const Alignment(0, -1),
              child: FractionallySizedBox(
                heightFactor: .4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  child: Container(
                    foregroundDecoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/followstore_devonly.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              )),
          Align(
            alignment: const Alignment(-1, 1),
            child: FractionallySizedBox(
              heightFactor: .6,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Column(
                    children: [
                      const SizedBox(height: 14),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 35),
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            //add follow api
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Container(
                              width: 86,
                              height: 23,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: const Color(0xFF33907C),
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Follow",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.25),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xFF33907C),
              foregroundColor: Colors.white,
              backgroundImage: NetworkImage(widget.url),
            ),
          ),
        ],
      ),
    );
  }
}
