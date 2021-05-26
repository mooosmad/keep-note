
class DataNotes {
  int id = 0;
  String titre = '';
  String note = '';
  int j = 0;
  int m = 0;
  int y = 0;
  int heure = 0;
  int minute = 0;
  DataNotes(
      {int? id,
        String? titre,
        String ?note,
        int? j,
        int? m,
        int? y,
        int? heure,
        int? minute}) {
    this.id = id!;
    this.titre = titre!;
    this.note = note!;
    this.heure = heure!;
    this.minute = minute!;
    this.j = j!;
    this.m = m!;
    this.y = y!;
  }


  Map<String, dynamic> toMap() {
    return {
      "id" : id,
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
      id: map["id"],
      titre: map["titre"],
      note: map["note"],
      j: map["jour"],
      m: map["mois"],
      y: map["annee"],
      heure: map["heure"],
      minute: map["minute"],
    );
  }
}