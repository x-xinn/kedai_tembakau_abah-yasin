import 'package:flutter/material.dart';
import 'package:kedai_tembakau_abah/models/product.dart';
import 'package:kedai_tembakau_abah/providers/product/product_details_screen.dart';
import 'package:kedai_tembakau_abah/providers/product/product_form_screen.dart';
import 'package:kedai_tembakau_abah/services/product_service.dart';
import 'package:kedai_tembakau_abah/widgets/custom_navigator.dart';

class ProductPages extends StatefulWidget {
  const ProductPages({Key? key}) : super(key: key);

  @override
  State<ProductPages> createState() => _ProductPagesState();
}

class _ProductPagesState extends State<ProductPages> {
  late Future<List<Product>> listProduct;
  final ProductService = ProductApi();

  @override
  void initState() {
    super.initState();
    listProduct = ProductService.fetchProducts();
  }

  void refreshProducts() {
    setState(() {
      listProduct = ProductService.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.purpleAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/add-product'),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: FutureBuilder<List<Product>>(
          future: listProduct,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> isiProduct = snapshot.data!;
              return ListView.builder(
                itemCount: isiProduct.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            products: isiProduct[index],
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
                                  isiProduct[index].nama,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Price: Rp ${isiProduct[index].price}', // Price is now double
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Stock: ${isiProduct[index].qty}',
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
                                        builder: (context) => ProductFormPage(
                                          product: isiProduct[index],
                                        ),
                                      ),
                                    ).then((_) => refreshProducts());
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blueAccent),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    bool response =
                                        await ProductService.deleteProduct(
                                            isiProduct[index].id);
                                    if (response == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.green,
                                          content:
                                              Text("Product berhasil di hapus"),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content:
                                              Text("gagal menghapus produk"),
                                        ),
                                      );
                                    }
                                    refreshProducts();
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
      bottomNavigationBar: const CustomBottomBar(type: 'product'),
    );
  }
}
