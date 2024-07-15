import 'package:appdemo/global/app_router.dart';
import 'package:appdemo/services/api_service/home_sevice.dart';
import 'package:flutter/cupertino.dart';
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
        title: "INFOMATION",
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
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShowInfoButton(
                      func: () {},
                      icon: Icons.mail,
                      text: "email",
                      bgColor: Colors.blue,
                    ),
                    ShowInfoButton(
                      func: () {},
                      icon: Icons.phone,
                      text: "phone",
                      bgColor: Colors.red,
                    )
                  ],
                ),
              ),
              ShowInfoButton(
                func: () => Navigator.of(context)
                    .pushNamed(AppRouter.editinfo, arguments: user),
                text: "Edit Infomation",
                bgColor: Colors.green,
                icon: Icons.edit,
              ),
              ShowInfoButton(
                func: () => _showConfirmationDialog(context),
                text: "Delete Profile",
                bgColor: Colors.red,
                icon: Icons.delete,
              )
            ],
          ),
        ),
        ShowInfoAvatar(image: user.image)
      ]),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Wowww"),
          content: const Text("Are you sure you want to delete =)) ?"),
          actions: [
            CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                HomeService().deteleData(user.id);
                Navigator.of(context)
                    .pushNamed(AppRouter.home, arguments: true);
              },
            ),
          ],
        );
      },
    );
  }
}
