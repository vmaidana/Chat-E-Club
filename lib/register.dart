import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:teguiotea/home.dart';
// import 'home.dart';

class Cadastro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CadastroState();
}

  //var formKey = GlobalKey<FormState>();



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
        // .signInWithEmailAndPassword(email: email, password: senha);
        .createUserWithEmailAndPassword(
            //nome: nome,
            email: email,
            password: senha);

    var _user = await FirebaseAuth.instance.currentUser();

    UserUpdateInfo _info = new UserUpdateInfo();
    _info.displayName = nome;
    
    _user.updateProfile(_info);
    //telefone: telefone);
    // MaterialPageRoute(builder: (context) => Home());
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
        title: Text("Cadastro"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.lightBlue[200],
        body: new Container(
          padding: new EdgeInsets.all(20.0),
            child: new Form(
              key: this.formKey,  
          child: new ListView(
            children: [
              new TextFormField(
                decoration: new InputDecoration(
                  hintText: 'Digite seu Nome',
                  labelText: 'Nome'
                ),
                autovalidate: true,
                validator: (value) {
                if(value.length == 0)
                  return "Campo obrigatório";
                if(value.length < 3)
                 return "Mínimo 3 caracteres.";
                 return null;
                 },
                  onSaved: (value) => nome = value,
              ),
              new TextFormField(
                keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                decoration: new InputDecoration(
                  hintText: 'Digite seu E-mail',
                  labelText: 'E-mail '
                ),
                 onSaved: (value) => email = value,
              ),
              // new TextFormField(
              //   keyboardType: TextInputType.phone,
              //   decoration: new InputDecoration(
              //     hintText: 'Digite seu Telefone',
              //     labelText: 'Telefone'
              //   ),
              //   onSaved: (value) => telefone = value,
              // ),
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
                child: new RaisedButton(
                  child: new   Text('Salvar',
                    style: new TextStyle(
                      color: Colors.black
                    ),
                  ),
                onPressed: () {
                formKey.currentState.save();
                _cadastro();
              },
              //{
              //if(formKey.currentState.validate())
              //{
                //formKey.currentState.save();

                  //Firestore.instance.collection('usuarios')
                    //.add({'nome': nome,
                          //'email': email,
                          //'telefone': telefone,
                          //'senha': senha});
                  //Navigator.of(context).pop();
                  //}
                //},

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