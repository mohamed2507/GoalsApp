

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../classes/classes.dart';
import 'package:uuid/uuid.dart';

class CreateGoalPage extends StatefulWidget {

  CreateGoalPage({Key key}) : super(key: key);
  @override
  _CreateGoalPageState createState() => _CreateGoalPageState();
}

class _CreateGoalPageState extends State<CreateGoalPage> {

  DateTime _date;
  String _name;
  String _desc;
  //List<ActionToDo> listActions;
  TextEditingController control_goal;
  TextEditingController control_desc;
      initState()
    {
      control_goal= TextEditingController();
      control_desc=TextEditingController();
    }
  @override
  Widget build(BuildContext context) {
    


    /*if(widget.goal !=null)
    {
      _date=widget.goal.dateStart;
      _name=widget.goal.name;
      _desc=widget.goal.description;     
    }*/
    return Scaffold(
       appBar: AppBar
       (
         title:Text( "Add goal"),
         elevation: 10,
         centerTitle: true,
         backgroundColor: Colors.green[300],
       ),
       body: SafeArea(
         child:Expanded(
          
          child:Form( 
          child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Container(
                  margin: EdgeInsets.fromLTRB(20,20,20,0),
                  child:TextField(
                    controller: control_goal..text=_name,
                    keyboardType: TextInputType.name,

                    decoration: InputDecoration(
                      hintText: "Goal"
                    ),  
                    maxLines: 1,
                    style: GoogleFonts.pacifico(
                      fontSize: 20
                    ),
                    onChanged: (val)
                    {
                      
                      setState(() {
                        control_goal.selection=TextSelection(baseOffset: 0);
                        _name=val;                      
                      });
                    },

                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(20,7,0,0),
                  child:FlatButton.icon(
                    color: Colors.greenAccent,
                    icon: Icon(Icons.calendar_today),
                    label: Text('Date'),
                    onPressed: ()
                    {
                      DateTime x=(_date==null?DateTime.now():_date);

                      showDatePicker(
                        context: context,
                        initialDate: x,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2090),
                      ).then((date){
                        setState(() {
                           _date=date;                       
                        });
                      });
                    },
                      ) ,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20,7,20,0),
                  child: TextField(
                    onChanged: (val)
                    {
                      
                      setState(() {
                        control_desc.selection=TextSelection(baseOffset: 0,extentOffset: _desc.length);
                        _desc=val;                      
                      });
                    },
                    controller: control_desc..text=_desc,
                    decoration: InputDecoration(
                      hintText: "Description",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green[300], width: 1.0),
                        ),
                    ),
                    maxLines: 6,
                    style: GoogleFonts.pacifico(
                      fontSize: 15
                    ),
                    
                  ),
                ),
                Container(
                  child:FlatButton(
                    color: Colors.greenAccent,
                    child: Text("ok"),
                      onPressed: (){
                        if (control_goal.text!=""  )
                        {

                        
                        
                        redirection();
                        }
                      },
                  ),
                  height: MediaQuery.of(context).size.height*0.06,
                  width: MediaQuery.of(context).size.width*0.3,
                  margin: EdgeInsets.fromLTRB(0,7,0,0),
                ),
             ],
           ),
          ),
           
           

         ),
       ),
    );
  }
  void redirection  ()async
  {
    final dynamic listActions=await Navigator.pushNamed(context,"/Actions",arguments:control_goal.text);
    Goal goal=Goal(name: control_goal.text,description: control_desc.text,dateStart:_date,actions:  listActions,id:Uuid().v1() );
    Navigator.pop(context,goal);
  }
}