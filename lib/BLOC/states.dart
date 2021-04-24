import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import '../classes/classes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalsState
{
  List<Goal> goals;
  GoalsState({
     @required this.goals,
  });
  Map<String, dynamic> toJson() =>
    {
     '"goals"':goals.map((g) => g.toJson())
    };
}
class GoalsCubit extends Cubit<GoalsState>
{
  //GoalsCubit():super(GoalsState(goals:[Goal(name:'reach 100 push up'),Goal(name:"no sugar"),Goal(name:"eat healthy "),Goal(name:"sleep early"),Goal(name:"gain 1000"),Goal(name:'be rich'),Goal(name:'lose weight'),Goal(name:'learn french')]));
  GoalsCubit():super(GoalsState(goals:[]));

  List<Goal> getState()
  {
    return state.goals;
  }
  void addAllGoals(List<Goal> listGoal)
  {
    emit(GoalsState(goals: listGoal));
  }
  void addUpdatedGoal(Goal goal, int i)
  {
    List <Goal> g=state.goals;
    g[i]=goal;
    emit(GoalsState(goals: g));

  }
  void addGoal(Goal goal){
    List<Goal>s=state.goals;
    if(goal.name!=null){
      s.add(goal);
    }
    emit(GoalsState(goals:s));
  }
  void changeGoal(Goal goal,int id)
  {
    List <Goal>z=state.goals;
    z[id-1]=goal;
    emit(GoalsState(goals: z));    
  }
  void removeGoal(int i)
  {
    List<Goal> g=state.goals;
    g.removeAt(i);
    emit(GoalsState(goals: g));
  }
  void finishedGoal(i)
  {
    List <Goal> g=state.goals;
    g[i].finished=true;
    g.removeAt(i);
    emit(GoalsState(goals: g));
  }

 }

 class FinishedState
{
  List<Goal> finishedGoals;
  FinishedState({
     @required this.finishedGoals,
  });
    Map<String, dynamic> toJson() =>
    {
     '"goals"':finishedGoals.map((g) => g.toJson())
    };
}
class FinishedCubit extends Cubit<FinishedState>
{
  FinishedCubit():super(FinishedState(finishedGoals: []));
  
  void addFinishedGoal(Goal goal)
  {
    List <Goal> g=state.finishedGoals;
    g.add(goal);
    emit(FinishedState(finishedGoals: g));
  }
    void addAllGoals(List<Goal> listGoal)
  {
    emit(FinishedState(finishedGoals: listGoal));
  }
  void removeGoal(i)
  {
    List<Goal> g=state.finishedGoals;
    g.removeAt(i);
    emit(FinishedState(finishedGoals: g));
  }

 }




