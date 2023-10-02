import 'package:flutter/cupertino.dart';

class BaseProvider extends ChangeNotifier {
  String appState="Ideal";
  BaseProvider(this.appState){
  }
}