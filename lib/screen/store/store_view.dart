// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:tes_pitjarus/screen/login/login_view.dart';
import 'package:tes_pitjarus/screen/store/widget/list_store.dart';
import 'package:tes_pitjarus/screen/store/widget/search_store.dart';
import 'package:tes_pitjarus/service/db_store.dart';

class ViewStore extends StatefulWidget {
  const ViewStore({super.key});

  @override
  State<ViewStore> createState() => _ViewStoreState();
}

class _ViewStoreState extends State<ViewStore> {
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.white,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Text(
                          "List Store",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "User A",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontStyle: FontStyle.normal),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.grey, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        DBStore.deleteStores();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SearchStore(),
              Text(
                "List Kunjungan : $now",
                style: const TextStyle(
                  color: Color.fromARGB(255, 65, 63, 63),
                ),
              ),
              Stack(
                children: [
                  SafeArea(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: 500,
                        child: Column(
                          children: const [
                            ListStore(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
