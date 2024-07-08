class Stock {
  String id;
  String nama;
  int qty;
  String attr;
  int weight;

  Stock({
    required this.id,
    required this.nama,
    required this.qty,
    required this.attr,
    required this.weight,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'],
      nama: json['name'],
      qty: (json['qty'] as num).toInt(),
      attr: json['attr'],
      weight: (json['weight'] as num).toInt(),
    );
  }
}
