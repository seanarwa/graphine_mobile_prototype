import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphine_mobile_prototype/api/firebase/auth.dart';
import 'package:graphine_mobile_prototype/pages/pages.dart';

class HomePage extends StatefulWidget {

  static final String routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  BarcodeDriverLicense _scanResult;

  Widget _renderResult() {
    if(_scanResult == null) {
      return Container(
        padding: EdgeInsets.all(15.0),
        child: Text("No Data"),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: [
          TableRow(children: [ Text("First Name"), Text(_scanResult.firstName) ]),
          TableRow(children: [ Text("Middle Name"), Text(_scanResult.middleName) ]),
          TableRow(children: [ Text("Last Name"), Text(_scanResult.lastName) ]),
          TableRow(children: [ Text("Gender"), Text(_scanResult.gender == "1" ? "M" : "F") ]),
          TableRow(children: [ Text("Birth Date"), Text(_scanResult.birthDate) ]),
          TableRow(children: [ Text("Street Address"), Text(_scanResult.addressStreet) ]),
          TableRow(children: [ Text("City"), Text(_scanResult.addressCity) ]),
          TableRow(children: [ Text("State"), Text(_scanResult.addressState) ]),
          TableRow(children: [ Text("Zip"), Text(_scanResult.addressZip) ]),
          TableRow(children: [ Text("Document Type"), Text(_scanResult.documentType) ]),
          TableRow(children: [ Text("License Number"), Text(_scanResult.licenseNumber) ]),
          TableRow(children: [ Text("Expiry Date"), Text(_scanResult.expiryDate) ]),
          TableRow(children: [ Text("Issuing Country"), Text(_scanResult.issuingCountry) ]),
          TableRow(children: [ Text("Issuing Date"), Text(_scanResult.issuingDate) ]),
        ],
      ),
    );
  }

  Widget _renderClearButton() {
    if(_scanResult == null) {
      return Container();
    }

    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          _scanResult = null;
        });
      },
      icon: Icon(Icons.clear),
      label: Text("Clear"),
    );
  }

  Widget _renderScanButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        dynamic result = await Get.toNamed(ScannerPage.routeName);
        if(result != null) {
          setState(() {
            _scanResult = result;
          });
        }
      },
      icon: Icon(_scanResult == null ? Icons.camera_alt : Icons.repeat),
      label: Text('Scan ${_scanResult == null ? "Driver's License" : "Again"}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _renderResult(),
                    _renderClearButton(),
                    _renderScanButton(),
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: Auth.signOut,
              icon: Icon(Icons.exit_to_app),
              label: Text("Sign Out"),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}


