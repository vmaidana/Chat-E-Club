import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Cadastro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CadastroState();
}
class CadastroState extends State<Cadastro> {


  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String nome ;
  String email ;
  String telefone ;
  String senha ;

  BuildContext _context;

_cadastro() async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email,
            password: senha);

    var _user = await FirebaseAuth.instance.currentUser();

    UserUpdateInfo _info = new UserUpdateInfo();
    _info.displayName = nome;
    
    _user.updateProfile(_info);
    
    Navigator.of(_context).pop();

  } on Exception catch (e) {
    print(e);
  }
}

@override
  Widget build(BuildContext context) {

    this._context = context;

    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Register"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
        body: new Container(
          padding: new EdgeInsets.all(20.0),
            child: new Form(
              key: this.formKey,  
          child: new ListView(
            children: [
              new TextFormField(
                decoration: new InputDecoration(
                  hintText: 'Type your Name',
                  labelText: 'Name'
                ),
                autovalidate: true,
                validator: (value) {
                if(value.length == 0)
                  return "Required";
                if(value.length < 3)
                 return "Mínimum 3 characters.";
                 return null;
                 },
                  onSaved: (value) => nome = value,
              ),
              new TextFormField(
                keyboardType: TextInputType.emailAddress, // usa tipo email
                decoration: new InputDecoration(
                  hintText: 'type your e-mail',
                  labelText: 'E-mail '
                ),
                 onSaved: (value) => email = value,
              ),
              
            new TextFormField(
                obscureText: true, // esconder o texto da senha
                decoration: new InputDecoration(
                  hintText: 'type your password',
                  labelText: 'Password'
                ),
                onSaved: (value) => senha = value,
              ),

            new Container(
                width: screenSize.width,
                child: new RaisedButton(
                  child: new   Text('Save',
                    style: new TextStyle(
                      color: Colors.black
                    ),
                  ),
                onPressed: () {
                formKey.currentState.save();
                _cadastro();
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