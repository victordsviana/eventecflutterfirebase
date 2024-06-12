import 'package:flutter/material.dart';
import 'adicionarEventoPage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'loginPage.dart';
import 'cadastroPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventosPage extends StatefulWidget {
  @override
  _EventosPageState createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('eventos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final eventos = snapshot.data!.docs.map((doc) {
            return {
              'titulo': doc['titulo'],
              'descricao': doc['descricao'],
              'data': doc['data'],
            };
          }).toList();
          return ListView.builder(
            itemCount: eventos.length,
            itemBuilder: (context, index) {
              return eventoCard(
                context,
                eventos[index]['titulo']!,
                eventos[index]['descricao']!,
                eventos[index]['data']!,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AdicionarEventoPage(onAdicionarEvento: adicionarEvento)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget eventoCard(
      BuildContext context, String titulo, String descricao, String data) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              titulo,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              descricao,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              data,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  _showSuccessModal(context);
                },
                child: Text('Inscrever-se'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showSuccessModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Inscrição Concluída'),
          content: Text('Você se inscreveu com sucesso no evento!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void adicionarEvento(String titulo, String descricao, String data) {
    _firestore.collection('eventos').add({
      'titulo': titulo,
      'descricao': descricao,
      'data': data,
    });
  }
}
