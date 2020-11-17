import 'package:flutter/material.dart';
import '../model/aluno.dart';
import '../db/database_helper.dart';
import 'aluno_screen.dart';

class ListViewAluno extends StatefulWidget {
  @override
  _ListViewAlunoState createState() => new _ListViewAlunoState();
}


class _ListViewAlunoState extends State<ListViewAluno> {
  List<Aluno> items = new List();
  DatabaseHelper db = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    db.getAluno().then((alunos) {
      setState(() {
        alunos.forEach((aluno) {
          items.add(Aluno.fromMap(aluno));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Alunos'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: [
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].nome}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Row(children: [
                        Text('Curso: ${items[position].curso} - Cod: ${items[position].cod} - Turma: ${items[position].turma}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            )),
                      
                        IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _deleteAluno(
                                context, items[position], position)),
                      ]),
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple,
                        radius: 15.0,
                        child: Text(
                          '${items[position].id}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => _navigateToAluno(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewAluno(context),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  void _deleteAluno(BuildContext context, Aluno aluno, int position) async {
    db.deleteAluno(aluno.id).then((alunos) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToAluno(BuildContext context, Aluno aluno) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlunoScreen(aluno)),
    );
    if (result == 'update') {
      db.getAluno().then((alunos) {
        setState(() {
          items.clear();
          alunos.forEach((aluno) {
            items.add(Aluno.fromMap(aluno));
          });
        });
      });
    }
  }

  void _createNewAluno(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AlunoScreen(Aluno('', '', '', ''))),
    );
    if (result == 'save') {
      db.getAluno().then((alunos) {
        setState(() {
          items.clear();
          alunos.forEach((aluno) {
            items.add(Aluno.fromMap(aluno));
          });
        });
      });
    }
  }
}
