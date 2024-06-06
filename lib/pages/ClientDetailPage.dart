import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_login_ui/pages/login_page.dart';
import 'package:flutter_login_ui/pages/splash_screen.dart';
import 'package:flutter_login_ui/pages/widgets/header_widget.dart';

import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';

class ClientDetailPage extends StatefulWidget {
  final int clientId;

  ClientDetailPage({required this.clientId});

  @override
  State<StatefulWidget> createState() {
    return _ClientDetailPageState();
  }
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  bool _isLoading = true;
  List<dynamic> _clientDetails = [];
  double _totalSum = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchClientDetails();
  }

  Future<void> _fetchClientDetails() async {
    try {
      final response = await http.get(Uri.parse(
          'https://meltimanger-0c532dd4d091.herokuapp.com/getclientdetails?clientId=${widget.clientId}'));
      if (response.statusCode == 200) {
        setState(() {
          _clientDetails = json.decode(response.body);
          _isLoading = false;
          // حساب مجموع الأعداد في العمود "Total"
          _totalSum = _clientDetails.fold(0.0, (sum, item) {
            return sum + (item['total'] ?? 0.0);
          });
        });
      } else {
        throw Exception('Failed to load client details');
      }
    } catch (e) {
      print('Error fetching client details: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Client Detail Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).hintColor,
              ],
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 16, right: 16),
            child: Stack(
              children: <Widget>[
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.2),
                Theme.of(context).hintColor.withOpacity(0.5),
              ],
            ),
          ),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).hintColor,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "FlutterTutorial.Net",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.screen_lock_landscape_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Splash Screen',
                  style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SplashScreen(title: "Splash Screen"),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.login_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Login Page',
                  style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.password_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Forgot Password Page',
                  style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.verified_user_sharp,
                  size: _drawerIconSize,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Verification Page',
                  style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordVerificationPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _clientDetails.isEmpty
              ? Center(child: Text('No client details found'))
              : SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        child: HeaderWidget(100, false, Icons.house_rounded),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    100), // تعويض الحيز الذي يشغله HeaderWidget
                            Text(
                              NumberFormat('###,###.00').format(_totalSum) +
                                  ' DZ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: [
                                  DataColumn(label: Text('Date')),
                                  DataColumn(label: Text('Note')),
                                  DataColumn(label: Text('Product')),
                                  DataColumn(label: Text('Price')),
                                  DataColumn(label: Text('Quantity')),
                                  DataColumn(label: Text('Total')),
                                ],
                                rows: _clientDetails.map((detail) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(
                                          detail['date']?.toString() ?? '')),
                                      DataCell(Text(detail['note'] ?? '')),
                                      DataCell(Text(detail['prodect'] ?? '')),
                                      DataCell(Text(
                                          detail['price']?.toString() ?? '')),
                                      DataCell(Text(
                                        NumberFormat('#.###').format(
                                            double.tryParse(detail['quantity']
                                                    ?.toString() ??
                                                '')),
                                      )),
                                      DataCell(Text(
                                        NumberFormat('###,###.00').format(
                                            double.tryParse(
                                                detail['total']?.toString() ??
                                                    '')),
                                      )),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
