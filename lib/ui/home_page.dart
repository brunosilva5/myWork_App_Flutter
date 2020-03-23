import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("myWork"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text("Works"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            DrawerHeader(
              child: Text("Olá Bruno!",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),),
              decoration: BoxDecoration(
                color: Colors.teal
              ),
            ),
            ListTile(
              title: Text("Perfil"),
              leading: Icon(
                Icons.person
              ),
              onTap:(){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Estatisticas"),
              leading: Icon(
                Icons.trending_up
              ),
              onTap:(){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Sair"),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              onTap:(){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      );
  }
}