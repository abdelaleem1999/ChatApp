import 'package:bonus/const/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserComponent extends StatefulWidget {
  UserComponent({
    this.image,
    this.name,
    this.message,
    this.id,
    this.numberOfMessage,
    this.time,
    this.Navigator,
    this.IsMe,
    this.IsString,
    this.ISLocation,
    this.seen,
    this.numberOgMessageUnread
  });

  final String? image;
  final String? name;
  final String? message;
  final int? id;
  final String? numberOfMessage;
  final String? time;
  final bool? IsMe;
  final bool? IsString;
  final String? ISLocation;
  final Widget? Navigator;
  final int? seen;
  final int? numberOgMessageUnread;

  _UserComponentState createState() => _UserComponentState();
}

class _UserComponentState extends State<UserComponent> {




  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            if(widget.message==SharedHelper.getEmail){
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Container(
                  height: 100,
                  child: Center(
                    child: Text("This your accaunt ^__^",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                    ),),
                  ),
                ),
              ));
              return  ;

              // Show snak bar "this your Account"

            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>widget.Navigator!));

            }
          },
          child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(29), // Image border
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(40), // Image radius
                            child: Image.asset(
                              widget.image!
                                , fit: BoxFit.cover),
                          ),
                        )

                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name!,
                          style: TextStyle(
                            color: Color(0xF8010811),
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        ),
                         widget.ISLocation=='text'

                         ?widget.message!.length<=25

                             ?Text( (widget.message!),
                            style: TextStyle(
                            color:widget.IsMe!  ? Color(0xF8D2D8E2)
                                :Color(0xF85084DC),
                            fontWeight: FontWeight.bold))
                             : Text( '.....'+(widget.message!.substring(0 ,25)),
                             style: TextStyle(
                                 color:widget.IsMe!  ? Color(0xF8D2D8E2)
                                     :Color(0xF85084DC),
                                 fontWeight: FontWeight.bold))

                            : widget.ISLocation=='image'
                                 ? Text( ("photo"),
                                 style: TextStyle(
                                     color:widget.IsMe!  ? Color(0xF8D2D8E2)
                                         :Color(0xF85084DC),
                                     fontWeight: FontWeight.bold))
                        :widget.ISLocation=='location' ?
                             Text('location'
                             ,style: TextStyle(
                                 color: widget.IsMe! ?Color(0xF8D2D8E2)
                                     :Color(0xF85084DC),
                               ),)
                        :  Text('phone number'
                               ,style: TextStyle(
                                 color: widget.IsMe! ?Color(0xF8D2D8E2)
                                     :Color(0xF85084DC),
                               ),) ,
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 9.0),
                        child: Text(widget.time!,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13
                          ),),
                      ),
            widget.seen!=0 ?

           Container(
             decoration: BoxDecoration(
                 color: Color(0xFF2556BF),

                 border: Border.all(
                   width: 5,
                   color: Color(0xFF2556BF),

                 ),
                 borderRadius: BorderRadius.circular(15)
             ),
           child: Text((widget.seen!).toString(),
           style: TextStyle(
             color: Colors.white
           ),),
           )



                :Text(''),
           //////////////////////////////////////////////////


                      // Stack(
                      //   alignment: AlignmentDirectional.center ,
                      //   children: [
                      //     CircleAvatar(
                      //       radius: 13,
                      //       backgroundColor: Colors.blue,),
                      //     Text(widget.numberOfMessage!,
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //     ),)
                      //   ],
                      // ),




          ///////////////////////////////////////////////////////
                    ],
                  )
                ],
              )),
        ),
        Divider(),
      ],
    );
  }
}
