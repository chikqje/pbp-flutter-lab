import 'package:flutter/material.dart';
import 'package:counter_7/form.dart';
import 'package:counter_7/data.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Widget ini adalah root dari aplikasi Anda.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Program Counter',
      theme: ThemeData(
        // Ini adalah theme dari aplikasi Anda.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // Widget ini adalah halaman beranda aplikasi Anda. It is stateful, meaning
  // artinya memiliki a State object (didefinisikan di bawah)  yang berisi fields 
  // yang memengaruhi tampilannya.

  // Class ini adalah konfigurasi untuk state. Ini menyimpan values (nilai) (in this
  // case the title) yang diberikan oleh parent (dalam hal ini App widget) dan 
  // digunakan oleh build method of the State. Fields dalam Widget subclass
  // selalu ditandai "final".

  final String title = 'Flutter Tugas Home Page';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _condition = "Genap";
  MaterialColor _color = Colors.red;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _changeCondition();
  }

  void _decrementCounter() {
    // If the counter is zero, do nothing.
    if (_counter == 0) {
      return;
    }
    // Else, decrement the counter
    setState(() {
      _counter--;
    });
    _changeCondition();
  }

  void _changeCondition() {
    // Jika nomor saat ini Genap/0, mengubah teks menjadi "Genap" dan juga warnanya
    // menjadi biru. Jika Ganjil, mengubah teks menjadi "Ganjil" dan warnanya menjadi merah.
    setState(() {
      if (_counter % 2 == 0 || _counter == 0) {
        _condition = "Genap";
        _color = Colors.red;
      }
      else {
        _condition = "Ganjil";
        _color = Colors.blue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Method ini dijalankan ulang setiap kali setState dipanggil, misalnya seperti 
    // yang dilakukan oleh method _incrementCounter di atas.
    //
    // Flutter framework telah dioptimalkan untuk membuat build method dijalankan 
    // ulang menjadi cepat, sehingga Anda bisa membangun ulang apa saja yang perlu 
    // diperbarui daripada harus mengubah instance widget satu per satu.
    return Scaffold(
      appBar: AppBar(
        // Di sini kita mengambil nilai/value dari object MyHomePage yang dibuat 
        // dengan App.build method, dan menggunakannya untuk ngeset judul appbar kita.
        title: Text(widget.title),
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
                    // Route menu ke halaman form
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MyDataPage()),
                    );
                  },
                ),
              ],
            ),
          ),
      body: Center(
        // Center adalah layout widget. Dibutuhkan single child dan positions
        // di tengah dari the parentnya.
        child: Column(
          // Column juga merupakan layout widget. Itu mengambil a list dari children dan
          // menyusunnya secara vertikal. By default,ukurannya disesuaikan dengan 
          // children secara horizontal, dan mencoba untuk as tall as its parent.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _condition,
              style: TextStyle(
                color: _color,
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 
      floatingActionButton: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: (_counter > 0),
              child: FloatingActionButton(
                  onPressed: _decrementCounter,
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
              ),
            ),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ],
        ),
      ),
    );
  }
}