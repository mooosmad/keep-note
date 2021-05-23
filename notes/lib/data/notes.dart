
class DataNotes {
  String titre;
  String note;
  int j;
  int m;
  int y;
  int heure;
  int minute;

  DataNotes(this.titre, this.note, this.j, this.m, this.y, this.heure,
      this.minute);


  Map<String, dynamic> toMap() {
    return {
      "titre": titre,
      "note": note,
      "jour": j,
      "mois": m,
      "annee": y,
      "heure": heure,
      "minute": minute,
    };
  }

  factory DataNotes.fromMap(Map<String, dynamic> map) {
    return DataNotes(
      map["titre"],
      map["note"],
      map["jour"],
      map["mois"],
      map["annee"],
      map["heure"],
      map["minute"],
    );
  }
}