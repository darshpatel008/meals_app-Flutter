import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

import 'package:meals_app/providers/favorite_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
    /*required this.onToggleFavorite*/
  });

//final void Function(Meal meal) onToggleFavorite;

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final favoriteMeal = ref.watch(abc);
    final isFavorite = favoriteMeal.contains(meal);


    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(abc.notifier)
                  .toggleFavorite(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? 'Marked as a favorite!'
                      : 'Meal is no longer a favorite.'),
                ),
              );

              // onToggleFavorite(meal);              //passing our meal go to mealscreen copy paste this ontoggle
            },

            icon: AnimatedSwitcher(
                child:Icon(isFavorite? Icons.star : Icons.star_border, key: ValueKey(isFavorite),),
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child,animation)
                {
                   return RotationTransition(
                       turns: Tween(begin: 0.8,end: 1.0).animate(animation),
                       child: child);


                },
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Hero(
            tag: meal.id,
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'List of ingredienets',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < meal.ingredients.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                '${i + 1}.  ${meal.ingredients[i]}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Steps:-',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 14),
          const SizedBox(height: 14),
          for (int i = 0; i < meal.steps.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '${i + 1}.  ${meal.steps[i]}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}
