import 'package:flutter/material.dart';
import 'package:food_rider_app/ui/screens/home/delivery_body.dart';
import 'package:food_rider_app/ui/screens/home/history_body.dart';
import 'package:food_rider_app/ui/screens/home/map_body.dart';
import 'package:food_rider_app/ui/screens/home/status_body.dart';
import 'package:food_rider_app/ui/screens/home/wallet_body.dart';

List<Widget> bottomNavList = <Widget>[
  StatusBody(),
  DeliveryBody(),
  MapBody(),
  HistoryBody(),
  WalletBody()
];