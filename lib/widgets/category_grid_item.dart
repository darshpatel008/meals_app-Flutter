//grid screen implementation


import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';



class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key,
    required this.category, required this.onSelectedCategory});



  final Category category;
  final void Function() onSelectedCategory;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onSelectedCategory,


      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors:
                [
                  category.color.withOpacity(0.55),
                  category.color.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  category.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                )


              ),
            ),
          ),

    );
  }
}
