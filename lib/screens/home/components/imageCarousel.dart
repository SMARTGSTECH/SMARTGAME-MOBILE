import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
// import 'dart:html' as html;
import 'dart:convert';

class HomeImageCarousel extends StatefulWidget {
  const HomeImageCarousel({super.key});

  @override
  _HomeImageCarouselState createState() => _HomeImageCarouselState();
}

class _HomeImageCarouselState extends State<HomeImageCarousel> {
  // int currentIndex = 0; // Store current carousel index

  List<dynamic> dataList = [];

  Future<void> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse('https://webadmin.smartcryptobet.co/api/fetch-adverts'));

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        // print(data);
        // print(data["response"]["data"][0]["url"]);
        setState(() {
          dataList.add(data);
        });

        // print(dataList);
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('GET Request failed: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: buildCarousel()),
    );
  }

  Widget buildCarousel() {
    return dataList.isEmpty
        ? Lottie.asset(
            "assets/images/beiLoader.json",
            height: 80,
            width: 80,
          )
        : Column(
            children: [
              Container(
                  height: 320,
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: CarouselSlider(
                    items: dataList.expand<Widget>((item) {
                      return (item["response"]["data"] as List<dynamic>)
                          .map<Widget>((innerItem) {
                        String imageUrl = innerItem['image'] ?? 'N/A';

                        return Container(
                          //  height: 320,
                          width: double.infinity,
                          margin: EdgeInsets.all(8.0),
                          child: Image.network(
                            'https://webadmin.smartcryptobet.co/images/ads/$imageUrl',
                            fit: BoxFit.cover,
                          ).cornerRadiusWithClipRRect(10),
                        ).onTap(() {
                          // html.window.open(innerItem['url'], '_blank');
                          print(innerItem['url']);
                        });
                      }).toList();
                    }).toList(),
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  (dataList.length * dataList[0]["response"]["data"].length)
                      .toInt(),
                  (index) {
                    return buildIndicator(index);
                  },
                ),
              ),
            ],
          );
  }

  Widget buildIndicator(int index) {
    return GestureDetector(
      onTap: () {
        _carouselController.animateToPage(index);
      },
      child: Container(
        width: 10.0,
        height: 10.0,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentIndex == index ? Colors.yellow : Colors.grey,
        ),
      ),
    );
  }

  int currentIndex = 0;
  final CarouselController _carouselController = CarouselController();
}
