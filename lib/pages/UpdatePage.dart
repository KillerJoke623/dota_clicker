import 'dart:async';

import 'package:dota_clicker/pages/ClickPage.dart';

import 'package:flutter/material.dart';


class UpdatePage extends StatefulWidget {
  UpdatePage._privateConstructor();

  static final UpdatePage _instance = UpdatePage._privateConstructor();

  static UpdatePage get instance => _instance;



  double moneyPerClick = 0.1;
  double percentPerClick = 0.5;

  double moneyPerSecond = 0.0;
  double percentPerSecond = 0.0;

  double get getMoneyPerClick{
    return moneyPerClick;
  }

  setMoneyPerClick(double nMoneyPerClick){
    moneyPerClick=nMoneyPerClick;
  }

  double get getPercentsPerClick{
    return percentPerClick;
  }

  setPercentsPerClick(double nMoneyPerClick){
    percentPerClick=nMoneyPerClick;
  }

  double get getMoneyPerSecond{
    return moneyPerSecond;
  }

  setMoneyPerSecond(double nMoneyPerSecond){
    moneyPerSecond=nMoneyPerSecond;
  }

  double get getPercentsPerSecond{
    return percentPerSecond;
  }

  setPercentsPerSecond(double nMoneyPerSecond){
    percentPerSecond=nMoneyPerSecond;
  }

  @override
  State<UpdatePage> createState() => _UpdatePageState();



}

class _UpdatePageState extends State<UpdatePage> {

  ClickPage clickPage = ClickPage.instance;
  UpdatePage updPage = UpdatePage.instance;

  //final myKey = GlobalKey<ClickPageState>();

  double costUpgradeMoneyPerClick = 25;
  double costUpgradePercentPerClick = 50;

  double costUpgradeMoneyPerSecond = 50;
  double costUpgradePercentPerSecond = 100;




  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: Center(
    //         child: Column(
    //           children: [
    //             Flexible(flex: 10,
    //                 child:Flexible(child:ElevatedButton(onPressed: upgradeMoneyPerClick,child: Text('\$'+'$costUpgradeMoneyPerClick'), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, double.infinity)),))),
    //             Flexible(flex: 10,
    //               child:ElevatedButton(onPressed: upgradePercentPerClick,child: Text('$costUpgradePercentPerClick'+'%'), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, double.infinity))),),
    //
    //           ],
    //         )
    //     )
    // );

    //TODO: Update widget evry second if timer started, it needs to invoke method outside that class FUCK IT

    //TODO: Change buttons to tappable cards

    return Scaffold(
        body: Center(
        child: ListView(
          children: <Widget>[
            Expanded(
                child:Row(
                    children: <Widget>[
                      Flexible(child: Image.asset('images/Dollar_bill_and_small_change.jpg', package: 'images')),
                      Flexible(child: Text('Upgrade money per click')),
                      Flexible(child:ElevatedButton(onPressed: upgradeMoneyPerClick,child: Text('\$'+'$costUpgradeMoneyPerClick'), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 100)),)),
                      // Expanded(child: Container(color: Colors.red)),
                      // Expanded(child: Container(color: Colors.green)),
                    ]
                )
            ),
            Expanded(child: Row(
              children: <Widget>[
                Flexible(child: Image.asset('images/Dollar_bill_and_small_change.jpg', package: 'images')),
                Flexible(child: Text('Upgrade money per click')),
                Flexible(child:ElevatedButton(onPressed: upgradeMoneyPerClick,child: Text('\$'+'$costUpgradeMoneyPerClick'), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 100)),)),
                // Expanded(child: Container(color: Colors.red)),
                // Expanded(child: Container(color: Colors.green)),
              ]
            )
            ),
            Expanded(
                child:Row(
                    children: <Widget>[
                      Flexible(child: Image.asset('images/Dollar_bill_and_small_change.jpg', package: 'images')),
                      Flexible(child: Text('Upgrade money per second')),
                      Flexible(child:ElevatedButton(onPressed: upgradeMoneyPerSecond,child: Text('\$'+'$costUpgradeMoneyPerSecond'), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 100)),)),
                      // Expanded(child: Container(color: Colors.red)),
                      // Expanded(child: Container(color: Colors.green)),
                    ]
                )
            ),
          ],
        ))
    );
    }

    void upgradeMoneyPerClick() {
      if (clickPage.money.value>=costUpgradeMoneyPerClick){
      setState(() {
        clickPage.setMoney(clickPage.money.value-costUpgradeMoneyPerClick);
        costUpgradeMoneyPerClick*=1.5;
        updPage.setMoneyPerClick(updPage.moneyPerClick+1);
      });
      }
    }
    void upgradePercentPerClick() {
      setState(() {
        clickPage.setMoney(clickPage.money.value-costUpgradePercentPerClick);
        costUpgradeMoneyPerClick=costUpgradeMoneyPerClick*1.5;
        updPage.setPercentsPerClick(updPage.getPercentsPerClick+1);
      });
    }

    void upgradeMoneyPerSecond() {
    setState(() {
      clickPage.setMoney(clickPage.money.value-costUpgradeMoneyPerSecond);
      costUpgradeMoneyPerSecond=costUpgradeMoneyPerSecond*1.5;
      if(updPage.getMoneyPerSecond==0.0){
        //Here i need to invoke this method
        //clickPage.invokeStartMoneyPerSecond();
        //myKey.currentState!.startMoneyPerSecond();
        startMoneyPerSecond();

      }
      updPage.setMoneyPerSecond(updPage.getMoneyPerSecond+1);

    });
    }

  void startMoneyPerSecond() {
    setState(() {
      Timer.periodic(Duration(seconds:1), (timer) {
        clickPage.setMoney(clickPage.money.value+updPage.getMoneyPerSecond);
      });
    });
  }

    void upgradePercentPerSecond() {
    setState(() {
      clickPage.setMoney(clickPage.money.value-costUpgradePercentPerSecond);
      costUpgradePercentPerSecond=costUpgradePercentPerSecond*1.5;
      updPage.setPercentsPerSecond(updPage.getPercentsPerSecond+1);

      
    });
  }
    
    
}



