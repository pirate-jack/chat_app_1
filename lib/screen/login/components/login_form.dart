import 'package:chat_app/constans/app_constant.dart';
import 'package:chat_app/firebase_services/authServices/firebase_service.dart';

import 'package:chat_app/screen/sign_up/signup_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class Login_Form extends StatefulWidget {
  const Login_Form({super.key});

  @override
  State<Login_Form> createState() => _Login_FormState();
}

class _Login_FormState extends State<Login_Form> {
  @override
  bool _passHide = true;
  final _formkey = GlobalKey<FormState>();
  String? _email, _password;

  void _toggelVisibal() {
    setState(() {
      _passHide = !_passHide;
    });
  }

  void login()async{
    final authService = AuthService();
    try{
      await authService.signInWithEmailPassword(_email!, _password);
    }catch(e){
      showDialog(context: context, builder:(context)=> AlertDialog(
        title: Text(e.toString()),
      ));
    }
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
          backgroundColor: AppConstant.scaffoldColor,
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Icon(
                      Icons.chat_rounded,
                      size: 130,
                      color: AppConstant.iconColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Chatter',
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: AppConstant.textColor),
                    ),
                    SizedBox(
                      height: 100,
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
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70, right: 70),
                      child: CustomButton(
                        text: 'Login',
                        backgroundColor: AppConstant.textColor,
                        textColor: Colors.white,
                        ontap: () {
                          _formkey.currentState!.save();
                          login();
                          print('''$_email , $_password''');
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('You Don\'t Have Any Account ? '),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Signup_view(),
                                  ));
                            },
                            child: Text(
                              'Create Account',
                              style: TextStyle(color: Colors.indigo),
                            )),
                      ],
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
