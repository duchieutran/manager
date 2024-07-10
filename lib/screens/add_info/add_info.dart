import 'package:appdemo/global/app_router.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/screens/add_info/widgets/edit_textfield.dart';
import 'package:appdemo/services/api_service/home_sevice.dart';
import 'package:appdemo/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({super.key, });
  

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  late ModelUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Add Infomation",
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
                    hindText: 'Type your name',
                    icon: const Icon(Icons.person),
                    textInputType: TextInputType.name),
                EditTextfield(
                    controller: ageController,
                    title: 'Age',
                    hindText: 'Type your age',
                    icon: const Icon(Icons.person),
                    textInputType: TextInputType.number),
                EditTextfield(
                    controller: addressController,
                    title: 'Address',
                    hindText: 'Type your address',
                    icon: const Icon(Icons.person),
                    textInputType: TextInputType.name),
                EditTextfield(
                    controller: emailController,
                    title: 'Email',
                    hindText: 'Type your email',
                    icon: const Icon(Icons.person),
                    textInputType: TextInputType.name),
                EditTextfield(
                    controller: imageController,
                    title: 'Image',
                    hindText: 'Type your image',
                    icon: const Icon(Icons.person),
                    textInputType: TextInputType.name),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addUser,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
          // ShowInfoAvatar(image: user.image)
        ]),
      ),
    );
  }

  Future<void> _addUser() async {
    user = ModelUser(
      name: nameController.text,
      email: emailController.text,
      address: addressController.text,
      image: imageController.text,
      id: '',
      age: int.tryParse(ageController.text) ?? 0,
    );

    try {
      await HomeSevice().createData(user);
    } catch (e) {
      rethrow;
    }
  }
}
