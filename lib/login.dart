import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/chat.dart';
import 'register.dart';
import 'settings.dart';
import 'package:flutter_chat_demo/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(Eclub());

class Eclub extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    var routes = {
      '/login' : (context) => Login(),
      '/' : (context) => Home(),
      '/chat' : (context) => Chat(),
      '/cadastro' : (context) => Cadastro(),
      '/perfil' : (context) => Settings(),
    };

    return MaterialApp(routes: routes, initialRoute: '/',);
  }
}
class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "E-Club Chat",
                style: TextStyle(
                  fontSize: 40.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          CustomButton(
            text: "Log In",
            callback: () {
              Navigator.of(context).pushNamed('/login');
            },
          ),
          CustomButton(
            text: "Register",
            callback: () {
              Navigator.of(context).pushNamed('/cadastro');
            },
          )
        ],
      ),
    );
  }
}
class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;

  const CustomButton({Key key, this.callback, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.blue[300],
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200.0,
          height: 45.0,
          child: Text(text),
        ),
      ),
    );
  }
}


class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}


class _LoginPageState extends State<Login> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String email = '';
  String senha = '';
  BuildContext _context;
  SharedPreferences prefs;

  bool isLoading = false;
  bool isLoggedIn = false;
  FirebaseUser currentUser;


@override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });



    this.setState(() {
      isLoading = false;
    });
  }

  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });


    FirebaseUser firebaseUser = (await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)).user;

    if (firebaseUser != null) {
      // Checa se está conectado
      final QuerySnapshot result =
          await Firestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // cria as partes se é um novo usuario
        Firestore.instance.collection('users').document(firebaseUser.uid).setData({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoUrl,
          'id': firebaseUser.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null
        });

        // escreve os dados na tela
        currentUser = firebaseUser;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('nickname', currentUser.displayName);
        await prefs.setString('photoUrl', currentUser.photoUrl);
      } else {
        // escreve os dados na tela
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('nickname', documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        await prefs.setString('aboutMe', documents[0]['aboutMe']);
      }
      Fluttertoast.showToast(msg: "Sign in success");
      this.setState(() {
        isLoading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(currentUserId: prefs.getString('id'))));
    } else {
      Fluttertoast.showToast(msg: "Sign in fail");
      this.setState(() {
        isLoading = false;
      });
    }
  }


@override
  Widget build(BuildContext context) {

    this._context = context;

    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
    body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Form(
          key: this._formKey,
          child: new ListView(
            children: [
              new TextFormField(
                keyboardType: TextInputType.emailAddress, 
                decoration: new InputDecoration(
                  hintText: 'Type your e-mail',
                  labelText: 'E-mail'
                ),
                onSaved: (value) => email = value,
              ),
            new TextFormField(
                obscureText: true,
                decoration: new InputDecoration(
                  hintText: 'Type your password',
                  labelText: 'Password'
                ),
                onSaved: (value) => senha = value,
              ),
            new Container(
                width: screenSize.width,
                child: new FlatButton(
                  child: new Text('Sign in',
                    style: new TextStyle(
                      color: Colors.black
                    ),
                  ),
                onPressed: (){
                _formKey.currentState.save();
                handleSignIn();
                Navigator.of(_context).pushNamed("/chat");
              },
                  color: Colors.grey,
                ),
                margin: new EdgeInsets.only(
                  top: 20.0
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}













