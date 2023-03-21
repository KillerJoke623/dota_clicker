import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dota_clicker/pages/ClickPage.dart';


class TreasuresPage extends StatefulWidget {
  const TreasuresPage({super.key});

  @override
  TreasuresPageState createState() => TreasuresPageState();
}

class TreasuresPageState extends State<TreasuresPage> {
  //bool isSelectionMode = false;
  // final int listLength = 30;
  //late List<bool> _selected;
  List<Treasure> treasures = [];
  bool _isGridMode = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    //initializeSelection();
  }

  // void initializeSelection() {
  //   _selected = List<bool>.generate(listLength, (_) => false);
  // }
  //
  // @override
  // void dispose() {
  //   _selected.clear();
  //   super.dispose();
  // }

  Future<void> fetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    final url = Uri.parse(
        'https://api.steampowered.com/IEconDOTA2_570/GetGameItems/v1/?key=1F8ECDB3440E28B8ABF5F44C755CD007');

    final response = await http.get(url);


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final treasuresJson = data['result']['items'];

      final newTreasures = treasuresJson
          .fold<Map<String, Treasure>>({}, (map, treasureJson) {
        final treasure = Treasure.fromJson(treasureJson);
        map[treasure.name] = treasure;
        return map;
      })
          .values
          .toList();
      setState(() {
        treasures = newTreasures;
      });
    }
    else{
      setState((){
        treasures = [
          Treasure(
            name: 'Treasure of the Elemental Trophy',
            items: [
              Item(name: 'Arms of the Elemental Trophy', price: 223.99),
              Item(name: 'Cape of the Elemental Trophy', price: 167.18),
              Item(name: 'Helm of the Elemental Trophy', price: 130.39),
              Item(name: 'Shoulders of the Elemental Trophy', price: 100.72),
              Item(name: 'Bracers of the Elemental Trophy', price: 58.49),
              Item(name: 'Belt of the Elemental Trophy', price: 37.45),
              Item(name: 'Sword of the Elemental Trophy', price: 22.94),
              Item(name: 'Offhand Blade of the Elemental Trophy', price: 14.48),
            ],
            price: 2.49,
          ),
          Treasure(
            name: 'Treasure of the Dark Implements',
            items: [
              Item(name: 'Dark Ruin Helm', price: 349.32),
              Item(name: 'Dark Ruin Shoulders', price: 187.44),
              Item(name: 'Dark Ruin Armor', price: 173.77),
              Item(name: 'Dark Ruin Gauntlets', price: 115.26),
              Item(name: 'Dark Ruin Belt', price: 81.31),
              Item(name: 'Dark Ruin Greaves', price: 68.01),
              Item(name: 'Dark Ruin Wings', price: 41.22),
              Item(name: 'Dark Ruin Blade', price: 28.01),
            ],
            price: 3.44,
          ),
          Treasure(
            name: 'Treasure of the Enigmatic Wanderer',
            items: [
              Item(name: 'Enigmatic Wanderer Hat', price: 318.02),
              Item(name: 'Enigmatic Wanderer Shoulder', price: 149.05),
              Item(name: 'Enigmatic Wanderer Robe', price: 139.58),
              Item(name: 'Enigmatic Wanderer Sleeves', price: 77.81),
              Item(name: 'Enigmatic Wanderer Belt', price: 71.49),
              Item(name: 'Enigmatic Wanderer Gloves', price: 58.69),
              Item(name: 'Enigmatic Wanderer Staff', price: 35.22),
              Item(name: 'Enigmatic Wanderer Pet', price: 21.42),
            ],
            price: 2.49,
          ),
          Treasure(
            name: 'Sculptor\'s Pillar 2020',
            items: [
              Item(name: 'Sculptor\'s Pillar Bracers', price: 340.11),
              Item(name: 'Sculptor\'s Pillar Shoulder', price: 224.31),
              Item(name: 'Sculptor\'s Pillar Cape', price: 172.58),
              Item(name: 'Sculptor\'s Pillar Crown', price: 164.32),
              Item(name: 'Sculptor\'s Pillar Staff', price: 96.27),
              Item(name: 'Sculptor\'s Pillar Sculpture', price: 41.29),
           ],
            price: 2.49,
          ),
      ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: const Text(
          //   'ListTile selection',
          // ),
          actions: <Widget>[
            if (_isGridMode)
              IconButton(
                icon: const Icon(Icons.grid_on),
                onPressed: () {
                  setState(() {
                    _isGridMode = false;
                  });
                },
              )
            else
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  setState(() {
                    _isGridMode = true;
                  });
                },
              ),
          ],
        ),
        body: _isGridMode
            ? GridBuilder(
          treasures: treasures,
        )
            : ListBuilder(

        )
    );
  }
}

class CollectionCard extends StatelessWidget {
  final Treasure treasure;

  ClickPage clickPage = ClickPage.instance;

  CollectionCard({required this.treasure});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/7/75/Cosmetic_icon_Treasure_of_the_Elemental_Trophy.png/revision/latest/scale-to-width-down/256?cb=20140704021045'),
          Text(
            treasure.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Price: ${treasure.price}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          ElevatedButton(onPressed: buyTreasure,child: Text('Buy for \$${treasure.price}'))
        ],
      ),
    );
  }
  void buyTreasure() {
    if (clickPage.money.value>=treasure.price) {
      clickPage.setMoney(clickPage.money.value - treasure.price);
    }

  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    super.key,
    required this.treasures,
    // required this.isSelectionMode,
    // required this.onSelectionChange,
  });

  final List<Treasure> treasures;

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        ),
        itemCount: widget.treasures.length,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return CollectionCard(treasure: widget.treasures[index]);
        },
    );

  }
}



class ListBuilder extends StatefulWidget {
  const ListBuilder({
    super.key,
    // required this.selectedList,
    // required this.isSelectionMode,
    // required this.onSelectionChange,
  });

  // final bool isSelectionMode;
  // final List<bool> selectedList;
  // final Function(bool)? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  void _toggle(int index) {
    // if (widget.isSelectionMode) {
    //   setState(() {
    //     widget.selectedList[index] = !widget.selectedList[index];
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 30,
        itemBuilder: (_, int index) {
          return ListTile(
              onTap: () => _toggle(index),
              // onLongPress: () {
              //   if (!widget.isSelectionMode) {
              //     setState(() {
              //       widget.selectedList[index] = true;
              //     });
              //     widget.onSelectionChange!(true);
              //   }
              // },

              //     ? Checkbox(
              //   value: widget.selectedList[index],
              //   onChanged: (bool? x) => _toggle(index),
              // )
              //     : const SizedBox.shrink(),
              title: Text('item $index'));
        });
  }
}

class Treasure {
  String name;
  List<Item> items;
  double price;

  Treasure({required this.name, required this.items, required this.price});

  factory Treasure.fromJson(Map<String, dynamic> json) {
    final itemName = json['name'] as String;
    final itemPrices = json['items'] as List<dynamic>;
    final treasPrice =  json['cost'] as double;

    final items = itemPrices
        .map((item) => Item(name: item['name'], price: item['cost']))
        .toList();

    return Treasure(name: itemName, items: items, price: treasPrice);
  }

  @override
  String toString() {
    final sb = StringBuffer();
    sb.writeln('Collection: $name');
    for (final item in items) {
      sb.writeln('  Item: ${item.name}, Price: ${item.price}');
    }
    return sb.toString();
  }
}

class Item {
  String name;
  double price;

  Item({required this.name, required this.price});
}

