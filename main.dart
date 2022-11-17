import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';





Future<Post> fetchPost() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}

class Home extends StatelessWidget {
  const Home ({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Bienvenidos a flutter", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
    );
  }
}

class Usuarios extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Catalogo de usuarios", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
    );
  }
} 

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

void main() => runApp( MyApp());

class MyApp extends StatefulWidget {
   @override
  State<MyApp> createState() => _MyAppState();
  
}

class _MyAppState extends State<MyApp> {
  int _paginaActual=0;
  List<Widget> _paginas = [Home(), Usuarios()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Consumir información de internet'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},child: Icon(Icons.people_alt_outlined,),
        ),
        body:  Padding(
          padding: const EdgeInsets.all(15.0),
          child: _paginas[_paginaActual],/*Center(
            child: FutureBuilder<Post>(
              future: fetchPost(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.title);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // Por defecto, muestra un loading spinner
                return CircularProgressIndicator();
              },
            ),
      ),*/
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            setState(() {
              _paginaActual=index;
            });
          },
          currentIndex: _paginaActual,
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline_sharp), label: "Usuarios"),

        ]),
      ),
    );
  }
}