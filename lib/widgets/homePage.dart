import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../classes/classes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../BLOC/states.dart';
import './CardWidget.dart';
import 'dart:convert';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    void getGoalsList()async
  {
    SharedPreferences pref=await SharedPreferences.getInstance();
    String listGoals= pref.get('GoalsList');
    dynamic jsonListGoals= jsonDecode(listGoals);
    List<Goal> goals=[];
    List<Goal> finishedGoals=[];
    print(jsonListGoals);
    for (dynamic goal in jsonListGoals["goals"])
    {
        List<ActionToDo> actions=[];
        for (dynamic action in goal['actions'])
        {
          actions.add(ActionToDo.fromJson(action));
        }
        Goal g=Goal.fromJson(goal);
        g.actions=actions;
        goals.add(g);
        
    }
    BlocProvider.of<GoalsCubit>(context).addAllGoals(goals);

    listGoals= pref.get('FinishedGoalsList');
    jsonListGoals= jsonDecode(listGoals);
        for (dynamic goal in jsonListGoals["goals"])
    {
        List<ActionToDo> actions=[];
        for (dynamic action in goal['actions'])
        {
          actions.add(ActionToDo.fromJson(action));
        }
        Goal g=Goal.fromJson(goal);
        g.actions=actions;
        finishedGoals.add(g);
        
    }

    BlocProvider.of<FinishedCubit>(context).addAllGoals(finishedGoals);

  
  }
  @override
  void initState() { 
    super.initState();
    try 
    {
     getGoalsList();
    }on Exception catch(e)
    {
      print("Error when loading Goals list from loacl");
    }
  }
  @override
  Widget build(BuildContext context) 
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
      void updateGoal(i) async
      {
        final dynamic updatedGoal=await Navigator.of(context).pushNamed('/ChangeGoal',arguments: BlocProvider.of<GoalsCubit>(context).state.goals[i]);
        if(updatedGoal.name !=null && updatedGoal.description!=null){
        BlocProvider.of<GoalsCubit>(context).addUpdatedGoal(updatedGoal,i);
        await sharedPref();
        }
      }
    void addGoal() async
    {
      final  new_goal=await Navigator.pushNamed(context,'/CreateGoal');
      BlocProvider.of<GoalsCubit>(context).addGoal(new_goal);
      try{
          await sharedPref();

      

      }on Exception catch(e)
      {
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
        print("Error in Shared Pref");
        print(e);
        
      }
      
     
      
  
    }

    void removeGoal(i) async
    {
          BlocProvider.of<GoalsCubit>(context).removeGoal(i);
          await sharedPref();
    }
    void finishGoal(i) async 
    {
      Goal g=BlocProvider.of<GoalsCubit>(context).state.goals[i];
      BlocProvider.of<GoalsCubit>(context).finishedGoal(i);
      BlocProvider.of<FinishedCubit>(context).addFinishedGoal(g);
      await sharedPref();
    }
    return  Scaffold(
      appBar: AppBar(
        
        actions: [IconButton(
          icon: Icon(Icons.alarm),
          onPressed: ()
          {
            Navigator.of(context).pushNamed('/FinishedGoals');
          },
        ),],
        elevation: 0,
        backgroundColor: Colors.greenAccent,
      ),
      body: BlocConsumer<GoalsCubit,GoalsState>(
        listener: (_,__){},
        builder:(context,state) 
        {
          List <Widget> list=[];
        for (int i=0;i<state.goals.length;i++)
          {
        list.add(
          GestureDetector(
            key: ValueKey(state.goals[i]),
            onDoubleTap: ()
            {
              updateGoal(i);
            },
           child:Dismissible(
                key: ValueKey(state.goals[i]),
                onDismissed: (direction)
                {     
                  if(direction == DismissDirection.endToStart)
                  {
                    removeGoal(i);
                    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("goals deleted"),));
                  }
                  else if(direction==DismissDirection.startToEnd)
                  {
                    finishGoal(i);
                   
                  }
                },
                child:CardWidget(goal: state.goals[i],icon: null,),
                background: Container(
                  margin: EdgeInsets.fromLTRB(0,4,0,4),
                  child: Align(
                    child:Icon(Icons.check_circle_outline)
                    ,alignment: Alignment(-0.6,0),
                  ),
                  color:Colors.green[800]
                ),
                secondaryBackground: Container(
                  margin: EdgeInsets.fromLTRB(0,4,0,4),
                  child: Align(
                    child:Icon(Icons.close_outlined) ,
                      alignment: Alignment(0.6,0),
                  ),  
                  color: Colors.red,
                ),
              )
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
              final item=BlocProvider.of<GoalsCubit>(context).getState().removeAt(oldIndex);
              BlocProvider.of<GoalsCubit>(context).getState().insert(newIndex,item);                    
            });
          },
        );
        },
      ),
    floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed:(){
          print("sssssssssssssssssss");
          addGoal();
        } ,  
      ),
    );
  }
}
 
