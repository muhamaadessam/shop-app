import 'package:get/get.dart';
import 'package:untitled/model/deals_model.dart';

class FavoriteController extends GetxController{
  var favList = <Deals>[].obs;

  void addFavItemToList(Deals deals){
    favList.add(deals);
  }

}