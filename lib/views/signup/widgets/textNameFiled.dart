import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextNameField extends StatelessWidget {
  GlobalKey<FormState> k1 = GlobalKey<FormState>();
  late final String hintname;
   final TextInputType _widgets;
   final TextEditingController _nameController;

  TextNameField(this.hintname,this._widgets,this._nameController,this.k1);
  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
        // inputFormatters: [
        //   FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
        // ],
maxLength: 16,
        controller: _nameController,
        keyboardType:_widgets,
        validator: (value) {
          if (value!.isEmpty ||
              value.length<5) {
            return "Name is Short";

          } else {
            return null;
          }
        },
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),

          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(6.0),
            borderSide: new BorderSide(),

          ),

          hintStyle: TextStyle(color: Colors.black26),
          hintText: ("Your Name"),
        ),
      );
  }
}
