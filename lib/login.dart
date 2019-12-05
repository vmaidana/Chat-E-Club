import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/const.dart';
import 'package:flutter_chat_demo/chat.dart';
import 'register.dart';
import 'settings.dart';
import 'package:flutter_chat_demo/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'E-Club',
//       theme: ThemeData(
//         primaryColor: themeColor,
//       ),
//       home: Home(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

void main() => runApp(Eclub());

class Eclub extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    var routes = {
      //'/camera' : (context) => Camera(),
      //'/perguntasblog' : (context) => Perguntasblog(),
      //'/atividades' : (context) => Atividades(),
      //'/perguntas' : (context) => Perguntas(),
      '/login' : (context) => Login(),
      //'/cadastro' : (context) => Cadastro(),
      //'/sobre' : (context) => Sobre(),
      //'/perfil' : (context) => Perfil(),
      '/' : (context) => Home(),
      '/chat' : (context) => Chat(),
      '/cadastro' : (context) => Cadastro(),
      '/perfil' : (context) => Settings(),
    };

    return MaterialApp(routes: routes, initialRoute: '/',);
  }
}

// Chat({Key key, String peerId, String peerAvatar})

class Home  extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true, // centralizar Titulo
          title: Text("E-Club"),
          backgroundColor: Colors.black,
        ),
        //body:  //Image.asset('assets/imagens/logomarca.png'), //   <-- image

        body:  Container(  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/imagens/fundook.png',), fit: BoxFit.cover),),
          child: ListView(
            children: [
              Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height:400.0),
            // Container(
            //       width: 350.0,
            //         child: Align(
            //       alignment: Alignment.center,
            //       child: RaisedButton(
            //         shape: RoundedRectangleBorder(
            //             borderRadius: new BorderRadius.circular(20.0)),
            //         //color: Color(0xffffffff),
            //         color: Color.fromRGBO(200, 200, 200, 0.3),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //           //Icon(FontAwesomeIcons.google,color: Color(0xffCE107C),),
            //           SizedBox(width:10.0),
            //           Text('Saiba Mais Sobre o TEA',style: TextStyle(color: Colors.black,fontSize: 25.0),
            //         ),
            //         ],),
            //         onPressed: (){Navigator.of(context).pushNamed('/sobre');},)
            //           ),
            //         ),
                  Container(
                  width: 200.0,
                    child: Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    //color: Color(0xffffffff),
                    color: Color.fromRGBO(200, 200, 200, 0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      //Icon(FontAwesomeIcons.google,color: Color(0xffCE107C),),
                      SizedBox(width:10.0),
                      Text('Login',style: TextStyle(color: Colors.black,fontSize: 25.0),
                    ),
                    ],),
                    onPressed: (){Navigator.of(context).pushNamed('/login');},)
                      ),
                    ),
                  Container(
                  width: 200.0,
                    child: Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    //color: Color(0xffffffff),
                    color: Color.fromRGBO(200, 200, 200, 0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      //Icon(FontAwesomeIcons.google,color: Color(0xffCE107C),),
                      SizedBox(width:10.0),
                      Text('Cadastre-se',style: TextStyle(color: Colors.black,fontSize: 25.0),
                    ),
                    ],),
                    onPressed: (){Navigator.of(context).pushNamed('/cadastro');},)
                      ),
                    ),
                  //   Container(
                  // width: 200.0,
                  //   child: Align(
                  // alignment: Alignment.center,
                  // child: RaisedButton(
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: new BorderRadius.circular(20.0)),
                  //   color: Color.fromRGBO(200, 200, 200, 0.3),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  //     SizedBox(width:10.0),
                  //     Text('Duvidas',style: TextStyle(color: Colors.black,fontSize: 25.0),
                  //   ),
                  //   ],),
                  //   onPressed: (){Navigator.of(context).pushNamed('/perguntas');},)
                  //     ),
                  //   )
                  ]
              ),
              //new Image.asset('assets/imagens/logomarca.png'),
              //new Row( children: [RaisedButton(child: Text('Login'), onPressed: (){Navigator.of(context).pushNamed('/login');},)],),
              //new Row( children: [RaisedButton(child: Text('Cadastre-se'), onPressed: (){ Navigator.of(context).pushNamed('/cadastro');},),],),
              //new Row( children: [RaisedButton(child: Text('Saiba Mais'), onPressed: (){ Navigator.of(context).pushNamed('/sobre');},),],),
              //new Row( children: [RaisedButton(child: Text('Duvidas'), onPressed: (){ Navigator.of(context).pushNamed('/perguntas');},),],)
            ]
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
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;

  bool isLoading = false;
  bool isLoggedIn = false;
  FirebaseUser currentUser;

  // Future _login() async {

  //   try {

  //     await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email, password: senha);

  //     Navigator.of(_context).pushNamed("/chat");

  //   } on Exception catch(e) {
  //     print('ERRO: ' + e.toString());
  //   }
  // }

