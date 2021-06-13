class DataNotes {
  int? id;
  String? titre;
  String? note;
  String? dateEnr;
  DataNotes({int? id, String? titre, String? note, String? dateEnr}) {
    this.id = id;
    this.titre = titre;
    this.note = note;
    this.dateEnr = dateEnr;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "titre": titre,
      "note": note,
      "dateEnr": dateEnr,
    };
  }

  factory DataNotes.fromMap(Map<String, dynamic> map) {
    return DataNotes(
      id: map["id"],
      titre: map["titre"],
      note: map["note"],
      dateEnr: map["dateEnr"],
    );
  }
}
