import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tes_pitjarus/model/store_model.dart';
import 'package:tes_pitjarus/screen/store/detail_view.dart';
import 'package:tes_pitjarus/service/db_store.dart';

class ListStore extends StatefulWidget {
  const ListStore({
    Key? key,
  }) : super(key: key);

  @override
  State<ListStore> createState() => _ListStoreState();
}

class _ListStoreState extends State<ListStore> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Store>>(
      future: DBStore.readStores(),
      builder: (BuildContext context, AsyncSnapshot<List<Store>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SpinKitThreeBounce(
                  color: Color(0xFF6F35A5),
                  size: 50.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Loading...'),
              ],
            ),
          );
        }
        return snapshot.data!.isEmpty
            ? const Center(
                child: Text('No Store in List yet!'),
              )
            : Expanded(
                child: ListView(
                  children: snapshot.data!.map((stores) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailStore(store: stores);
                            },
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(11),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 4,
                                      offset: const Offset(2.0, 3.0))
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            stores.store_name,
                                            style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            'Cluster : Small',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'TT Reguler - IRTM Big Store',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: const [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.greenAccent,
                                          size: 16.0,
                                        ),
                                        Text(
                                          "1 m",
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
      },
    );
  }
}
