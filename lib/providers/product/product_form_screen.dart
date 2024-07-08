import 'package:flutter/material.dart';
import 'package:kedai_tembakau_abah/models/product.dart';
import 'package:kedai_tembakau_abah/services/product_service.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product;

  const ProductFormPage({super.key, this.product});

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final ProductApi productApi = ProductApi();

  final _namaController = TextEditingController();
  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();
  final _attrController = TextEditingController();
  final _weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _namaController.text = widget.product!.nama;
      _priceController.text = widget.product!.price.toString();
      _qtyController.text = widget.product!.qty.toString();
      _attrController.text = widget.product!.attr;
      _weightController.text = widget.product!.weight.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
                widget.product == null ? 'Tambah Product' : 'Edit Product')),
        backgroundColor: const Color.fromARGB(255, 255, 0, 153),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter product price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _qtyController,
                decoration: const InputDecoration(
                  labelText: 'quantity',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter product quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _attrController,
                decoration: const InputDecoration(
                  labelText: 'Attribute',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter product attributes';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter product weight';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool response;
                    if (widget.product == null) {
                      response = await productApi.createProduct(
                        _namaController.text,
                        double.parse(_priceController.text),
                        int.parse(_qtyController.text),
                        _attrController.text,
                        int.parse(_weightController.text),
                      );
                    } else {
                      response = await productApi.updateProduct(
                        Product(
                          id: widget.product!.id,
                          nama: _namaController.text,
                          price: double.parse(_priceController.text),
                          qty: int.parse(_qtyController.text),
                          attr: _attrController.text,
                          weight: int.parse(_weightController.text),
                        ),
                        widget.product!.id,
                      );
                    }

                    if (response) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(widget.product == null
                            ? "Berhasil Di tambahkan"
                            : "berhasil Di Edit"),
                      ));
                      Navigator.of(context).popAndPushNamed('/product');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(widget.product == null
                            ? "gagal di tambahkan"
                            : "gagal di edit"),
                      ));
                    }
                  }
                },
                child: Text(
                  widget.product == null ? 'simpan' : 'perbarui',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
