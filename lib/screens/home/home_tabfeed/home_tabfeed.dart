import 'package:appdemo/global/img_path.dart';
import 'package:appdemo/provider/home_provider.dart';
import 'package:appdemo/screens/home/home_tabfeed/widgets/feed_textlogo.dart';
import 'package:appdemo/screens/home/widgets/home_dialog.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FeedSreen extends StatefulWidget {
  const FeedSreen({super.key});

  @override
  State<FeedSreen> createState() => _FeedSreenState();
}

class _FeedSreenState extends State<FeedSreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final init = Provider.of<HomeProvider>(context, listen: false);
      init.getData();
      init.setLoading(true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return homeProvider.getLoading()
            ? const Center(child: CircularProgressIndicator())
            : homeProvider.users.isEmpty
                ? const ShowCustomDialog(
                    title: 'Ôi Đại Vương',
                    content: 'Đại vương ơi, Không có dữ liệu !')
                // TODO : showDialog
                : CarouselSlider.builder(
                    itemCount: homeProvider.users.length,
                    itemBuilder: (context, index, realIndex) {
                      final user = homeProvider.users[index];
                      return Card(
                        elevation: 10,
                        color: const Color(0xFF7FCCF0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(children: [
                                      FeedTextlogo().textLogo(
                                          text: "V", color: Colors.purple),
                                      FeedTextlogo().textLogo(
                                          text: "I", color: Colors.red),
                                      FeedTextlogo().textLogo(
                                          text: "S", color: Colors.yellow),
                                      FeedTextlogo().textLogo(
                                          text: "A", color: Colors.green),
                                    ]),
                                  ),
                                  ClipOval(
                                      child: Image.network(
                                    user.image,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      ImgPath().logoGit,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                user.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Country : ${user.address}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                        enableInfiniteScroll: true, height: 230),
                  );
      },
    );
  }
}
