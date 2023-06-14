import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shamba_huru/data/farm_details.dart';

class MyFarmController extends GetxController {
  final Rx<MyFarmData> farmData = MyFarmData().obs;
  final String nameControl = "Farm Name";
  final String cropControl = "Crop";
  final String areaControl = "Area Size";
  late FormGroup form;

  @override
  void onInit() {
    super.onInit();
    form = FormGroup({
      nameControl: FormControl<String>(
        validators: [Validators.required],
      ),
      cropControl: FormControl<String>(
        validators: [Validators.required],
      ),
      areaControl: FormControl<String>(
        validators: [Validators.required],
      ),
    });
  }

  void updateValues(String name, String crop, String area) {
    form.control(nameControl).value = name;
    form.control(cropControl).value = crop;
    form.control(areaControl).value = area;
  }

  void clearValues() {
    form.control(nameControl).value = "";
    form.control(cropControl).value = "";
    form.control(areaControl).value = "";
  }
}
