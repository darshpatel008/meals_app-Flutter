import 'package:riverpod/riverpod.dart';



enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}


class filterNotifier extends StateNotifier<Map<Filter,bool>>
{
  filterNotifier() : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  });

  void setFilters(Map<Filter,bool> chosenFilter)
  {
    state = chosenFilter;
  }

  void setFilter(Filter filter , bool isActive)
  {
    state = {...state,filter:isActive};
  }
}





final filterprovider = StateNotifierProvider< filterNotifier , Map<Filter,bool> >(
  (ref)
{
  return filterNotifier();
}
);