import 'dart:convert';

import 'package:api/Models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<PostModel> postList=[];
  Future<List<PostModel>> getPostApi() async{
    final response =await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for (Map i in data) {
        postList.add(PostModel.fromJson(i));
      }

      return postList;

    }else{
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [

            Expanded(
              child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount:  postList.length,
                      itemBuilder: (context, index) {

                        return Text(index.toString());
                      },
                    );
                  }else{
                   print('run');


                    return Text('loading..');

                  }

              },),
            )
          ],
        ),
      ),
    );
  }
}
