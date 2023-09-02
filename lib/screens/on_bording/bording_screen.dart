import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:storeapp/screens/auth/shop_login_screen/login.dart';
import 'package:storeapp/service/helper_shared_pref.dart';

class BordingModel {
  String image;
  String title;
  String body;
  BordingModel({required this.image, required this.title, required this.body});
}

// ignore: must_be_immutable
class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  var pageController = PageController();
  bool lastScreen = false;
  List<BordingModel> bordingScreens = [
    BordingModel(
        image: "images/one.jpg", title: "title1", body: "body1"),
    BordingModel(
        image: "images/tow.jpg", title: "title2", body: "body2"),
    BordingModel(
        image: "images/there.jpg", title: "title3", body: "body3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  CachHelper.saveData(key: "onBoarding", value: true)
                      .then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopLogin(),
                        ),
                        (route) => false);
                  });
                },
                child: const Row(
                  children: [
                    Text(
                      "SKIP",
                      style: TextStyle(color: Colors.blue, fontSize: 17),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue,
                      size: 17,
                    )
                  ],
                ))
          ],
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (val) {
                  if (val == bordingScreens.length - 1) {
                    setState(() {
                      lastScreen = true;
                    });
                  } else {
                    lastScreen = false;
                  }
                },
                controller: pageController,
                itemBuilder: (context, index) => bording(bordingScreens[index]),
                itemCount: bordingScreens.length,
                physics: const BouncingScrollPhysics(),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SmoothPageIndicator(
                      effect:const ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: Colors.blue,
                          dotHeight: 15,
                          dotWidth: 7,
                          expansionFactor: 7,
                          radius: 10,
                          spacing: 10,
                          strokeWidth: 5),
                      controller: pageController,
                      count: bordingScreens.length),
                ),
                const SizedBox(
                  width: 220,
                ),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    if (lastScreen) {
                      CachHelper.saveData(key: "onBoarding", value: true)
                          .then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopLogin(),
                            ),
                            (route) => false);
                      });
                    } else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ));
  }

  Widget bording(BordingModel model) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.asset(
            model.image,
            fit: BoxFit.fitWidth,
          )),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              model.title,
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              model.body,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          )
        ],
      );
}
