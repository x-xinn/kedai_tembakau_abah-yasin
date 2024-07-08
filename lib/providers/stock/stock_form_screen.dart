import 'package:flutter/material.dart';
import 'package:kedai_tembakau_abah/models/stock.dart';
import 'package:kedai_tembakau_abah/services/stock_service.dart';

class StockFormPage extends StatefulWidget {
  final Stock? stock;

  StockFormPage({super.key, this.stock});

  @override
  _StockFormPageState createState() => _StockFormPageState();
}

class _StockFormPageState extends State<StockFormPage> {
  final StockApi stockApi = StockApi();

  final _namaController = TextEditingController();
  final _qtyController = TextEditingController();
  final _attrController = TextEditingController();
  final _weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.stock != null) {
      _namaController.text = widget.stock!.nama;
      _qtyController.text = widget.stock!.qty.toString();
      _attrController.text = widget.stock!.attr;
      _weightController.text = widget.stock!.weight.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(widget.stock == null ? 'Tambah Stock' : 'Edit Stock')),
        backgroundColor: Colors.purpleAccent,
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
                    return 'Enter stock name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _qtyController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter stock quantity';
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
                    return 'Enter stock attributes';
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
                    return 'Enter stock weight';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool response;
                    if (widget.stock == null) {
                      response = await stockApi.createStock(
                        _namaController.text,
                        int.parse(_qtyController.text),
                        _attrController.text,
                        int.parse(_weightController.text),
                      );
                    } else {
                      response = await stockApi.updateStock(
                        Stock(
                          id: widget.stock!.id,
                          nama: _namaController.text,
                          qty: int.parse(_qtyController.text),
                          attr: _attrController.text,
                          weight: int.parse(_weightController.text),
                        ),
                        widget.stock!.id,
                      );
                    }

                    if (response) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(widget.stock == null
                            ? "berhasil Di tambahkan"
                            : "Berhasil Di perbarui"),
                      ));
                      Navigator.of(context).popAndPushNamed('/stock');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(widget.stock == null
                            ? "Gagal Di tambahkn"
                            : "Gagal Di perbarui"),
                      ));
                    }
                  }
                },
                child: Text(
                  widget.stock == null ? 'simpan' : 'perbarui',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
