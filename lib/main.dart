import 'package:flutter/material.dart';
import 'package:squaretest/models/squaremodel.dart';
import 'package:http/http.dart' as http;
import 'package:squaretest/utilities/locator.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SquareApi>? data;

  Future<List<SquareApi>> callApplicantApi() async {
    var result = await http.get(
      Uri.parse('https://api.github.com/orgs/square/repos'),
    );
    try {
      if (result.statusCode == 200) {
        debugPrint(result.body.toString());
        return squareApiFromJson(result.body.toString());
      } else if (result.statusCode == 404) {
        return [SquareApi(name: 'error')];
      } else {
        throw Exception('failed to load');
      }
    } catch (e) {}
    throw Exception('invalid data parsing');
  }

  Future<void> apicall() async {
    data = await callApplicantApi();
  }

  @override
  void initState() {
    super.initState();
    apicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (data != null) {
                      return ListTile(
                        title: Text(data![index].name!),
                      );
                    } else {
                      return const ListTile(
                        title: Text('no data found yet'),
                      );
                    }
                  },
                  itemCount: data!.length,
                ),
              )
            ]),
      ),
    );
  }
}
