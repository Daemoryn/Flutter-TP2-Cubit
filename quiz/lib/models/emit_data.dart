class EmitData<Q, S, I, T, SP> {
  final Q _question;
  final S _score;
  final I _index;
  final T _tentatives;
  final SP _scorePrecedent;

  EmitData(this._question, this._score, this._index, this._tentatives, this._scorePrecedent);

  Q get question => _question;

  S get score => _score;

  I get index => _index;

  T get tentatives => _tentatives;

  SP get scorePrecedent => _scorePrecedent;
}