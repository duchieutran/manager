import 'package:appdemo/global/app_router.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/screens/add_info/widgets/add_info_textfield.dart';
import 'package:appdemo/screens/home/home_tabhome/widgets/home_tabhome_dialog.dart';
import 'package:appdemo/screens/home/home_tabhome/widgets/home_tabhome_provider.dart';
import 'package:appdemo/services/api_service/home_service.dart';
import 'package:appdemo/widgets/check_img.dart';
import 'package:appdemo/widgets/main_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  late List<ModelUser> filteredUsers;
  late TextEditingController _searchController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _imageController;
  late TextEditingController _ageController;
  String _key = 'id';
  List<String> fillerTitle = ['ID', 'Name', 'Address', 'Age', 'Email'];

  @override
  void initState() {
    _searchController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _imageController = TextEditingController();
    _ageController = TextEditingController();
    Provider.of<HomeTabhomeProvider>(context, listen: false)
        .getData(context: context);
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  // }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _imageController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    _showFilterDialog(context);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) {
                _searchShowInfo(value);
              },
            ),
          ),
          Expanded(child: Consumer<HomeTabhomeProvider>(
            builder: (context, value, child) {
              filteredUsers = value.filteredUsers;
              return filteredUsers.isEmpty
                  ? const MainProgress()
                  : ListView.builder(
                      itemCount: value.filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = value.filteredUsers[index];
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                flex: 1,
                                onPressed: (context) {
                                  Navigator.of(context).pushNamed(
                                      AppRouter.showinfo,
                                      arguments: user);
                                },
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: Icons.info,
                                label: 'Info',
                              )
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  setState(() {
                                    _showEditDialog(context, user);
                                  });
                                },
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Modify',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  setState(() {
                                    _showCancelDialog(
                                        context: context, userRemote: user);
                                  });
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () => Navigator.of(context).pushNamed(
                              AppRouter.showinfo,
                              arguments: user,
                            ),
                            leading: ClipOval(
                              child: Image(
                                image: NetworkImage(user.image),
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                            ),
                            title: Text(user.name),
                            subtitle: Text(user.email),
                          ),
                        );
                      },
                    );
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRouter.addinfo);
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 5, color: Colors.black),
              ),
              child: ListView.builder(
                itemCount: fillerTitle.length,
                itemBuilder: (context, index) {
                  final title = fillerTitle[index];
                  return RadioListTile(
                    value: title.toLowerCase(),
                    title: Text(title),
                    groupValue: _key,
                    onChanged: (value) {
                      setState(() {
                        _key = value!;
                      });
                      _searchShowInfo(_searchController.text);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _searchShowInfo(String value) async {
    // try {
    //   final List<ModelUser> tmp = await HomeService().searchData(_key, value);
    //   if (mounted) {
    //     setState(() {
    //       filteredUsers = tmp;
    //     });
    //   }
    // } catch (e) {
    //   if (mounted) {
    //     setState(() {
    //       filteredUsers = [];
    //       ApiError error = e as ApiError;
    //       HomeTabhomeDialog.showCustomDialog(
    //         context: context,
    //         title: "Message",
    //         content: error.errorMessage.toString(),
    //         action: () {},
    //       );
    //     });
    //   }
    // }
  }

  void _showEditDialog(BuildContext context, ModelUser user) {
    _nameController.text = user.name;
    _ageController.text = user.age.toString();
    _addressController.text = user.address;
    _emailController.text = user.email;
    _imageController.text = user.image;
    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text('Edit profile'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.6,
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
                    textInputType: TextInputType.name,
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
                    textInputType: TextInputType.url,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 101, 179, 243),
                    ),
                    onPressed: () {
                      _checkValidate(user.id);
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _checkValidate(String id) async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _imageController.text.isEmpty ||
        _ageController.text.isEmpty ||
        int.tryParse(_ageController.text) == null) {
      showCustomDialog(
          title: "Notification", content: "Fields cannot be empty.");
    } else {
      if (!await CheckImg().loadImg(_imageController.text)) {
        if (mounted) {
          showCustomDialog(title: 'Error', content: 'Invalid URL format');
        }
      } else {
        await _updateData(id);
        if (mounted) {
          HomeTabhomeDialog.showCustomDialog(
              context: context,
              title: "Success",
              content: "Information updated successfully.",
              action: () {
                Navigator.of(context).pop();
              });
        }
      }
    }
  }

  Future<void> _updateData(String id) async {
    ModelUser userUpdate = ModelUser(
        id: id,
        name: _nameController.text,
        age: int.tryParse(_ageController.text) ?? 0,
        address: _addressController.text,
        email: _emailController.text,
        image: _imageController.text);
    await HomeService().updateData(userUpdate.id, userUpdate.toJSON());

    // setState(() {
    //   final index = filteredUsers.indexWhere((value) => value.id == id);
    //   filteredUsers[index] = userUpdate;
    // });
  }

  void _showCancelDialog(
      {required BuildContext context, required ModelUser userRemote}) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Notification"),
          content: const Text("Are you sure you want delete =))) ??? "),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              onPressed: () async {
                Navigator.of(context).pop();
                // setState(() {
                //   filteredUsers.remove(userRemote);
                // });
                bool _deleteSuccess = await _deletaData(id: userRemote.id);
                if (_deleteSuccess) {
                  showCustomDialog(
                      title: 'Success', content: 'User deleted successfully.');
                } else {
                  // setState(() {
                  //   filteredUsers.add(userRemote);
                  // });

                  showCustomDialog(
                      title: 'Error',
                      content: 'Failed to delete the user from the server.');
                }
                _searchShowInfo(_searchController.text);
              },
              child: const Text("Okee"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _deletaData({required String id}) async {
    try {
      await HomeService().deteleData(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  showCustomDialog({required String title, required String content}) {
    HomeTabhomeDialog.showCustomDialog(
        context: context, title: title, content: content);
  }
}
