import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filter_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import 'package:meals_app/providers/meal_provider.dart';
import 'package:meals_app/providers/favorite_provider.dart';

/*const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};*/

class TabsScreen extends  ConsumerStatefulWidget{
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {




 /* void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }*/





 /* final List<Meal> _favoriteMeals = [];

  void _toggleMealFavoriteStatus(Meal meal) {

    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) { //it is favorite now so what we want is to give access to the user to remove it
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Marked as a favorite!');
      });
    }
  } */






  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }






 // Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();  //if we click on meal
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push /*<Map<Filter, bool>>*/(  // await is used because user may click on backbutton at any time
        MaterialPageRoute(
          builder: (ctx) => const Filters(
             //currentFilters: _selectedFilters, to know  current filter is on or off  we need access of selectedfilte
            ),
        ),
      );

     // setState(() {
       // _selectedFilters = result ?? kInitialFilters;  //(_selectedFilters = kInitialFilters , if user didn't turn on filters then result is kinitalfilters which is false  )

      //});
    }
  }




  @override
  Widget build(BuildContext context) {

      final meal = ref.watch(mealprovider);

      final activeFilters = ref.watch(filterprovider);

     final availableMeals = meal.where((meal) { //where gives us new list
      if ( activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) { //if filter is set which is always set by default false  and meal is not isGlutenFree  ,  this is bool value coming from dummy data
        return false;
      }
      if ( activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if ( activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if ( activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();



   /* final availableMeals = meal.where((meal) { //where gives us new list
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) { //if filter is set which is always set by default false  and meal is not isGlutenFree  ,  this is bool value coming from dummy data
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();*/



    //how screen change
    Widget activePage = Categories(
     // onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeal: availableMeals,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1)
    {
      final favorite = ref.watch(abc);
      activePage = MealsScreen
        (
           meals: favorite,


         /* meals: _favoriteMeals*/
         // onToggleFavorite: _toggleMealFavoriteStatus,


        );
      activePageTitle = 'Your Favorites';
    }




    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}