import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationSender extends StatefulWidget {
  LocationSender({
    this.location
});
  GeoPoint? location;

  @override
  _LocationSenderState createState() => _LocationSenderState();
}

class _LocationSenderState extends State<LocationSender> {

  @override
  Widget build(BuildContext context) {
    List<Marker> m = [
      Marker(
        markerId: MarkerId(
            " element.doc.id"
        ),
        position: LatLng(widget.location!.latitude,
            widget.location!.longitude),
      )


    ];

    return Scaffold(
      body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.topEnd,

            children: [
              Expanded(
                child: GoogleMap(

                  initialCameraPosition: CameraPosition(
                      bearing: 192.8334901395799,
                      target: LatLng(
                          widget.location!.latitude,
                          widget.location!.longitude
                      ),
                      zoom: 15),
                  markers:m.toSet()
                ),
              ),

            ],
          )
      ),
    );
  }
}
