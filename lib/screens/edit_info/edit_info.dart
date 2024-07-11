import 'package:appdemo/global/app_router.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/screens/add_info/widgets/add_info_textfield.dart';
import 'package:appdemo/screens/home/home_tabhome/widgets/check_img.dart';
import 'package:appdemo/services/api_service/home_sevice.dart';
import 'package:appdemo/widgets/main_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditInfo extends StatefulWidget {
  const EditInfo({super.key, required this.user});
  final ModelUser user;

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  late ModelUser _user;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController imageController;
  late TextEditingController idController;
  late TextEditingController ageController;
  late ModelUser _userUpdate;

  @override
  void initState() {
    _user = widget.user;
    nameController = TextEditingController(text: _user.name);
    emailController = TextEditingController(text: _user.email);
    addressController = TextEditingController(text: _user.address);
    imageController = TextEditingController(text: _user.image);
    idController = TextEditingController(text: _user.id);
    ageController = TextEditingController(text: '${_user.age}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Edit Infomation",
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
                    controller: nameController,
                    title: 'Name',
                    hintText: 'Type your name',
                    icon: const Icon(Icons.person),
                    textInputType: TextInputType.name),
                EditTextfield(
                    controller: ageController,
                    title: 'Age',
                    hintText: 'Type your age',
                    icon: const Icon(Icons.cake),
                    textInputType: TextInputType.number),
                EditTextfield(
                    controller: addressController,
                    title: 'Address',
                    hintText: 'Type your address',
                    icon: const Icon(Icons.location_city),
                    textInputType: TextInputType.name),
                EditTextfield(
                    controller: emailController,
                    title: 'Email',
                    hintText: 'Type your email',
                    icon: const Icon(Icons.email),
                    textInputType: TextInputType.name),
                EditTextfield(
                    controller: imageController,
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
                    _checkValidate();
                  },
                  child: const Text(
                    'Submit',
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

  Future<void> _checkValidate() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        addressController.text.isEmpty ||
        imageController.text.isEmpty ||
        ageController.text.runtimeType != int) {
      if (mounted) {
        _showDialog(
            title: "Validation Error", content: "Please fill in all fields.");
      }
    } else {
      if (!await CheckImg().loadImg(imageController.text)) {
        if (mounted) {
          _showDialog(title: "Error", content: "Invalid image URL.");
        }
      } else {
        await _updateData();
        if (mounted) {
          _showDialog(
              title: "Success",
              content: "Add profile complete.",
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

  Future<void> _updateData() async {
    _userUpdate = ModelUser(
        id: _user.id,
        name: nameController.text,
        age: int.tryParse(ageController.text) ?? 0,
        address: addressController.text,
        email: emailController.text,
        image: imageController.text);
    await HomeSevice().updateData(_userUpdate.id, _userUpdate.toJSON());
  }
}
