import 'package:appdemo/services/api_service/home_sevice.dart';
import 'package:flutter/material.dart';
import 'package:appdemo/models/model_user.dart';
import '../../../global/app_router.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key, this.isLoading = true});

  final bool isLoading;

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  List<ModelUser> filteredUsers = [];
  late bool _isLoading;
  late TextEditingController _searchController;
  String _key = 'id';

  @override
  void initState() {
    _isLoading = widget.isLoading;
    _searchController = TextEditingController();
    didChangeDependencies();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      getData();
    }
  }

  Future<void> _searchShowInfo(String value) async {
    try {
      final List<ModelUser> tmp = await HomeSevice().searchData(_key, value);
      setState(() {
        filteredUsers = tmp;
      });
    } catch (e) {
      setState(() {
        filteredUsers = [];
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
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
            Expanded(
              flex: 9,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : filteredUsers.isEmpty
                      ? const Center(
                          child: Text("No value ! "),
                        )
                      : ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = filteredUsers[index];
                            return ListTile(
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
                            );
                          },
                        ),
            ),
          ],
        ),
        Positioned(
          bottom: 30,
          right: 50,
          child: ClipOval(
            child: FloatingActionButton(
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
          ),
        )
      ]),
    );
  }

  Future<void> getData() async {
    final List<ModelUser> tmp = await HomeSevice().getData();
    setState(() {
      filteredUsers = tmp;
      _isLoading = false;
    });
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 5, color: Colors.black),
              ),
              child: ListView(
                children: [
                  const ListTile(
                    title: Text('Please choose:'),
                  ),
                  RadioListTile<String>(
                    value: 'id',
                    title: const Text('ID'),
                    groupValue: _key,
                    onChanged: (value) {
                      setModalState(() {
                        _key = value!;
                      });
                      _searchShowInfo(_searchController.text);
                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile<String>(
                    value: 'name',
                    title: const Text('Name'),
                    groupValue: _key,
                    onChanged: (value) {
                      setModalState(() {
                        _key = value!;
                      });
                      _searchShowInfo(_searchController.text);
                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile<String>(
                    value: 'address',
                    title: const Text('Address'),
                    groupValue: _key,
                    onChanged: (value) {
                      setModalState(() {
                        _key = value!;
                      });
                      _searchShowInfo(_searchController.text);
                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile<String>(
                    value: 'age',
                    title: const Text('Age'),
                    groupValue: _key,
                    onChanged: (value) {
                      setModalState(() {
                        _key = value!;
                      });
                      _searchShowInfo(_searchController.text);
                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile<String>(
                    value: 'email',
                    title: const Text('Email'),
                    groupValue: _key,
                    onChanged: (value) {
                      setModalState(() {
                        _key = value!;
                      });
                      _searchShowInfo(_searchController.text);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
