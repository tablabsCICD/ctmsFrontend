
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetCityList extends StatefulWidget {

  @override
  _GetCityListState createState() => _GetCityListState();
}

class _GetCityListState extends State<GetCityList> {
  List<dynamic> foundCity = [];
  List<dynamic> uniquFoundCity = [];
  List<dynamic> cityList = [];

  getCity() async {
    String myUrl = 'https://api.tkdost.com/tkd2/api/get/cities/db';
    var req = await http.get(Uri.parse(myUrl));
    var response = json.decode(req.body);
    setState(() {
      cityList = response;
    });
    foundCity = cityList.toSet().toList();
  }

  @override
  initState() {
    getCity();
    foundCity = cityList..toSet().toList();
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = cityList;
    } else {
      results = cityList
          .where((user) =>
          user.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundCity = results.toSet().toList();
    //  foundCity = uniquFoundCity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage('assets/images/truck.png'),
            ),
          ),
        ),
        AlertDialog(
          title: Text('Select City'),
          content: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const SizedBox(
                //   height: 20,
                // ),
                TextField(
                  onChanged: (value) => _runFilter(value),
                  decoration: const InputDecoration(
                      labelText: 'Search', suffixIcon: Icon(Icons.search)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 500,
                  width: 300,
                  child: foundCity.isNotEmpty
                      ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: foundCity.length,
                    itemBuilder: (context, index) =>
                        Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pop(context,[foundCity[index].toString(),foundCity[index].toString()]);
                              },
                              title: Text(foundCity[index]),
                            ),
                            Divider(),
                          ],
                        ),

                  )
                      : const Text(
                    'No results found',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
