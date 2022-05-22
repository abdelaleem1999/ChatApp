import 'package:flutter/material.dart';


class TextLogin extends StatelessWidget {
  late final String textnamebold;
  late final String textname;
  late final String widgetNavigate;
  late final Widget _widget;


  TextLogin(
    this.textnamebold,this.textname,this.widgetNavigate,this._widget);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(textnamebold,

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(textname,
                  //   style: TextStyle(
                  //     fontSize: 15,
                  //     color:Color(0x61111118),
                  //   ),),
                  // InkWell(
                  //   onTap: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>_widget));
                  //   },
                  //   child: Text(widgetNavigate,
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //      color:  Color(0xfd319cc6),
                  //     ),),
                  // ),
                ],
              ),
              // Image.asset("assets/images/telegram.webp")



            ],
          ),



    );
  }
}
