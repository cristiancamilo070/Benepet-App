import 'package:benepet/src/widgets/resposive_widget.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;

  double _width;
  double _pixelRatio;
  bool large;
  bool medium;

  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);

  CustomTextField(
    {this.hint,
      this.textEditingController,
      this.keyboardType,
      this.icon,
      this.obscureText= false,
     });

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
      controller: textEditingController,
      keyboardType: keyboardType,
      cursorColor: primario,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: primario, size: 20),
        hintText: hint,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
      ),
    ),
  );
  }
}