import 'package:chat_app/constans/app_constant.dart';
import 'package:chat_app/firebase_services/authServices/authGate.dart';
import 'package:chat_app/firebase_services/authServices/firebase_service.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class Signup_Form extends StatefulWidget {
  const Signup_Form({super.key});

  @override
  State<Signup_Form> createState() => _Signup_FormState();
}

class _Signup_FormState extends State<Signup_Form> {
  @override
  bool _passHide = true;
  final _formkey = GlobalKey<FormState>();
  String? _email, _password, _cpassword;

  void _toggelVisibal() {
    setState(() {
      _passHide = !_passHide;
    });
  }

  void register(BuildContext context) {
    final _auth = AuthService();

    if (_password == _cpassword) {
      try {
        _auth.signUpWithEmailPassword(_email!, _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Authgate()));
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Password not Match'),
              ));
    }
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: AppConstant.scaffoldColor,
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Icon(
                      Icons.add_reaction_outlined,
                      size: 130,
                      color: AppConstant.iconColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Create Account',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppConstant.textColor),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onSaved: (email) {
                        _email = email;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.alternate_email_outlined,
                            color: Colors.indigo,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onSaved: (password) {
                        _password = password;
                      },
                      obscureText: _passHide,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.indigo,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _toggelVisibal();
                            },
                            icon: _passHide
                                ? Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.indigo,
                                  )
                                : Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.indigo,
                                  ),
                          ),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onSaved: (cpassword) {
                        _cpassword = cpassword;
                      },
                      obscureText: _passHide,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.indigo,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _toggelVisibal();
                            },
                            icon: _passHide
                                ? Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.indigo,
                                  )
                                : Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.indigo,
                                  ),
                          ),
                          hintText: 'Confirm Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70, right: 70),
                      child: CustomButton(
                        text: 'SignUp',
                        backgroundColor: AppConstant.textColor,
                        textColor: Colors.white,
                        ontap: () {
                          _formkey.currentState!.save();
                          print('''$_email , $_password''');
                          register(context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Made with ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                        Text(
                          ' by jack@beast devlopers',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
