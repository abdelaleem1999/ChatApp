
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ImageFullScreen extends StatefulWidget {
  ImageFullScreen({
   this.image
});
final String? image;

  @override
  _ImageFullScreenState createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(CommunityMaterialIcons.arrow_left_thick,
              color: Color(0xFF2556BF)),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: ()async{
            print(widget.image!);
            print("123456889999999999");
            Fluttertoast.showToast(

                msg: "Downloading.....",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.teal,
                textColor: Colors.white,
                fontSize: 18.0
            );


            await GallerySaver.saveImage(widget.image!+".jpg");
            Fluttertoast.showToast(

                msg: "image saved ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Color(0xFF2556BF),
                textColor: Colors.white,
                fontSize: 18.0
            );




          },

              icon: Icon(Icons.download),
              color: Color(0xFF2556BF)),
        ],
      ),

      body: InkWell(
        onTap: ()async{
          print(widget.image!);
          print("123456889999999999");

          await GallerySaver.saveImage(widget.image!+".jpg");
          Fluttertoast.showToast(

              msg: "image saved ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.teal,
              textColor: Colors.white,
              fontSize: 18.0
          );




          // saveImage(widget.image!);
        },
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(widget.image!,
              loadingBuilder: (context, child, loadingProgress) {
                if(loadingProgress==null)
                  return child;
                return Padding(
                  padding: const EdgeInsets.only(right: 140,left: 140,bottom:300 ,top: 300.0),
                  child: CircularProgressIndicator(),
                );

              },errorBuilder: (context, error, stackTrace){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Couldn't load image"),
                    FlatButton(onPressed: () {}, child: Text("Retry")),
                  ],
                );
              }
              ,fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
// saveImage(String url) async {
//
//   final ByteData imageData = await NetworkAssetBundle(Uri.parse(url)).load("");
//   final Uint8List bytes = imageData.buffer.asUint8List();
// // display it with the Image.memory widget
//   Image.memory(bytes);}
