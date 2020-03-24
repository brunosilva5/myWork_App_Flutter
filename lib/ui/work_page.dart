import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pt/ui/home_page.dart';
import 'package:pt/helpers/work_helper.dart';


class WorkPage extends StatefulWidget {
  final Work work;

  WorkPage({this.work});

  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {

  final _nameController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;

  Work _editedWork;

  @override
  void initState() {
    super.initState();

    if (widget.work == null) {
      _editedWork = Work();
    } else {
      _editedWork = Work.fromMap(widget.work.toMap());

      _nameController.text = _editedWork.name;

    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(_editedWork.name ?? "Novo Trabalho"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editedWork.name != null && _editedWork.name.isNotEmpty) {
              Navigator.pop(context, _editedWork);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(
                  labelText: "Título",
                ),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editedWork.name = text;
                  });
                },
              ),
              Text(_editedWork.entrada == null ? "Nothing has been picked yet" 
              : _editedWork.entrada.toString()),
              RaisedButton(
                child: Text("Seleciona a data"),
                onPressed: (){
                  showDatePicker(
                    context: context,
                     initialDate: DateTime.now(), 
                     firstDate: DateTime(2017), 
                     lastDate: DateTime(2200),
                  ).then((date){
                    _editedWork.entrada = date;
                  });
                },
              ),
              RaisedButton(
                child: Text("Seleciona a data"),
                onPressed: (){
                  showDatePicker(
                    context: context,
                     initialDate: DateTime.now(), 
                     firstDate: DateTime(2017), 
                     lastDate: DateTime(2200),
                  ).then((date){
                    _editedWork.entrada = date;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}