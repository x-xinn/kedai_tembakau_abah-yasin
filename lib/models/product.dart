class Product {
  final String id;
  final String nama;
  final double price; // pastikan menggunakan double
  final int qty;
  final String attr;
  final int weight;

  Product({
    required this.id,
    required this.nama,
    required this.price,
    required this.qty,
    required this.attr,
    required this.weight,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nama: json['name'],
      price: json['price'].toDouble(), // pastikan tipe data double
      qty: json['qty'],
      attr: json['attr'],
      weight: json['weight'],
    );
  }
}
