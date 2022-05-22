import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
   final String? name;
   final Color? c;

  SignButton({@required this.name,this.c,} );

  @override
  Widget build(BuildContext context) {
    return

      Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(color: Colors.black38,
                blurRadius: 2)
          ] ,
          color: c,
        ),
        height: MediaQuery.of(context).size.height/15,
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text(name!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),




          ],
        ),

      );
  }
}
