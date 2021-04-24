import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../classes/classes.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../BLOC/states.dart';
import './CardWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FinishedGoalsPage extends StatefulWidget {
  FinishedGoalsPage({Key key}) : super(key: key);

  @override
  _FinishedGoalsPageState createState() => _FinishedGoalsPageState();
}
class _FinishedGoalsPageState extends State<FinishedGoalsPage> {
  bool buttomAppBar=false;
  int indexClickedGoal;


  Widget buttomBar()
  {
    Future  sharedPref()async
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String json=BlocProvider.of<GoalsCubit>(context).state.toJson().toString();
        json=json.replaceAll('(', "[");
        json=json.replaceAll(')', "]");
        await prefs.setString("GoalsList", json);

        json=BlocProvider.of<FinishedCubit>(context).state.toJson().toString();
        json=json.replaceAll('(', "[");
        json=json.replaceAll(')', "]");
        await prefs.setString("FinishedGoalsList", json);
      }
    return AnimatedContainer(
      duration: Duration(seconds: 4),
      child:BottomAppBar(
        child: Row(
          children: [
            IconButton(
              icon:Icon(Icons.cancel),
              onPressed: (){
                setState(() {
                  buttomAppBar=false;
                });
              },
            ),
            IconButton(
              icon:Icon(Icons.delete),
              onPressed: ()async{
                BlocProvider.of<FinishedCubit>(context).removeGoal(indexClickedGoal);
                await sharedPref();
                setState(() {
                  buttomAppBar=false;       
                  }); 
              },
            ),
            IconButton(
              icon:Icon(Icons.arrow_upward),
              onPressed: ()async
              {
                Goal goal=BlocProvider.of<FinishedCubit>(context).state.finishedGoals[indexClickedGoal];
                BlocProvider.of<FinishedCubit>(context).removeGoal(indexClickedGoal);
                BlocProvider.of<GoalsCubit>(context).addGoal(goal);
                                setState(() {
                  buttomAppBar=false;       
                  }); 
                await sharedPref();


                },
              ),
          ],
        ),
    )
      ) ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: !buttomAppBar?null:buttomBar(),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle:true,
         title: Text("Goals achieved"),
      ),
      body: SafeArea(

        child:BlocConsumer<FinishedCubit,FinishedState>(
          listener: (_,__){},
          builder:(context,state)
          {
            List <Widget> list=[];
            for (int i=0;i<state.finishedGoals.length;i++)
            {
              list.add(
              GestureDetector(
                key: ValueKey(state.finishedGoals[i]),
                onDoubleTap: ()
                {
                  setState(() {
                  indexClickedGoal=i; 
                  buttomAppBar=true;                    
                  });
                  print(buttomAppBar);
                  
                },
                child:CardWidget(goal: state.finishedGoals[i],icon: Icons.check,leadingColor: Colors.greenAccent ),   
              )
              );
            }
            return ReorderableListView(
              children: list,
              onReorder: (oldIndex,newIndex)
              {
                setState(() {
                  if(newIndex>oldIndex) 
                  {
                    newIndex-=1;
                  }
                  final item=BlocProvider.of<FinishedCubit>(context).state.finishedGoals.removeAt(oldIndex);
                  BlocProvider.of<FinishedCubit>(context).state.finishedGoals.insert(newIndex,item);                    
                });
              },
            );
          },
        ) ,
      ),
    );
  }
}