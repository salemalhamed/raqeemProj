import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:raqeem/core/views/widgets/onbwidget.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controlr = PageController();
  var isLastpage = false;
  @override
  void dispose() {
    controlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 80),
                  child: PageView(
                    controller: controlr,
                    onPageChanged: (inex) {
                      setState(() {
                        isLastpage = inex == 2;
                      });
                    },
                    children: [
                      onbordpage(
                          imagg: "assets/images/on1.png",
                          imggg: "assets/images/on11.png"),
                      onbordpage(
                          imagg: "assets/images/on2.png",
                          imggg: "assets/images/on22.png"),
                      Stack(children: [
                        onbordpage(
                            imagg: "assets/images/onnb3.png",
                            imggg: "assets/images/texonb.png"),
                        Positioned(
                            top: 250,
                            left: 0,
                            height: 140,
                            width: 400,
                            child: Image.asset(
                              "assets/images/catgory33.png",
                              fit: BoxFit.fill,
                            ))
                      ]),
                    ],
                  ),
                ),
                Positioned(
                  child: TextButton(
                      onPressed: () {
                        controlr.jumpToPage(2);
                      },
                      child: Text(
                        'تخطي',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF5252A3),
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
            bottomSheet: isLastpage
                ? TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(430, 80),
                      backgroundColor: Color(0xFF5252A3),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/log");
                    },
                    child: Text(
                      "ابداء",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            backgroundColor: Color.fromARGB(161, 230, 230, 230)
                                .withOpacity(0.5),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 25,
                              color: Color(0xFF5252A3),
                            ),
                            onPressed: () {
                              controlr.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: SmoothPageIndicator(
                              controller: controlr,
                              count: 3,
                              effect: ExpandingDotsEffect(
                                spacing: 5.0,
                                radius: 5.0,
                                dotWidth: 10.0,
                                dotHeight: 10.0,
                                dotColor: Colors.black26,
                                activeDotColor: Color(0xFF5252A3),
                              ),
                              onDotClicked: (index) => controlr.animateToPage(
                                index,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
