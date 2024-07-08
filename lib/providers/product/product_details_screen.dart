import 'package:flutter/material.dart';
import 'package:kedai_tembakau_abah/models/product.dart';

class DetailScreen extends StatelessWidget {
  final Product products;

  const DetailScreen({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(products.nama),
        backgroundColor: Color.fromRGBO(209, 29, 240, 1),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Center(
              child: Text(
                products.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.purpleAccent,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Price: Rp ${products.price}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Stock: ${products.qty}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Weight: ${products.weight} ${products.attr}',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
