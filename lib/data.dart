import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:reels/searchmodule.dart';

class ApiData extends StatefulWidget {
  const ApiData({super.key});

  @override
  State<ApiData> createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> {
  List<SearchModule> list = [];
  Future<List<SearchModule>> getdata() async {
    final response = await http
        .get(Uri.parse('http://universities.hipolabs.com/search?name='));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> map in data) {
        list.add(SearchModule.fromJson(map));
        filtered.addAll(list);
      }
    }
    return list;
  }

  @override
  void initState() {
    getdata();

    super.initState();
  }

  List<SearchModule> filtered = [];
  void search(String val) {
    setState(() {
      if (val.isEmpty) {
        filtered.addAll(list);
      } else {
        filtered = list
            .where((e) => e.country.toLowerCase().contains(val.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(dumyList[1]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: Column(
        children: [
          SizedBox(
              width: 200,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search country',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    return filtered.addAll(list);
                  });
                  setState(() {
                    search(value);
                  });
                },
              )),
          Expanded(
            child: FutureBuilder(
                future: getdata(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('error agya ha bhai'));
                  } else {
                    return ListView.builder(
                        itemCount: filtered.length >= 100000 ? 20 : 0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            subtitle: Text(filtered[index].country),
                            title: Text(filtered[index].name),
                            leading: Text(filtered[index].stateProvince),
                            // trailing: Text(data.webPages.first),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
