import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dota_clicker/pages/UpdatePage.dart';

class ClickPage extends StatefulWidget {

  ClickPage._privateConstructor();

  static final ClickPage _instance = ClickPage._privateConstructor();

  static ClickPage get instance => _instance;



  // ClickPage({required Key key}) : super(key: key);
  // GlobalKey<_ClickPageState> _myKey = GlobalKey();

  ValueNotifier<double> money = ValueNotifier<double>(0);

  double tresPercents = 0;
  double tresPercentsLimit = 100;


  double get getMoney{
    return money.value;
  }

  setMoney(double nMoney){
    money.value=nMoney;
  }

  double get getPercents{
    return tresPercents;
  }

  setPercents(double nPercents){
    tresPercents=nPercents;
  }

  //final _ClickPageState() myAppState=new _ClickPageState();
  @override
  State<ClickPage> createState() => _ClickPageState();


  // void invokeStartMoneyPerSecond(){
  //   _myKey.currentState.startMoneyPerSecond();
  // }
}



class _ClickPageState extends State<ClickPage> {
  // double money = 0;
  // double tresPercents = 0;
  // double tresPercentsLimit = 100;

  ClickPage clickPage = ClickPage.instance;
  UpdatePage updPage = UpdatePage.instance;


  // final GlobalKey<_ClickPageState> _myClickPageState = GlobalKey<_ClickPageState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Flexible(flex: 1,
                child:Text('Earn money')),
            Flexible(flex: 10,
              child:ElevatedButton(onPressed: incrementMoney,
                  child: AnimatedBuilder(
                // [AnimatedBuilder] accepts any [Listenable] subtype.
                  animation: clickPage.money,
                  builder: (BuildContext context, Widget? child) {
                    return Text('${clickPage.money.value}');
                  }), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, double.infinity)),)),
            Flexible(flex: 1,
                child:Text('Find treasures')),
            Flexible(flex: 10,
              child:ElevatedButton(onPressed: incrementTreasure,child: Text('${clickPage.tresPercents.toStringAsFixed(3)}'+'%'), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, double.infinity))),),

          ],
        )
      )

    );
  }

  void incrementMoney() {
    setState(() {
      clickPage.setMoney(clickPage.money.value+updPage.getMoneyPerClick);
    });
  }

  void incrementTreasure() {
    setState(() {
      clickPage.setPercents(clickPage.tresPercents+updPage.getPercentsPerClick);
    });
  }

  // void startMoneyPerSecond() {
  //   setState(() {
  //     Timer.periodic(Duration(seconds:1), (timer) {
  //       clickPage.setMoney(clickPage.money.+updPage.getMoneyPerSecond);
  //     });
  //   });
  // }


}

