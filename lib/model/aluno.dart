class Aluno {
  int _id;
  String _nome;
  String _curso;
  String _cod;
  String _turma;

  Aluno(
      this._nome, this._curso, this._cod, this._turma);

  Aluno.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._curso = obj['curso'];
    this._cod = obj['cod'];
    this._turma = obj['turma'];
  }

  int get id => _id;
  String get nome => _nome;
  String get curso => _curso;
  String get cod => _cod;
  String get turma => _turma;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['curso'] = _curso;
    map['cod'] = _cod;
    map['turma'] = _turma;
    return map;
  }

  Aluno.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._curso = map['curso'];
    this._cod = map['cod'];
    this._turma = map['turma'];
  }
}
