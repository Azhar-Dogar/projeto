class CardModel {
  late String id;
  late String holderName;
  late String validity;
  late String cvv;
  late bool mainCard;

  CardModel(
      {required this.id,
      required this.holderName,
      required this.validity,
      required this.cvv,
      required this.mainCard});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "holderName": holderName,
      "validity": validity,
      "cvv": cvv,
      "mainCard": mainCard,
    };
  }

  CardModel.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    holderName = data["holderName"];
    validity = data["validity"];
    cvv = data["cvv"];
    mainCard = data["mainCard"];
  }
}
