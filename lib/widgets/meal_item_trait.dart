



import 'package:flutter/cupertino.dart';


class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key,required this.icon,required this.label});

  final String label;
  final IconData icon;


  @override
  Widget build(BuildContext context) {
    return Row(
     children: [
       Icon(icon,size: 17,color: Color.fromRGBO(255, 255, 255, 1),),
       SizedBox(),
       Text(label,style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
     ],
    );
  }
}
