class Refill {
  String? station;
  String? datetime;
  double? unitPrice;
  double? quantity;
  double? paid;
  String? currency;
  String? unit;

  Refill(
    String this.station,
    String this.datetime,
    double this.unitPrice,
    double this.quantity,
    String this.currency,
    String this.unit,
  ) {
    paid = unitPrice! * quantity!;
  }
}
