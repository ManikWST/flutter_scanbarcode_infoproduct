import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import '../models/product.dart';
import '../utils/constants.dart';
import 'barcode_scanner_page.dart';
// ignore: unused_import
import 'home_page.dart';

class ProductInfoPage extends StatelessWidget {
  final String barcode;
  final List<CameraDescription> cameras;

  const ProductInfoPage(
      {Key? key, required this.barcode, required this.cameras})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = productData[barcode];

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Info'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => HomePage(cameras: cameras),
              ),
              (route) => false,
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.08),
                                offset: Offset(0, 4),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          child: Center(
                            child: product != null
                                ? Image.network(
                                    product.image,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  )
                                : Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 80,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      if (product != null) ...[
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RedHatText',
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          product.price,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ] else
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'Barcode yang anda scan tidak ditemukan, pastikan kondisi barcode bersih dan tidak rusak ataupun tercoret',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BarcodeScannerPage(
                        cameras: cameras,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromARGB(255, 226, 226, 226),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24.0),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code, color: Colors.black),
                    SizedBox(width: 10),
                    Text('Scan Barcode Lagi'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

HomePage({required List<CameraDescription> cameras}) {}
