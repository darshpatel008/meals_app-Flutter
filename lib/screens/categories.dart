//greed screen


import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/models/category.dart';

class Categories extends StatefulWidget
{
  const Categories({super.key,/*required this.onToggleFavorite*/required this.availableMeal});

  //final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeal;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with SingleTickerProviderStateMixin{

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
   animationController = AnimationController(
     vsync: this,
     duration: const Duration(milliseconds: 300),
     lowerBound: 0,
     upperBound: 1,
    );

   animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }




  
  void _selectedCategory(BuildContext context , Category category)
  {
    final filteredMeal = widget.availableMeal.where((meal) => meal.categories.contains(category.id)).toList();

      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)
      {
        return MealsScreen(title:category.title , meals:filteredMeal ,/*onToggleFavorite: onToggleFavorite*/);
      },
      ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),

          children:
          [
            for(final category in availableCategories) //in dummy data
              CategoryGridItem(
                onSelectedCategory: () {
                  _selectedCategory(context, category);
                },
                category: category, //passing our final category to category_grid_item.dart
              ),

          ],
        ),
        animation: animationController,
        builder: (context, child) =>



            SlideTransition(
                position:
                  Tween(begin: Offset(0, 0.3),
                      end: Offset(0, 0)
                  ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
                  ),
                child: child)
    );
    // Padding(padding: EdgeInsets.only(top: 100- animationController.value*100 // initally padding is 100 animationcon is 0 then its 1 * 100 so 100-100=0 padding ),
    // child: child)

  }
      


  }

