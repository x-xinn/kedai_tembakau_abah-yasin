import 'package:flutter/material.dart';
import 'package:kedai_tembakau_abah/models/selles.dart';
import 'package:kedai_tembakau_abah/providers/salles/salles_details_screen.dart';
import 'package:kedai_tembakau_abah/providers/salles/salles_form_screen.dart';
import 'package:kedai_tembakau_abah/services/salles_service.dart';
import 'package:kedai_tembakau_abah/widgets/custom_navigator.dart';

class reselerPages extends StatefulWidget {
  const reselerPages({Key? key}) : super(key: key);

  @override
  State<reselerPages> createState() => _reselerPagesState();
}

class _reselerPagesState extends State<reselerPages> {
  late Future<List<Reseler>> listReseler;
  final ReselerService = ReselerApi();

  @override
  void initState() {
    super.initState();
    listReseler = ReselerService.fetchReselers();
  }

  void refreshReselers() {
    setState(() {
      listReseler = ReselerService.fetchReselers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale List'),
        backgroundColor: Colors.purpleAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/add-reseler'),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: FutureBuilder<List<Reseler>>(
          future: listReseler,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Reseler> isiReseler = snapshot.data!;
              return ListView.builder(
                itemCount: isiReseler.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            reselers: isiReseler[index],
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
                                  isiReseler[index].buyer,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Status: ${isiReseler[index].status}',
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
                                        builder: (context) => ReselerFormPage(
                                          reseler: isiReseler[index],
                                        ),
                                      ),
                                    ).then((_) => refreshReselers());
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Colors.purpleAccent),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    bool response =
                                        await ReselerService.deleteReseler(
                                            isiReseler[index].id);
                                    if (response == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.green,
                                          content:
                                              Text("Produk berhasil dihapus"),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text("Produk gagal dihapus"),
                                        ),
                                      );
                                    }
                                    refreshReselers();
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
      bottomNavigationBar: const CustomBottomBar(type: 'reseler'),
    );
  }
}
