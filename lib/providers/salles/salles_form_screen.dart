import 'package:flutter/material.dart';
import 'package:kedai_tembakau_abah/models/selles.dart';
import 'package:kedai_tembakau_abah/services/salles_service.dart';

class ReselerFormPage extends StatefulWidget {
  final Reseler? reseler;

  ReselerFormPage({super.key, this.reseler});

  @override
  _ReselerFormPageState createState() => _ReselerFormPageState();
}

class _ReselerFormPageState extends State<ReselerFormPage> {
  final ReselerApi reselerApi = ReselerApi();

  final _buyerController = TextEditingController();
  final _phnController = TextEditingController();
  final _dateController = TextEditingController();
  final _statusController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.reseler != null) {
      _buyerController.text = widget.reseler!.buyer;
      _phnController.text = widget.reseler!.phone;
      _dateController.text = widget.reseler!.date;
      _statusController.text = widget.reseler!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
                widget.reseler == null ? 'Tambah saller' : 'Edit Salller')),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _buyerController,
                decoration: const InputDecoration(
                  labelText: 'Buyer',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter buyer';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phnController,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Mobile Number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter buyer status';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool response;
                    if (widget.reseler == null) {
                      response = await reselerApi.createReseler(
                        _buyerController.text,
                        _phnController.text,
                        _dateController.text,
                        _statusController.text,
                      );
                    } else {
                      response = await reselerApi.updateReseler(
                        Reseler(
                          id: widget.reseler!.id,
                          buyer: _buyerController.text,
                          phone: _phnController.text,
                          date: _dateController.text,
                          status: _statusController.text,
                        ),
                        widget.reseler!.id,
                      );
                    }

                    if (response) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(widget.reseler == null
                            ? "berhasil di tambahkan"
                            : "berhasil di perbarui"),
                      ));
                      Navigator.of(context).popAndPushNamed('/reseler');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(widget.reseler == null
                            ? "gagal di tambahkan"
                            : "gagal di edit"),
                      ));
                    }
                  }
                },
                child: Text(
                  widget.reseler == null ? 'Simpan' : 'perbarui',
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
