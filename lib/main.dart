import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // _fetchPost();
    storePost();
  }

  Future<void> storePost() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'title': 'Anas Title',
        'body': 'This is the body of the post',
        'userId': 1,
      }),
    );

    if (res.statusCode == 201) {
      print(json.decode(res.body)['id']);
      // 201 Created
      print('Post created successfully: ');
    } else {
      print('Failed to create post:');
    }
  }

  Future<void> _fetchPost() async {
    final res =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (res.statusCode == 200) {
      var jsonResponse = json.decode(res.body); // استجابة تكون قائمة
      print(jsonResponse[0]
          ['userId']); // الوصول للعنصر الأول في القائمة وطباعة "id"
    } else {
      print('error in your API call');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
