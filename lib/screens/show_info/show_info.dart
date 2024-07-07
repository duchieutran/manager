import '../../models/model_user.dart';
import 'widgets/show_info_avatar.dart';
import 'widgets/show_info_button.dart';
import 'widgets/show_info_text.dart';
import '../../widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

class ShowInfo extends StatelessWidget {
  const ShowInfo({super.key, required this.user});
  final ModelUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Thông Tin Cá Nhân",
        fontSize: 25,
        colorLeading: Colors.black,
        kToolbarHeight: 80,
        flexiblaSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(171, 233, 241, 1),
            Color.fromARGB(255, 58, 165, 236)
          ])),
        ),
      ),
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          padding: const EdgeInsets.symmetric(vertical: 80),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 250, 207, 250),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                  color: const Color.fromARGB(255, 240, 161, 239), width: 8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ShowInfoText(
                text: "ID : #${user.id}",
                size: 30,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              ShowInfoText(
                text: "Name : ${user.name}",
                size: 20,
                fontWeight: FontWeight.bold,
              ),
              ShowInfoText(
                text: "Age : ${user.age}",
                size: 20,
                fontWeight: FontWeight.bold,
              ),
              ShowInfoText(
                text: "Address : ${user.address}",
                size: 20,
                fontWeight: FontWeight.bold,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShowInfoButton(
                      text: "email",
                      bgColor: Colors.blue,
                    ),
                    ShowInfoButton(
                      text: "phone",
                      bgColor: Colors.red,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        ShowInfoAvatar(image: user.image)
      ]),
    );
  }
}
