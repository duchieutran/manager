import 'package:appdemo/screens/home/home_tabfeed/widgets/feed_textlogo.dart';
import 'package:appdemo/services/api_service/home_sevice.dart';
import '../../../models/model_user.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FeedSreen extends StatefulWidget {
  const FeedSreen({super.key});

  @override
  State<FeedSreen> createState() => _FeedSreenState();
}

class _FeedSreenState extends State<FeedSreen> {
  List<ModelUser> users = [];
  bool _isLoading = true;

  getData() async {
    final List<ModelUser> tmp = await HomeSevice().getData();
    setState(() {
      users = tmp;
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : users.isEmpty
            ? const Center(
                child: Text("Không Có Giá Trị !"),
              )
            : CarouselSlider.builder(
                itemCount: users.length,
                itemBuilder: (context, index, realIndex) {
                  final user = users[index];
                  return Card(
                    elevation: 10,
                    color: const Color(0xFF7FCCF0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  FeedTextlogo().textLogo(
                                      text: "V", color: Colors.purple),
                                  FeedTextlogo()
                                      .textLogo(text: "I", color: Colors.red),
                                  FeedTextlogo().textLogo(
                                      text: "S", color: Colors.yellow),
                                  FeedTextlogo()
                                      .textLogo(text: "A", color: Colors.green),
                                ]),
                              ),
                              ClipOval(
                                  child: Image(
                                image: NetworkImage(user.image),
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
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
                options:
                    CarouselOptions(enableInfiniteScroll: true, height: 230));
  }
}
