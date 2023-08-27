class RacketModel {
  final int id;
  final String name;

  RacketModel.fromJSON(Map<String, dynamic> json)
      : id = json['racket_id'],
        name = json['name'];

  @override
  String toString() => name;
}

class RubberModel {
  final int id;
  final String name;

  RubberModel.fromJSON(Map<String, dynamic> json)
      : id = json['rubber_id'],
        name = json['name'];

  @override
  String toString() => name;
}

class ItemModel {
  final List<RacketModel> rackets;
  final List<RubberModel> rubbers;

  ItemModel.fromJSON(Map<String, dynamic> json)
      : rackets = json['rackets'],
        rubbers = json['rubbers'];
}
