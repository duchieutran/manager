import 'package:appdemo/services/api_service/home_sevice.dart';
import '../../../global/app_router.dart';
import '../../../models/model_user.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key, this.isLoading = true});
  final bool isLoading;

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  List<ModelUser> users = [];
  late bool _isloading;

  @override
  void initState() {
    _isloading = widget.isLoading;
    didChangeDependencies();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isloading) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : users.isEmpty
              ? const Center(
                  child: Text("No value !"),
                )
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRouter.showinfo, arguments: user),
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
      Positioned(
          bottom: 50,
          right: 50,
          child: ClipOval(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.editinfo);
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ))
    ]);
  }

  Future<void> getData() async {
    final List<ModelUser> tmp = await HomeSevice().getData();
    setState(() {
      users = tmp;
      _isloading = false;
    });
  }
}
