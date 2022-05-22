import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

Future<void> checkGps() async {
  Location location = new Location();
  bool? check;
  PermissionStatus permissions;
  LocationData locationData;
  check = await location.serviceEnabled();
  if (check) {
    permissions = await location.hasPermission();
    if (permissions == PermissionStatus.granted) {
      locationData = await location.getLocation();
      print(locationData.longitude.toString());
    } else {
      permissions = await location.requestPermission();
      if (permissions == PermissionStatus.granted) {
        print("good2");
        locationData = await location.getLocation();
        print(locationData.longitude.toString());
      } else {
        SystemNavigator.pop();
      }
    }
  } else {
    check = await location.requestService();
    if (check) {
      permissions = await location.hasPermission();
      if (permissions == PermissionStatus.granted) {
        print("good");
        locationData = await location.getLocation();
        print(locationData.longitude.toString());
      } else {
        permissions = await location.requestPermission();
        if (permissions == PermissionStatus.granted) {
          print("good2");
          locationData = await location.getLocation();
          print(locationData.longitude.toString());
        } else {
          SystemNavigator.pop();
        }
      }
    } else {
      SystemNavigator.pop();
    }
  }
}
