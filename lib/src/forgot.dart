import 'package:educa/model/authentication.dart';
import 'package:educa/src/colors.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  String email;
  final _auth = AuthenticationProvider();

  final _formkey = GlobalKey<FormState>();

  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key: _scafoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: kEducaBlack,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Text(
                'Forgot password?',
                style: textTheme.headline2.copyWith(color: kEducaBlue),
              ),
              SizedBox(height: 30),
              Text(
                'Please enter your email address',
                style: textTheme.headline3,
              ),
              Text(
                'to reset password',
                style: textTheme.headline3,
              ),
              SizedBox(height: 30),
              Form(
                key: _formkey,
                child: TextFormField(
                  onSaved: (val) => email = val,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        _formkey.currentState.save();
                        _auth.resetPassword(email: email).then((val) async {
                          if (val == null) {
                            _scafoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('check your email for further')));

                            await Future.delayed(Duration(seconds: 2));

                            Navigator.pop(context);
                          } else {
                            _scafoldKey.currentState
                                .showSnackBar(SnackBar(content: Text(val)));
                          }
                        });
                      }
                    },
                    child: Text(
                      'Continue',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: kEducaWhite),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
