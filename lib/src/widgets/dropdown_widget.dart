import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:flutter/material.dart';
class DropdownFild extends StatefulWidget {
  
  List<DropdownMenuItem<String>> list;
  String initialValue;

  
  final IconData icon;
  final IconData iconSufix;


  DropdownFild(
    { this.list,
      this.initialValue,
      
      this.icon,
      this.iconSufix,
     });

  @override
  _DropdownFild createState() => _DropdownFild();
}

class _DropdownFild extends State<DropdownFild> {
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;

  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    
  return Material(
    borderRadius: BorderRadius.circular(30.0),
    elevation: large? 12 : (medium? 10 : 8),

    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 13),
        Icon(widget.icon ,color: primario),
        SizedBox(width: 20,),
        Expanded(
          child: DropdownButton(
            iconEnabledColor:  primario,
            iconDisabledColor: terciario,
            style: TextStyle(color: primario), 
            items: widget.list,
            value: widget.initialValue,
            onChanged: (opt){
              setState(() {
                widget.initialValue=opt;
               }
               );
             }
          )
        ),
        SizedBox(width: 15,),
        Icon(widget.iconSufix,color: primario,),
        SizedBox(width: 10)
      ],
    ),
  );
  }
}