//import 'package:json_annotation/json_annotation.dart';
class ActionToDo
{
  ActionToDo({this.name,this.id});
  String id;
  String name;
  bool finished=false;
  DateTime dateStart;

  

  //String description;
  void changeName(String name){this.name=name;}
  void changedateStart(DateTime dateStart){this.dateStart=dateStart;}
  //void changedescription(String description){this.description=description;}
   Map<String, dynamic> toJson() =>
    {
     '"id"':'"$id"',
     '"name"':'"$name"',
     '"finished"':finished,
     '"date"':'"$dateStart"',  
    };
      ActionToDo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        finished= json['finished']=="true",
        dateStart=json["date"] =="null"?null:DateTime.parse(json["date"].toString());

}
class Goal 
{
  Goal({this.id,this.name,this.description="",this.dateStart,this.actions});
  String id;
  String name;
  bool finished=false;
  String description;
  DateTime dateStart;
  List<ActionToDo> actions;
  void changeName(String name){this.name=name;}
  void changedateStart(DateTime dateStart){this.dateStart=dateStart;}
  void changedescription(String description){this.description=description;}

  String getName(){return name;}
   Goal.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description=json['description'],
        finished= json['finished']=="true",
        dateStart=json["date"] =="null"?null:DateTime.parse(json["date"].toString());


    Map<String, dynamic> toJson() =>
    {
     '"id"':'"$id"',
     '"name"':'"$name"',
     '"finished"':finished,
     '"description"':'"$description"',
     '"date"':'"$dateStart"',
     '"actions"':actions.map((e) => e.toJson())
    };
     //Map<String, dynamic> toJson() => _$GoalToJson(this);

}
List<Goal> goals_=[Goal(name:'reach 100 push up'),Goal(name:"no sugar"),Goal(name:"eat healthy "),Goal(name:"sleep early"),Goal(name:"gain 1000"),Goal(name:'be rich'),Goal(name:'lose weight'),Goal(name:'learn french')];