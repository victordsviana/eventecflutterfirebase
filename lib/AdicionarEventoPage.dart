import 'package:flutter/material.dart';

class AdicionarEventoPage extends StatefulWidget {
  final Function(String, String, String) onAdicionarEvento;

  AdicionarEventoPage({required this.onAdicionarEvento});

  @override
  _AdicionarEventoPageState createState() => _AdicionarEventoPageState();
}

class _AdicionarEventoPageState extends State<AdicionarEventoPage> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Evento'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextFormField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextFormField(
              controller: _dataController,
              decoration: InputDecoration(labelText: 'Data'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onAdicionarEvento(
                  _tituloController.text,
                  _descricaoController.text,
                  _dataController.text,
                );
              },
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
