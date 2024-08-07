import 'package:appdemo/widgets/main_connectivity.dart';
import '../../global/app_router.dart';
import '../../global/img_path.dart';
import 'widgets/login_more.dart';
import 'widgets/login_text.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  final controllerUser = TextEditingController();
  final controllerPass = TextEditingController();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController? _controllerUser;
  late TextEditingController? _controllerPass;

  @override
  void initState() {
    _controllerUser = widget.controllerUser;
    _controllerPass = widget.controllerPass;
    super.initState();
  }

  @override
  void dispose() {
    _controllerUser?.dispose();
    _controllerPass?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 218, 59, 243),
            Color.fromARGB(253, 100, 207, 226)
          ], end: Alignment.bottomLeft, begin: Alignment.topRight)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LoginText(
                      text: 'Login',
                      size: 40,
                      fontWeight: FontWeight.bold,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    const SizedBox(height: 15), // Thêm khoảng cách
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: _controllerUser,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          label: Text(
                            "email",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          hintText: 'type your email',
                          prefixIcon: Icon(Icons.person),
                          // suffixIcon: Icon(Icons.check),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: _controllerPass,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: const Text(
                            "pass",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          hintText: 'type your pass',
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove_red_eye)),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text('Forgot password?')),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRouter.home, arguments: false);
                        },
                        child: Container(
                          height: 45,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(99, 212, 220, 1),
                                Color.fromRGBO(224, 65, 248, 1)
                              ])),
                          child: const Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const LoginText(
                      text: 'Or Sign Up Using',
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoginMore(logo: ImgPath().logoFB),
                        LoginMore(logo: ImgPath().logoTW),
                        LoginMore(logo: ImgPath().logoGG),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const LoginText(
                      text: 'Or Sign Up Using',
                      mainAxisAlignment: MainAxisAlignment.center,
                      vertical: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const LoginText(
                              text: 'SIGN UP',
                              vertical: 0,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const ConnectivityStatusWidget()
      ]),
    );
  }
}
