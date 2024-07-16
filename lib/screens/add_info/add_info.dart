import 'package:appdemo/global/app_router.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/screens/add_info/widgets/add_info_textfield.dart';
import 'package:appdemo/widgets/check_img.dart';
import 'package:appdemo/services/api_service/home_service.dart';
import 'package:appdemo/widgets/main_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({
    super.key,
  });

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  // TODO : da xu ly
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _imageController.dispose();
    _idController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Add Information",
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
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              padding: const EdgeInsets.symmetric(vertical: 80),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 207, 250),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: const Color.fromARGB(255, 182, 48, 180),
                  width: 8,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EditTextfield(
                    controller: _nameController,
                    title: 'Name',
                    hintText: 'Type your name',
                    icon: const Icon(Icons.person),
                    textInputType: TextInputType.name,
                  ),
                  EditTextfield(
                    controller: _ageController,
                    title: 'Age',
                    hintText: 'Type your age',
                    icon: const Icon(Icons.cake),
                    textInputType: TextInputType.number,
                  ),
                  EditTextfield(
                    controller: _addressController,
                    title: 'Address',
                    hintText: 'Type your address',
                    icon: const Icon(Icons.location_city),
                    textInputType: TextInputType.text,
                  ),
                  EditTextfield(
                    controller: _emailController,
                    title: 'Email',
                    hintText: 'Type your email',
                    icon: const Icon(Icons.email),
                    textInputType: TextInputType.emailAddress,
                  ),
                  EditTextfield(
                    controller: _imageController,
                    title: 'Image',
                    hintText: 'Type your image',
                    icon: const Icon(Icons.image),
                    textInputType: TextInputType.text,
                  ),
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
            // TODO: da tim hieu
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
                  Icons.add,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkValidate() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _imageController.text.isEmpty) {
      // TODO: check mounted
      if (mounted) {
        _showDialog(
            title: "Validation Error", content: "Please fill in all fields.");
      }
    } else {
      if (!await CheckImg().loadImg(_imageController.text)) {
        if (mounted) {
          _showDialog(title: "Error", content: "Invalid image URL.");
        }
      } else {
        await _addUser();
        if (mounted) {
          _showDialog(
              title: "Success",
              content: "Add profile complete.",
              actions: [
                CupertinoDialogAction(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AppRouter.home, arguments: false);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text("Stay here"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]);
        }
      }
    }
  }

  void _showDialog(
      {required String title, required String content, List<Widget>? actions}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions ??
            [
              CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
      ),
    );
  }

  Future<void> _addUser() async {
    // TODO: da xu ly
    // neu khong can thiet phai dung den local thi khong can tao bien local
    ModelUser user = ModelUser(
      name: _nameController.text,
      email: _emailController.text,
      address: _addressController.text,
      image: _imageController.text,
      id: '',
      age: int.tryParse(_ageController.text) ?? 0,
    );

    try {
      await HomeService().createData(user);
    } catch (e) {
      rethrow;
    }
  }
}
