class CardModel {
  late String number;
  late String holderName;
  late String validity;
  late String cvv;
  late bool mainCard;

  CardModel(
      {
        required this.number,
        required this.holderName,
      required this.validity,
      required this.cvv,
      required this.mainCard});

  Map<String, dynamic> toMap() {
    return {
      "holderName": holderName,
      "validity": validity,
      "cvv": cvv,
      "mainCard": mainCard,
      "number" : number,
    };
  }

  CardModel.fromMap(Map<String, dynamic> data) {
    holderName = data["holderName"];
    validity = data["validity"];
    cvv = data["cvv"];
    mainCard = data["mainCard"];
    number = data["number"];
  }
}
