import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:counter_7/main.dart';
import 'package:counter_7/page/data.dart';
import 'package:counter_7/page/mywatchlist_page.dart';


var data = [];

class MyFormPage extends StatefulWidget {
    const MyFormPage({super.key});

    @override
    State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _judulBudget = "";
    String _nominalBudget = "";
    String? jenis;
    List<String> listJenis = ['Pemasukan', 'Pengeluaran'];

    var _judulController = TextEditingController();
    var _nominalController = TextEditingController();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Form Budget'),
            ),
            // Drawer menu
            drawer: Drawer(
                child: Column(
                  children: [
                    // Menambahkan clickable menu
                    ListTile(
                      title: const Text('counter_7'),
                      onTap: () {
                        // Route menu ke halaman utama
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MyHomePage()),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Tambah Budget'),
                      onTap: () {
                        // Route menu ke halaman form
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MyFormPage()),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Data Budget'),
                      onTap: () {
                        // Route menu ke halaman data budget
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MyDataPage()),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('My Watchlist'),
                      onTap: () {
                        // Route menu ke halaman Watchlist
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MyDataPage()),
                        );
                      },
                    ),
                  ],
                ),
            ),
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [

                        // FIELD Judul Budget
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _judulController,
                            decoration: InputDecoration(
                              labelText: "Judul",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )
                            ),
                            // Menambahkan behavior saat nama diketik 
                            onChanged: (String? value) {
                              setState(() {
                                _judulBudget = value!;
                              });
                            },
                            // Menambahkan behavior saat data disimpan
                            onSaved: (String? value) {
                              setState(() {
                                _judulBudget = value!;
                              });
                            },
                            // Validator sebagai validasi form
                            validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                    return 'Judul tidak boleh kosong!';
                                }
                                return null;
                            },
                          ),
                        ),

                        // FIELD Nominal Budget
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _nominalController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              labelText: "Nominal",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )
                            ),
                            // Menambahkan behavior saat nama diketik 
                            onChanged: (String? value) {
                              setState(() {
                                _nominalBudget = value!;
                              });
                            },
                            // Menambahkan behavior saat data disimpan
                            onSaved: (String? value) {
                              setState(() {
                                _nominalBudget = value!;
                              });
                            },
                            // Validator sebagai validasi form
                            validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                    return 'Nominal tidak boleh kosong!';
                                }
                                return null;
                            },
                          ),
                        ),

                        // Dropdown Jenis Budget
                        Padding(
                          padding: const EdgeInsets.only(left:140.0, right:140.0, bottom: 8.0),
                          child: DropdownButtonFormField(
                            hint: const Text("Pilih Jenis"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            value: jenis,
                            items: listJenis.map((String items) {
                              return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                  jenis = newValue ?? "";
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                  return 'Pilih salah satu jenis budget!';
                              }
                              return null;
                            },
                          ),
                        ),]
                    ),
                  ),
                ),
              ),
              // BUTTON Simpan
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 
              floatingActionButton: Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          data.add([_judulBudget, _nominalBudget, jenis]);
                          _judulController.clear();
                          _nominalController.clear();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 15,
                                child: Container(
                                  child: ListView(
                                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Center(child: Text('Budget Telah Berhasil Disimpan.')),
                                      SizedBox(height: 20),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Kembali'),
                                      ), 
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
    }
}