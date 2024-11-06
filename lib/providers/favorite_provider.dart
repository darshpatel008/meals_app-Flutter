import 'package:riverpod/riverpod.dart';
import 'package:meals_app/models/meal.dart';


class anyNotifier extends StateNotifier<List<Meal>>
{
   anyNotifier() : super([]);//empty list

  bool toggleFavorite(Meal meal)
  {
    final mealIsFavorite = state.contains(meal);
    
    if(mealIsFavorite)
      {
        state = state.where((m)=> m.id != meal.id ).toList();
        return false;
      }
    else
      {
         state = [...state,meal];   //...copy list and create new list
         return true;
      }
  }

}


final abc = StateNotifierProvider < anyNotifier, List<Meal> >  ((ref)
{
  return anyNotifier();
});