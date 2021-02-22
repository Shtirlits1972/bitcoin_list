import 'package:flutter/material.dart';
import 'CCData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CCList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CCListState();
  }
}

class CCListState extends State<CCList> {

  List<CCData> data = List<CCData>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin for SourceIT'),
      ),
      body: Container(
        child: ListView(
          children: _buildList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadCC(),
      ),
    );
  }

  _loadCC() async {
    final response =
        await http.get('https://api.coincap.io/v2/assets?limit=100');

    if (response.statusCode == 200) {
      var allData = (json.decode(response.body) as Map)['data'];
      // print(allData);
      var ccDataList = List<CCData>();

      allData.forEach((dynamic val) {
        var record = CCData(
            name: val['name'],
            symbol: val['symbol'],
            rank: int.parse(val['rank']),
            price: double.parse(val['priceUsd']));

        ccDataList.add(record);
      });
      //print(ccDataList.length.toString());
      setState(() {
        data = ccDataList;
      });
    }
  }

  List<Widget> _buildList() {
    return data
        .map((CCData f) => ListTile(
              title: Text(f.name),
              subtitle: Text(f.symbol),
              leading: CircleAvatar(
                child: Text(f.rank.toString()),
              ),
              trailing: Text('\$${f.price.toStringAsFixed(2)}'),
            ))
        .toList();
  }

      @override
      void initState(){
          super.initState();
          _loadCC();
      }

}
//}
