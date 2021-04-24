



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../classes/classes.dart';
import 'package:uuid/uuid.dart';

class ChangeGoalPage extends StatefulWidget {
  final Goal goal;
  ChangeGoalPage({Key key,this.goal}) : super(key: key);
  @override
  _ChangeGoalPageState createState() => _ChangeGoalPageState();
}

class _ChangeGoalPageState extends State<ChangeGoalPage> {

  DateTime _date;
  String _name;
  String _desc;
  List<ActionToDo> _actions;
  TextEditingController control_goal;
  TextEditingController control_desc;
  
  initState() { 
          _date=widget.goal.dateStart;
      _name=widget.goal.name;
      _desc=widget.goal.description; 
      _actions=widget.goal.actions;
      control_goal= TextEditingController();
      control_desc=TextEditingController(); 
  }

  @override
  Widget build(BuildContext context) {
    void changeStateAcions(List<ActionToDo> actions)
    {
      setState(() {
              _actions=actions;
            });
    }
    void actionsChange() async
    {
      dynamic newactions=await Navigator.pushNamed(context,'/ChangeActions',arguments: {"goal":control_goal.text,'actions':_actions});
      changeStateAcions(newactions);
    }
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20,20,20,0),
                  child:TextField(  
                     controller: control_goal..text=_name,
                     keyboardType: TextInputType.name,
                    onChanged: (val)
                    {
                      setState(() {                     
                        control_goal.selection=TextSelection(baseOffset: 0);
                        _name=val ;                       
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Goal"
                    ),  
                    maxLines: 1,
                    style: GoogleFonts.pacifico(
                      fontSize: 20
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(20,7,0,0),
                  child:
                      FlatButton.icon(
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
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.fromLTRB(0,7,20,0),
                    child:FlatButton(
                      color: Colors.greenAccent,
                      child: Text(
                        'Actions',
                        style:GoogleFonts.pacifico(
                          fontSize: 20
                        ),
                     ),
                    onPressed: (){
                            actionsChange();
                          },
                        ),
                      
                    ) ,
                  ]
                  ),
                Container(
                  margin: EdgeInsets.fromLTRB(20,7,20,0),
                  child: TextField(
                    onChanged: (value)
                    {
                      setState(() {
                        control_desc.selection=TextSelection(baseOffset: 0);
                        _desc=value;                        
                      });
                    },
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
                    controller: control_desc..text=_desc,
                  ),
                ), 
                Container(
                  child:FlatButton(
                    color: Colors.greenAccent,
                    child: Text("ok"),
                      onPressed: (){
                        Navigator.pop(context,Goal(name: control_goal.text,description: control_desc.text,dateStart:_date,actions:_actions,id:Uuid().v1()));
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
    );
  }
}