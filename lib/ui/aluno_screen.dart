import 'package:flutter/material.dart';
import '../model/aluno.dart';
import '../db/database_helper.dart';

class AlunoScreen extends StatefulWidget {
  final Aluno aluno;
  AlunoScreen(this.aluno);
  @override
  State<StatefulWidget> createState() => new _AlunoScreenState();
}

class _AlunoScreenState extends State<AlunoScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _nomeController;
  TextEditingController _cursoController;
  TextEditingController _codController;
  TextEditingController _turmaController;

  @override
  void initState() {
    super.initState();
    _nomeController = new TextEditingController(text: widget.aluno.nome);
    _cursoController = new TextEditingController(text: widget.aluno.curso);
    _codController =
        new TextEditingController(text: widget.aluno.cod);
    _turmaController = new TextEditingController(text: widget.aluno.turma);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aluno')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.network(
            'https://www.unifacef.com.br/wp-content/uploads/2015/04/Uni_FACEF_MUNICIPAL.png',
             width: 500,
             height: 300,
             alignment: Alignment.center,
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _cursoController,
              decoration: InputDecoration(labelText: 'Curso'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _codController,
              decoration: InputDecoration(labelText: 'Código'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _turmaController,
              decoration: InputDecoration(labelText: 'Turma'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.aluno.id != null)
                  ? Text('Alterar')
                  : Text('Inserir'),
              onPressed: () {
                if (widget.aluno.id != null) {
                  db.updateAluno(Aluno.fromMap({
                    'id': widget.aluno.id,
                    'nome': _nomeController.text,
                    'curso': _cursoController.text,
                    'cod': _codController.text,
                    'turma': _turmaController.text
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .inserirAluno(Aluno(
                          _nomeController.text,
                          _cursoController.text,
                          _codController.text,
                          _turmaController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}