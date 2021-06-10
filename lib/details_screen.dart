import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('vendors');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: 300,
              child: StreamBuilder<QuerySnapshot>(
                stream: collectionReference.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!.docs
                          .map((e) => Column(
                                children: [
                                  Text(
                                    'Vendor ID : ${e['vendor_id']}',
                                  ),
                                  Text(
                                    'Vendor Name : ${e['vendor_name']}',
                                  ),
                                  Text(
                                    'Vendor Longitude :  ${e['vendor_longitude']}',
                                  ),
                                  Text(
                                    'Vendor Latitude : ${e['vendor_latitude']}',
                                  ),
                                  Text(
                                    'Vendor Total Stock Value ${e['vendor_total_stock_value']}',
                                  ),
                                  Image.network(
                                    e['vendor_image_url'],
                                  ),
                                ],
                              ))
                          .toList(),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
