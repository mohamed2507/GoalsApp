import 'package:flutter/material.dart';
class PasswordPage extends StatefulWidget {
  PasswordPage({Key key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  String wrongpass='';
  @override
  Widget build(BuildContext context) {
    
    TextEditingController passwordController=new TextEditingController();
    final Password=TextField(
        autofocus: true,
        controller: passwordController,
        maxLines: 1,
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
          hintText: "Password",
        ),
      
    );

    final Submit=Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
      width: MediaQuery.of(context).size.width*0.5,
      child: ElevatedButton(
        child: Text("submit"),
        style:ButtonStyle(
          
        ),
        onPressed: (){
          /*if (passwordController.text=="benmaiza")
          {
            print("yes");
            Navigator.of(context).pushReplacementNamed('/home');
          }
          else
          {
            print('no');
            setState(() {
              wrongpass="wrong password";
                        });
          }*/
          Navigator.of(context).pushReplacementNamed('/home');
        },
      ),
    );
    Widget WrongPassWidget=Container(
      child: Text(
        wrongpass,
        style: TextStyle(color:Colors.red[900]),
        ),
    );

    return Scaffold(
      body:SafeArea(
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Center(child:Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child:Password,
                )
                ),
              Center(child:WrongPassWidget),
              Center(child:Submit)
            ],
            ),
        
        ),

      );
      
    
  }
}