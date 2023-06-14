import 'package:get/get.dart';

class CropSelectionController extends GetxController {
  RxList<String> countList = [
    "abaca",
    "alfalfa for fooder",
    "alfalfa for seed",
    "almond",
    "anise seeds",
    "apple",
    "apricot",
    "areca",
    "arracha",
    "arrowroot",
    "artichoke",
    "artichoke, Jerusalem",
    "asparagus",
    "avocado",
    "bajra(millet)",
    "bambara groundnuts",
    "banana",
    "barley",
    "bean, dry, edible",
    "bean, fodder(mangel)",
    "been, harvested green",
    "beet, red",
    "beet, sugar",
    "beet, sugar fodder",
    "bergamot",
  ].obs;
  RxList<String> selectedCountList = ["empty"].obs;
}
