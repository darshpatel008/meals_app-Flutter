import 'package:meals_app/data/dummy.dart';
import 'package:riverpod/riverpod.dart';

final mealprovider = Provider((ref){
  return dummyMeals;
});