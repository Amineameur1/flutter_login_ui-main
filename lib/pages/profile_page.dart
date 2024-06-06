import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'dart:convert'; // مكتبة لتحليل JSON
import 'package:flutter_login_ui/pages/ClientDetailPage.dart';
import 'package:flutter_login_ui/pages/login_page.dart';
import 'package:flutter_login_ui/pages/splash_screen.dart';
import 'package:flutter_login_ui/pages/widgets/header_widget.dart';

import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';

class ProfilePage extends StatefulWidget {
  final String nameclient;
  ProfilePage({required this.nameclient});

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  List<dynamic> _clientData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchClientData();
  }

  Future<void> _fetchClientData() async {
    try {
      final response = await http.get(Uri.parse('https://meltimanger-0c532dd4d091.herokuapp.com/getclient?nameclient=${widget.nameclient}'));
      if (response.statusCode == 200) {
        setState(() {
          _clientData = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load client data');
      }
    } catch (e) {
      print('Error fetching client data: $e');
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
         widget.nameclient ,
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
          )),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
              top: 16,
              right: 16,
            ),
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
          )),
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
                        fontWeight: FontWeight.bold),
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
                      fontSize: 17, color: Theme.of(context).hintColor),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SplashScreen(title: "Splash Screen")));
                },
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,
                    size: _drawerIconSize, color: Theme.of(context).hintColor),
                title: Text(
                  'Login Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).hintColor),
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
                leading: Icon(Icons.password_rounded,
                    size: _drawerIconSize, color: Theme.of(context).hintColor),
                title: Text(
                  'Forgot Password Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).hintColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.verified_user_sharp,
                    size: _drawerIconSize, color: Theme.of(context).hintColor),
                title: Text(
                  'Verification Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).hintColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ForgotPasswordVerificationPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.logout_rounded,
                    size: _drawerIconSize, color: Theme.of(context).hintColor),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).hintColor),
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
          : _clientData.isEmpty
              ? Center(child: Text('No client data found'))
              : Column(
                  children: [
                    HeaderWidget(100, false, Icons.house_rounded),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Note')),
                            DataColumn(label: Text('Total')),
                          ],
                          rows: _clientData.map((client) {
                            return DataRow(
                              cells: [
                                DataCell(Text(client['ID']?.toString() ?? '')),
                                DataCell(Text(client['note'] ?? '')),
                                DataCell(Text(
                                  
                                    NumberFormat('###,###,###.00').format(double.tryParse(client['total']?.toString() ?? '')).toString(),
                                     
                                  )),

                              ],
                              onSelectChanged: (selected) {
                                if (selected != null && selected) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClientDetailPage(clientId: client['ID']),
                                    ),
                                  );
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}