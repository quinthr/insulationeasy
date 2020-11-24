import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import './main.dart';
import './models/InstallationFormEntry.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(253, 200, 48, 1).withOpacity(1.0),
                  Color.fromRGBO(243, 115, 53, 1).withOpacity(1.0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      child: Image.asset('assets/images/title.png',
                          fit: BoxFit.cover, height: 38),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'workerName': '',
  };
  var _isLoading = true;

  void _submit() {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 5), () {
      print(_authData['workerName']);
      setUser(_authData['workerName']);
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(
              settings: RouteSettings(name: "dashboard"),
              builder: (BuildContext context) => MyHomePage()));
    });
  }

  Future<dynamic> _fetchAndSetUser() async {
    final prefs = await SharedPreferences.getInstance();
    //await prefs.clear();
    //InstallationFormEntryDB.deleteDB();
    final _newWorkerName = prefs.getString('workerName');
    print(_newWorkerName);
    if (_newWorkerName == null) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> setUser(String workerName) async {
    final prefs = await SharedPreferences.getInstance();
    print(_authData['workerName']);
    print(workerName);
    prefs.setString("workerName", workerName).then((bool success) {
      print(_authData['workerName']);
    });
  }

  _AuthCardState() {
    _fetchAndSetUser().then((val) => setState(() {
      print(val);
      if (val) {
        print('Set to True');
        _isLoading = false;
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  settings: RouteSettings(name: "dashboard"),
                  builder: (BuildContext context) => MyHomePage()));
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(children: [
      Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 180,
                  constraints: BoxConstraints(minHeight: 180),
                  width: deviceSize.width * 0.75,
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if (_isLoading)
                            Column(children: [
                              SizedBox(
                                height: 50.0,
                              ),
                              CircularProgressIndicator()
                            ])
                          else
                            Column(
                              children: [
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Name'),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Invalid name!';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    print(value);
                                    _authData['workerName'] = value;
                                    print(_authData['workerName']);
                                    setState(() {
                                      _authData['workerName'] = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                RaisedButton(
                                  child: Text('LOGIN'),
                                  onPressed: _submit,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 8.0),
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ]))
    ]);
  }
}
