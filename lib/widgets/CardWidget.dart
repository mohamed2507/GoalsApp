import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../classes/classes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../BLOC/states.dart';
class CardWidget extends StatefulWidget {
    final Goal goal;
    final IconData icon;
    final Color leadingColor;
    //final  changeGoalParent;
  CardWidget({Key key,this.goal,this.icon,this.leadingColor}) : super(key: key);
  @override
  _CardWidgetState createState() => _CardWidgetState();
}
class _CardWidgetState extends State<CardWidget> {

  @override
  Widget build(BuildContext context) {
    String a='';
    if(widget.goal!=null){
      if(widget.goal.dateStart!=null){
      a="Date :"+(widget.goal.dateStart).toString().split(' ')[0]+'\n';}
    }
   /* void changeGoal() async
    {
      final   new_goal=await Navigator.pushNamed(context,'/ChangeGoal',arguments: widget.goal);
      if (new_goal != null)
      {
        widget.changeGoalParent(new_goal,widget.goal.id);
      }     
    }*/
    return Card(
      elevation: 0,
      shadowColor: null,
      //margin: EdgeInsets.fromLTRB(10,0,10,0),
      shape: Border
      (
        bottom: BorderSide(color: Colors.greenAccent),
        top: BorderSide(color: Colors.greenAccent),
      ),
      child: ListTile(
        onTap: ()
        {
          //changeGoal();
        },
        leading:IconButton(
          icon: Icon(widget.icon),
          color:widget.leadingColor,
          iconSize: 30,
          onPressed: (){},
        ) ,
        title: Text(
          widget.goal.name,
          style: GoogleFonts.pacifico(
            fontSize: 20,
            color: Colors.greenAccent[400]
          ),
        ),
        subtitle: Text(
          widget.goal.description.length<=35 ?a+widget.goal.description:a+widget.goal.description.substring(0,13),
          style: GoogleFonts.pacifico(
            fontSize: 15,
            color: Colors.greenAccent[400]
          ),
        ),
      isThreeLine: true,       
    )
  );
  }
}