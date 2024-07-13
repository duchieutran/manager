import 'package:appdemo/global/img_path.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    // width: 300.0,
                    height: 240.0,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image(image: AssetImage(ImgPath().bgFB)),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: ClipOval(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1)),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 90, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        "Tran Duc Hieu",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '(DEV)',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ])
                  ],
                ),
              )
            ],
          ),
          Positioned(
            left: 30,
            top: 150,
            child: Stack(children: [
              ClipOval(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 5,
                      color: Colors.black,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(75)),
                  ),
                  child: Image(image: AssetImage(ImgPath().logoFB)),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: ClipOval(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1)),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        )),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
