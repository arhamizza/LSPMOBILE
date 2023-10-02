import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test1/database/database_helper.dart';
import 'package:test1/Screens/pemasukan.dart';
import 'package:test1/Users/transaksi_model.dart';

class Detail extends StatefulWidget {
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final usrName = TextEditingController();
  final usrPass = TextEditingController();

  //SQLite instance of DatabaseHelper class
  late DatabaseHelper handler;
  late Future<List<Transaksi>> transaksis;
  final db = DatabaseHelper();

  int? selectedId;
  int number = -1;

  // stateful initState function, for refreshing the entire screen on each entry
  @override
  void initState() {
    super.initState();
    handler = DatabaseHelper();
    transaksis = handler.getTransaksi();
    handler.initDB().whenComplete(() async {
      transaksis = getList();
    });
    total();
  }

  //Total Users count
  Future<int?> total() async {
    int? count = await handler.totalTransaksis();
    setState(() => number = count!);
    return number;
  }

  //Method to get data from database
  Future<List<Transaksi>> getList() async {
    return await handler.getTransaksi();
  }

  //Method to refresh data on pulling the list
  Future<void> _onRefresh() async {
    setState(() {
      transaksis = getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Provider.of<MyProvider>(context, listen: false);
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                trailing: const Icon(Icons.notes),
              ),
              ListTile(
                title: const Text("Notes"),
                leading: const Icon(Icons.note_alt_outlined),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PemasukanScreen()));
                },
              ),
              ListTile(
                title: const Text("Complete"),
                leading: const Icon(Icons.done_all),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PemasukanScreen()));
                },
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.power_settings_new),
                      title: const Text("Logout"),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PemasukanScreen()));
                      },
                      
                    )
                    
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      //Future Builder to load data live as stream
    );
  }
  
}