@override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    //prefs = await SharedPreferences.getInstance();

    //isLoggedIn = await googleSignIn.isSignedIn();
    //if (isLoggedIn) {
    // Navigator.push(
    //   context,
    //     MaterialPageRoute(builder: (context) => MainScreen(currentUserId: prefs.getString('id'))),
    //   );
    //}

    this.setState(() {
      isLoading = false;
    });
  }

  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

    // GoogleSignInAccount googleUser = await googleSignIn.signIn();
    // GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // final AuthCredential credential = GoogleAuthProvider.getCredential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );

    FirebaseUser firebaseUser = (await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)).user;

    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result =
          await Firestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance.collection('users').document(firebaseUser.uid).setData({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoUrl,
          'id': firebaseUser.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null
        });

        // Write data to local
        currentUser = firebaseUser;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('nickname', currentUser.displayName);
        await prefs.setString('photoUrl', currentUser.photoUrl);
      } else {
        // Write data to local
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
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.lightBlue[200],
    body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Form(
          key: this._formKey,
          child: new ListView(
            children: [
              new TextFormField(
                keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                decoration: new InputDecoration(
                  hintText: 'Digite seu E-mail',
                  labelText: 'E-mail '
                ),
                onSaved: (value) => email = value,
              ),
            new TextFormField(
                obscureText: true, // Use secure text for passwords.
                decoration: new InputDecoration(
                  hintText: 'Digite sua senha',
                  labelText: 'Senha'
                ),
                onSaved: (value) => senha = value,
              ),
            new Container(
                width: screenSize.width,
                child: new FlatButton(
                  child: new Text('Entrar',
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













// class LoginScreen extends StatefulWidget {
//   LoginScreen({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   LoginScreenState createState() => LoginScreenState();
// }

// class LoginScreenState extends State<LoginScreen> {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   SharedPreferences prefs;

//   bool isLoading = false;
//   bool isLoggedIn = false;
//   FirebaseUser currentUser;

//   @override
//   void initState() {
//     super.initState();
//     isSignedIn();
//   }

//   void isSignedIn() async {
//     this.setState(() {
//       isLoading = true;
//     });

//     prefs = await SharedPreferences.getInstance();

//     isLoggedIn = await googleSignIn.isSignedIn();
//     if (isLoggedIn) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => MainScreen(currentUserId: prefs.getString('id'))),
//       );
//     }

//     this.setState(() {
//       isLoading = false;
//     });
//   }

//   Future<Null> handleSignIn() async {
//     prefs = await SharedPreferences.getInstance();

//     this.setState(() {
//       isLoading = true;
//     });

//     GoogleSignInAccount googleUser = await googleSignIn.signIn();
//     GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

//     if (firebaseUser != null) {
//       // Check is already sign up
//       final QuerySnapshot result =
//           await Firestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).getDocuments();
//       final List<DocumentSnapshot> documents = result.documents;
//       if (documents.length == 0) {
//         // Update data to server if new user
//         Firestore.instance.collection('users').document(firebaseUser.uid).setData({
//           'nickname': firebaseUser.displayName,
//           'photoUrl': firebaseUser.photoUrl,
//           'id': firebaseUser.uid,
//           'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
//           'chattingWith': null
//         });

//         // Write data to local
//         currentUser = firebaseUser;
//         await prefs.setString('id', currentUser.uid);
//         await prefs.setString('nickname', currentUser.displayName);
//         await prefs.setString('photoUrl', currentUser.photoUrl);
//       } else {
//         // Write data to local
//         await prefs.setString('id', documents[0]['id']);
//         await prefs.setString('nickname', documents[0]['nickname']);
//         await prefs.setString('photoUrl', documents[0]['photoUrl']);
//         await prefs.setString('aboutMe', documents[0]['aboutMe']);
//       }
//       Fluttertoast.showToast(msg: "Sign in success");
//       this.setState(() {
//         isLoading = false;
//       });

//       Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(currentUserId: firebaseUser.uid)));
//     } else {
//       Fluttertoast.showToast(msg: "Sign in fail");
//       this.setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             widget.title,
//             style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//         ),
//         body: Stack(
//           children: <Widget>[
//             Center(
//               child: FlatButton(
//                   onPressed: handleSignIn,
//                   child: Text(
//                     'SIGN IN WITH GOOGLE',
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                   color: Color(0xffdd4b39),
//                   highlightColor: Color(0xffff7f7f),
//                   splashColor: Colors.transparent,
//                   textColor: Colors.white,
//                   padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0)),
//             ),

//             // Loading
//             Positioned(
//               child: isLoading
//                   ? Container(
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                         ),
//                       ),
//                       color: Colors.white.withOpacity(0.8),
//                     )
//                   : Container(),
//             ),
//           ],
//         ));
//   }
// }
