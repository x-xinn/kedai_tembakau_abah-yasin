import 'package:flutter/material.dart';
import 'package:kedai_tembakau_abah/models/stock.dart';

class DetailScreen extends StatelessWidget {
  final Stock stocks;

  const DetailScreen({Key? key, required this.stocks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stocks.nama),
        backgroundColor: Colors.purpleAccent,
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
                stocks.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.purpleAccent,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Stock: ${stocks.qty}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Weight: ${stocks.weight} ${stocks.attr}',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
