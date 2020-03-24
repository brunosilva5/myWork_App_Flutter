import 'package:flutter/material.dart';
import 'package:pt/helpers/work_helper.dart';
import 'package:pt/ui/work_page.dart';
import 'package:image/image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WorkHelper helper = WorkHelper();

  List<Work> works = List();

  @override
  void initState() {
    super.initState();

    _getAllWorks();
  }

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
          _showWorkPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: works.length,
        itemBuilder: (context, index) {
          return _workCard(context, index);
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("images/euu.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    "Olá Bruno!",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text("Perfil"),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Estatísticas"),
              leading: Icon(Icons.trending_up),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Sair"),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _workCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      works[index].name ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        //_showOptions(context, index);
      },
    );
  }

  void _showWorkPage({Work work}) async {
    final recWork = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorkPage(work: work)));
    if (recWork != null) {
      if (work != null) {
        await helper.updateWork(recWork);
      } else {
        await helper.saveWork(recWork);
      }
      _getAllWorks();
    }
  }

  void _getAllWorks() {
    helper.getAllWorks().then((list) {
      setState(() {
        works = list;
      });
    });
  }
}
