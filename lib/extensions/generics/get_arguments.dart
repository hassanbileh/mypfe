import 'package:flutter/material.dart' show BuildContext, ModalRoute; 

/* This extension is used on buildcontext for returning 
   arguments (note) while updating a note 
*/
extension GetArgument on BuildContext{
  T? getArguments<T>(){
    final modalRoute = ModalRoute.of(this);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      if(args != null && args is T){
        return args as T;
      }
    }
    return null;
  }
}