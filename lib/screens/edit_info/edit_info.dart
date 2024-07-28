import 'package:appdemo/global/app_router.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/provider/edit_provider.dart';
import 'package:appdemo/screens/add_info/widgets/add_info_textfield.dart';
import 'package:appdemo/widgets/main_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditInfo extends StatefulWidget {
  const EditInfo({super.key, required this.user});
  final ModelUser user;

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditProvider>().defaultValueTextField(widget.user);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EditProvider>();

    return Scaffold(
      appBar: MainAppBar(
        title: "Edit Information",
        fontSize: 25,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRouter.home, arguments: false),
        ),
        colorLeading: Colors.black,
        kToolbarHeight: 80,
        flexiblaSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(171, 233, 241, 1),
              Color.fromARGB(255, 58, 165, 236),
            ]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            padding: const EdgeInsets.symmetric(vertical: 80),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 207, 250),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: const Color.fromARGB(255, 182, 48, 180), width: 8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EditTextfield(
                    controller: provider.nameController,
                    title: 'Name',
                    hintText: 'Type your name',
                    icon: const Icon(Icons.person),
                    textInputType: TextInputType.name),
                EditTextfield(
                    controller: provider.ageController,
                    title: 'Age',
                    hintText: 'Type your age',
                    icon: const Icon(Icons.cake),
                    textInputType: TextInputType.number),
                EditTextfield(
                    controller: provider.addressController,
                    title: 'Address',
                    hintText: 'Type your address',
                    icon: const Icon(Icons.location_city),
                    textInputType: TextInputType.name),
                EditTextfield(
                    controller: provider.emailController,
                    title: 'Email',
                    hintText: 'Type your email',
                    icon: const Icon(Icons.email),
                    textInputType: TextInputType.name),
                EditTextfield(
                    controller: provider.imageController,
                    title: 'Image',
                    hintText: 'Type your image',
                    icon: const Icon(Icons.image),
                    textInputType: TextInputType.name),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 101, 179, 243)),
                  onPressed: () {
                    _checkValidate(provider, context);
                  },
                  child: const Text(
                    'Thay đổi',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Align(
            child: Container(
              margin: const EdgeInsets.all(5),
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 101, 179, 243),
                border: Border.all(width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(45)),
              ),
              child: const Icon(
                Icons.edit,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> _checkValidate(
      EditProvider provider, BuildContext content) async {
    if (provider.checkEmpty()) {
      _showDialog(
          title: "Ôi Đại Vương",
          content: "Ngài không được để trống các ô đâu =))");
    } else {
      if (!await provider.loadImg()) {
        if (mounted) {
          _showDialog(
              title: "Ôi Đại Vương",
              content: "Ngài sai định dạng URL ảnh rồi.");
        }
      } else {
        await provider.updateData(widget.user.id);
        if (provider.checkData) {
          _showDialog(
              title: "Đại Vương",
              content: "Ngài tuyệt vời lắm !",
              action: () {
                Navigator.of(context)
                    .pushNamed(AppRouter.home, arguments: false);
              });
        } else {
          _showDialog(
              title: "Ôi Đại Vương",
              content: "Không được rồi thưa ngài !",
              action: () {
                Navigator.of(context)
                    .pushNamed(AppRouter.home, arguments: false);
              });
        }
      }
    }
  }

  void _showDialog(
      {required String title, required String content, VoidCallback? action}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (action != null) action();
              },
            ),
          ],
        );
      },
    );
  }
}
