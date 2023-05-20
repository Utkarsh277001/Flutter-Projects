import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FitnessNewsScreen extends StatefulWidget {
  @override
  _FitnessNewsScreenState createState() => _FitnessNewsScreenState();
}

class _FitnessNewsScreenState extends State<FitnessNewsScreen> {
  Future<List<dynamic>> fetchFitnessNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=Workout&from=2023-03-28&sortBy=publishedAt&apiKey=e5733f0bb7bc4576adff908b2b6d6abf'));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var result = json.decode(response.body);
      return result['articles'];
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load fitness news');
    }
  }

  List<dynamic> _articles = [];

  @override
  void initState() {
    super.initState();
    fetchFitnessNews().then((value) {
      setState(() {
        _articles = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness News'),
      ),
      body: ListView.builder(
        itemCount: _articles.length,
        itemBuilder: (BuildContext context, int index) {
          final article = _articles[index];
          return ListTile(
            title: Text(article['title']),
            subtitle: Text(article['description']),
            onTap: () {
              // Open the article in a browser or a WebView
            },
          );
        },
      ),
    );
  }
}
