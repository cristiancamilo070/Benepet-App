import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:flutter/material.dart';
class Textfild extends StatefulWidget {
  
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  final IconData iconSufix;


  Textfild(
    {this.hint,
      this.textEditingController,
      this.keyboardType,
      this.icon,
      this.iconSufix,
      this.obscureText= false,
     });

  @override
  _TextfildState createState() => _TextfildState();
}

class _TextfildState extends State<Textfild> {
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
    child: TextFormField(
      controller: widget.textEditingController,
      keyboardType: widget.keyboardType,
      cursorColor: primario,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, color: primario, size: 20),
        suffixIcon: Icon(widget.iconSufix,color: primario, size: 15),//added
        hintText: widget.hint,
        labelText: widget.hint,//added
        labelStyle: TextStyle(color: primario ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
      ),
    ),
  );
  }
}