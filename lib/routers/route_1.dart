import 'package:flutter/material.dart';
import '../widgets/passwordPage.dart';
import '../widgets/homePage.dart';
import '../widgets/createPage.dart';
import '../widgets/testPage.dart';
import '../widgets/changePage.dart';
import '../widgets/ActionsPage.dart';
import '../widgets/ChangeActions.dart';
import '../widgets/FinishedGoals.dart';
class RouteGenerator
{
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    final args=settings.arguments;

    switch (settings.name)
    {
      case '/password':
        return MaterialPageRoute(builder: (_)=>PasswordPage());
      case '/home':
        return MaterialPageRoute(builder: (_)=>HomePage());
      case '/CreateGoal':
        return MaterialPageRoute(builder: (_)=>CreateGoalPage());
      case '/ChangeGoal':
        return MaterialPageRoute(builder: (_)=>ChangeGoalPage(goal: args,));
      case '/Actions':
        return MaterialPageRoute(builder: (_)=>ActionsPage(goal: args,));
      case '/ChangeActions':
        return MaterialPageRoute(builder: (_)=>ActionsChangePage(data: args,));
      case '/FinishedGoals':
        return MaterialPageRoute(builder: (_)=>FinishedGoalsPage());


      case '/test':
      return MaterialPageRoute(builder: (_)=>Test());
    }
  }
}