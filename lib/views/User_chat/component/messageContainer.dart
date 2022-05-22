
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:bonus/views/User_chat/component/imageFullScreen.dart';
import 'package:bonus/views/User_chat/component/locationSender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageContainer extends StatelessWidget {
  MessageContainer({
    this.message,
    this.sender,
    this.isMe,
    this.time,
    this.isStrig,
    // this.isLocation,
    this.location,
    this.ISSend
});
  final String? message;
  final String? sender;
  final String? time;
  final bool? isMe;
  final String? isStrig;
  final String? ISSend;
  // final bool? isLocation;
  final GeoPoint? location;


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
       crossAxisAlignment:  isMe! ?CrossAxisAlignment.end
        :CrossAxisAlignment.start,
        children: [
          // Text("sender : "+sender!),
          Material(
             borderRadius: BorderRadius.only(
               topLeft:isMe!  ?isStrig=='phone'?Radius.circular(0) :Radius.circular(23)
                :isStrig=='phone'?Radius.circular(0)   :Radius.circular(23),
               bottomLeft: isMe!  ?isStrig=='phone'?Radius.circular(0) :Radius.circular(23)
        :isStrig=='phone'?Radius.circular(0)   :Radius.circular(0),
               bottomRight: isStrig=='phone'
    ? Radius.circular(0)
        :Radius.circular(23)
              ,
               topRight:isMe!  ?isStrig=='phone'?Radius.circular(0) :Radius.circular(0)
                   :isStrig=='phone'?Radius.circular(0)   :Radius.circular(23),
             ),
            color:  isMe! ? isStrig=='phone'|| isStrig=='location'?Color(0xFFBED6F6)
                :Color(0xFF2556BF)
                :isStrig=='phone' || isStrig=='location'?Color(0x6197979C)
                :Color(0x6131313E) ,
            child: Padding(
              padding: isStrig=='image' ?const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0)
                                        : const EdgeInsets.symmetric(horizontal: 17.0,vertical: 17),


                child: isStrig!='image' ?
                    isStrig=='phone' ? InkWell(
                      onTap: ()async{
                       await launch('tel:'+message!);
                        // مفروض هنا اروح للفون بتاع الموبيل
                      },
                      child: GestureDetector(
                        onLongPress: (){
                          Clipboard.setData(new ClipboardData(text: message));
                          Fluttertoast.showToast(
                            msg: 'phone copy',
                            gravity: ToastGravity.CENTER,
                          );

                        },
                        child: Text('$message' ,style: TextStyle(
                            decoration: TextDecoration.underline,

                            color: isMe! ? Colors.indigo
                                :Colors.indigo
                        ),
                          // هنا مفروض اقول لو الصوره لسه محملتش اي لسه مجتش من الفاير بيز اعرضلي لوووووودنج بس مش عارف اقولها ازاي
                        ),
                      ),
                    )
                 : isStrig=='location'
                    ?  InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationSender(
                            location: location!,
                          )));
                        },
                  child:Container(
                         width: MediaQuery.of(context).size.width/4.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('location',
                        ),
                        Icon(FontAwesomeIcons.mapMarkedAlt,
                        size: 17,color:Color(0xFFB31212) ,),
                      ],
                    ),
                  )
                        ,
                  )


             : GestureDetector(
                    onLongPress: (){
                      Clipboard.setData(new ClipboardData(text: message));
                      Fluttertoast.showToast(
                          msg: 'message copy',
                        gravity: ToastGravity.CENTER,
                             );

                    },
               child: Text('$message' ,style: TextStyle(
                  color: isMe! ? Colors.white
                      :Colors.black
                ),

                  // هنا مفروض اقول لو الصوره لسه محملتش اي لسه مجتش من الفاير بيز اعرضلي لوووووودنج بس مش عارف اقولها ازاي
                ),
             ) : message!.isEmpty ?

                      CircularProgressIndicator()
                //     :  io.File(x).exists() != null ?
                // Image.asset('assets/'+x)

             : InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageFullScreen(
                    image: message!,
                  )));
                },
                child: Container(

                  height: MediaQuery.of(context).size.height/2.5,
                  width: MediaQuery.of(context).size.width/1.56,
                  child: Image.network(message!,
                  loadingBuilder: (context, child, loadingProgress) {
                    if(loadingProgress==null)
                      return child;
                    return Padding(
                      padding: const EdgeInsets.only(right: 55,left: 55,bottom:83 ,top: 83.0),
                      child: CircularProgressIndicator(),
                    );

                  },errorBuilder: (context, error, stackTrace){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Error loading"),
                        FlatButton(onPressed: () {}, child: Text("Retry")),
                      ],
                    );
                    }
                    ,fit: BoxFit.cover,
                  ),
                ),
              )
            ),
          ),
          Text(time!),

        ],
      ),
    );
  }
}
