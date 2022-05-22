import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bonus/views/login/view.dart';

class PageViewDemo extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  static late int x = 0;

  final PageController _controller = PageController(
    initialPage: x,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PageController _controller = PageController(
      initialPage: x,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: PageView(
            physics:NeverScrollableScrollPhysics() ,
            controller: _controller,
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        child: Image.asset("assets/laughing-man-with-phone-chatting-with-his-friends-cartoon_1284-33369.jpg",
                        //assets/splash2.jpg
                        fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome in 'Bonus chat'  ",
                          style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold,
                            color: Color(0xff1063a5)
                          ),
                        ),
                        Icon(FontAwesomeIcons.comment,
                        color: Color(0xff1063a5),size: 32,)
                      ],
                    ),
                  ),                  Expanded(
flex: 2,                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // TextButton(onPressed: () {
                        //   Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => LoginView()));
                        //
                        // }, child: Text("تخطي")),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color(0xff1063a5)),
                            ),
                            onPressed: () {
                              if (_controller.hasClients && x > 2) {
                                _controller.animateToPage(
                                  x++,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              } else if (x <= 0) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginView()));
                              }
                            },
                            child: Container(
                              width: 80,
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Start",
                                  ),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

f(int x) {
  x = 0;

  x++;
}
