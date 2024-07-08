import 'package:flutter/material.dart';
import 'package:kedai_tembakau_abah/models/stock.dart';
import 'package:kedai_tembakau_abah/providers/stock/stock_details_screen.dart';
import 'package:kedai_tembakau_abah/providers/stock/stock_form_screen.dart';
import 'package:kedai_tembakau_abah/services/stock_service.dart';
import 'package:kedai_tembakau_abah/widgets/custom_navigator.dart';

class stockPages extends StatefulWidget {
  const stockPages({Key? key}) : super(key: key);

  @override
  State<stockPages> createState() => _stockPagesState();
}

class _stockPagesState extends State<stockPages> {
  late Future<List<Stock>> listStock;
  final StockService = StockApi();

  @override
  void initState() {
    super.initState();
    listStock = StockService.fetchStocks();
  }

  void refreshStocks() {
    setState(() {
      listStock = StockService.fetchStocks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock List'),
        backgroundColor: Colors.purpleAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/add-stock'),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: FutureBuilder<List<Stock>>(
          future: listStock,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Stock> isiStock = snapshot.data!;
              return ListView.builder(
                itemCount: isiStock.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            stocks: isiStock[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.grey[900],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isiStock[index].nama,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Stock: ${isiStock[index].qty}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StockFormPage(
                                          stock: isiStock[index],
                                        ),
                                      ),
                                    ).then((_) => refreshStocks());
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blueAccent),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    bool response =
                                        await StockService.deleteStock(
                                            isiStock[index].id);
                                    if (response == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text("gagal di edit"),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text("gagal di edit"),
                                        ),
                                      );
                                    }
                                    refreshStocks();
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(
                "${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(type: 'stock'),
    );
  }
}
