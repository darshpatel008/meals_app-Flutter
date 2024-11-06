//meal screen implementation



import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';


class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal,required this.onSelectMeal});

  final void Function(BuildContext context,Meal meal) onSelectMeal;


  final Meal meal;

  String get complexityText
  {
    return meal.complexity.name[0].toUpperCase()+meal.complexity.name.substring(1);
  }
  String get affordabilityText
  {
    return meal.affordability.name[0].toUpperCase()+meal.affordability.name.substring(1);
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
      elevation: 2,
      clipBehavior: Clip.hardEdge, //cut off all thing outside of border
      child: InkWell
        (
        onTap:(){onSelectMeal(context ,meal);},


        child: Stack(
          children: [

            Hero(
              tag: meal.id,
              child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage), //from package
                    image: NetworkImage(meal.imageUrl),
                   fit: BoxFit.cover,
                   height: 200,
                  width: double.infinity,
                ),
            ),


            Positioned(
              left: 0,
              right: 0,
              bottom: 0,

              child: Container(
                color: Colors.black54, //transparent black
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 44, vertical: 6),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          MealItemTrait(
                              icon: Icons.schedule,
                              label: '${meal.duration}'),
                          const SizedBox(width: 12),
                          MealItemTrait(
                              icon: Icons.work,
                              label: complexityText),
                          const SizedBox(width: 12),
                          MealItemTrait(
                              icon: Icons.attach_money,
                              label: affordabilityText),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}