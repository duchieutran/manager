import 'package:appdemo/global/app_router.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/screens/add_info/widgets/add_info_textfield.dart';
import 'package:appdemo/services/api_service/home_sevice.dart';
import 'package:appdemo/widgets/main_app_bar.dart';
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
                  onPressed: () {
                    _updateData();
                  },
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
