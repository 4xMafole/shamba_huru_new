import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:shamba_huru/features/crop_detection/diseases/AppleCedarRust.dart';
import 'package:shamba_huru/features/crop_detection/diseases/AppleScab.dart';
import 'package:shamba_huru/features/crop_detection/diseases/CornCommonRust.dart';
import 'package:shamba_huru/features/crop_detection/diseases/CornGrayLeaf.dart';
import 'package:shamba_huru/features/crop_detection/diseases/GrapeBlackRot.dart';
import 'package:shamba_huru/features/crop_detection/diseases/GrapeEsca.dart';
import 'package:shamba_huru/features/crop_detection/diseases/GrapeLeafBlight.dart';
import 'package:shamba_huru/features/crop_detection/diseases/NorthernCornLeafBlight.dart';
import 'package:shamba_huru/features/crop_detection/diseases/PotatoEarlyBlight.dart';
import 'package:shamba_huru/features/crop_detection/diseases/PotatoLateBlight.dart';
import 'package:shamba_huru/features/crop_detection/diseases/TomatoEarlyBlight.dart';
import 'package:shamba_huru/features/crop_detection/diseases/TomatoLateBlight.dart';
import 'package:tflite/tflite.dart';
import '../../extras/utils/app_colors.dart';
import 'disease_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:image/image.dart' as img;

const String mobile = "MobileNet";

class CropDashboard extends StatefulWidget {
  const CropDashboard({Key? key}) : super(key: key);

  @override
  _CropDashboardState createState() => _CropDashboardState();
}

class _CropDashboardState extends State<CropDashboard> {
  File? _image;
  List? _recognitions;
  String _model = mobile;
  double? _imageHeight;
  double? _imageWidth;
  bool dialVisible = true;
  ProgressDialog? pr;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  void resultPage(BuildContext context, String name) {
    if (name == "Apple Cedar Rust") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AppleCedarRust(
                  title: '',
                )),
      );
    } else if (name == "Apple Black Rot") {
      showErrorProcessing(context);
    } else if (name == "Apple Scab") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AppleScab(
                  title: '',
                )),
      );
    } else if (name == "Corn Common Rust") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CornCommonRust(
                  title: '',
                )),
      );
    } else if (name == "Corn Gray Leaf Spot") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CornGrayLeaf(
                  title: '',
                )),
      );
    } else if (name == "Corn Northern Leaf Blight") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NorthernCornLeafBlight(
                  title: '',
                )),
      );
    } else if (name == "Grape Black Rot") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GrapeBlackRot(
                  title: '',
                )),
      );
    } else if (name == "Grape Esca") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GrapeEsca(
                  title: '',
                )),
      );
    } else if (name == "Grape Leaf Blight") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GrapeLeafBlight(
                  title: '',
                )),
      );
    } else if (name == "Potato Early Blight") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PotatoEarlyBlight(
                  title: '',
                )),
      );
    } else if (name == "Potato Late Blight") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PotatoLateBlight(
                  title: '',
                )),
      );
    } else if (name == "Tomato Bacterial Spot") {
      showErrorProcessing(context);
    } else if (name == "Tomato Early Blight") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TomatoEarlyBlight(
                  title: '',
                )),
      );
    } else if (name == "Tomato Late Blight") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TomatoLateBlight(
                  title: '',
                )),
      );
    } else if (name == "Tomato Leaf Mold") {
      showErrorProcessing(context);
    } else if (name == "Tomato Mosaic Virus") {
      showErrorProcessing(context);
    } else if (name == "Tomato Septoria Leaf Spot") {
      showErrorProcessing(context);
    } else if (name == "Tomato Spider Mites") {
      showErrorProcessing(context);
    } else if (name == "Tomato Target Spot") {
      showErrorProcessing(context);
    } else if (name == "Tomato Yellow Leaf Curl Virus") {
      showErrorProcessing(context);
    }
  }
//
//  Future<void> _optionsDialogBox() {
//    var state=false;
//    return showDialog(context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            content: new SingleChildScrollView(
//              child: new ListBody(
//                children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.all(5.0),
//                  ),
//                  GestureDetector(
//                    child: new Text('Take a picture'),
//                    onTap: getCamera,
//
//                  ),
//                  Padding(
//                    padding: EdgeInsets.all(10.0),
//                  ),
//                  GestureDetector(
//                    child: new Text('Select from gallery'),
//                    onTap: getImage,
//
//                  ),
//
//                  Padding(
//                    padding: EdgeInsets.all(5.0),
//                  ),
//                ],
//              ),
//            ),
//
//          );
//        });
//  }

  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  void showCustomDialogWithImage(BuildContext context, var labelForHighest) {
    Dialog dialogWithImage = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 360.0,
        width: 300.0,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              child: Text(
                "We are not sure with the disease . Do you still wish to check the disease?",
                style: TextStyle(
                    fontFamily: "ConcertOne-Regular",
                    color: AppColor.paleBrown,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              height: 200,
              width: 300,
              child: Image.asset(
                'assets/crops/confusion.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
               ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColor.paleGreen),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'No',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
               ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColor.paleGreen),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    resultPage(context, labelForHighest);
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => dialogWithImage);
  }

  Future recognizeImage(File image) async {
    print("DEBUG: Inside Recognize Image Function");
    try {
      double percentage = 0.0;
      pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
      pr?.style(
        message: 'Detecting Disease...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: AppColor.paleBrown,
            fontSize: 13.0,
            fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: AppColor.paleBrown,
            fontSize: 19.0,
            fontWeight: FontWeight.w600),
      );
      var labelForHighest = "";
      double confidence = -1.00;
      // var imageBytes = (await rootBundle.load((image.path))).buffer; // Oppose a question in stackoverflow for this answer
      var imageBytes = await image.readAsBytes();
      print(imageBytes);
      // img.Image? oriImage = img.decodeJpg(imageBytes.asUint8List());
      img.Image? oriImage = img.decodeJpg(Uint8List.fromList(imageBytes));
      img.Image resizedImage =
          img.copyResize(oriImage!, width: 299, height: 299);
      var recognitions = await Tflite.runModelOnBinary(
        binary: imageToByteListFloat32(resizedImage, 299, 0, 255.0),
        numResults: 3,
        threshold: 0.4,
      );
      setState(() {
        _recognitions = recognitions;
      });

      pr?.show();

      Future.delayed(Duration(seconds: 1)).then((onvalue) {
        percentage = percentage + 30.0;
        print(percentage);

        pr?.update(
          progress: percentage,
          message: "Checking Confidence..",
          maxProgress: 100.0,
          progressTextStyle: TextStyle(
              color: AppColor.paleBrown,
              fontSize: 13.0,
              fontWeight: FontWeight.w400),
          messageTextStyle: TextStyle(
              color: AppColor.paleBrown,
              fontSize: 19.0,
              fontWeight: FontWeight.w600),
        );

        Future.delayed(Duration(seconds: 1)).then((value) {
          percentage = percentage + 30.0;
          pr?.update(progress: percentage, message: "Few more seconds...");
          print(percentage);
          Future.delayed(Duration(seconds: 2)).then((value) {
            percentage = percentage + 30.0;
            pr?.update(progress: percentage, message: "Almost done..");
            print(percentage);

            Future.delayed(Duration(seconds: 1)).then((value) {
              pr?.hide().whenComplete(() {
                print(pr?.isShowing());
              });
              percentage = 0.0;
            });
          });
        });
      });
      Future.delayed(Duration(seconds: 6)).then((onValue) {
        print("PR status  ${pr?.isShowing()}");
        if (pr!.isShowing())
          pr?.hide().then((isHidden) {
            print(isHidden);
          });
        print("PR status  ${pr?.isShowing()}");

        if (_recognitions!.isEmpty == false) {
          for (int i = 0; i < _recognitions!.length; i++) {
            print(_recognitions![i]);
            if (_recognitions![i]['confidence'] > confidence) {
              labelForHighest = _recognitions![i]['label'];
              confidence = _recognitions![i]['confidence'];
            }
          }

          print(labelForHighest);
          print(confidence);
          if (confidence.abs() > 0.80) {
            resultPage(context, labelForHighest);
          } else {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) =>
//                  AlertDialog(
//                    shape: RoundedRectangleBorder(
//                        borderRadius:
//                        BorderRadius.circular(20.0)),
//                    title: Text("We are not sure with the disease as the Confidence of result is low. Do you still wish to continue?"),
//                    actions: <Widget>[
//                      FlatButton(child: Text("No"),
//                        onPressed: (){
//                          Navigator.pop(context);
//                        },
//                      ),
//                      FlatButton(child: Text("Yes"),
//                        onPressed: (){
//                          Navigator.pop(context);
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//
//                                builder: (context) => DiseaseResult(title: labelForHighest)),
//                          );
//                        },
//                      )
//                    ],
//                  )

//              ),
//            );
            showCustomDialogWithImage(context, labelForHighest);
          }
        } else {
          showErrorProcessing(context);
        }
      });
    } on Exception {
      showErrorProcessing(context);
    }
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    //onSelect(mobile);
    if (image == null) return;
    predictImage(File(image.path));
  }

  Future getCamera() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.camera);
    //onSelect(mobile);
    if (image == null) return;
    predictImage(File(image.path));
  }

  Future predictImage(File image) async {
    print("DEBUG: Inside Predict Image Function");
    await recognizeImage(image);
    // await recognizeImageBinary(image);

    new FileImage(image)
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        _imageHeight = info.image.height.toDouble();
        _imageWidth = info.image.width.toDouble();
      });
    }));
  }

  Future loadModel() async {
    print("DEBUG: Inside Load Model Function");
    Tflite.close();
    try {
      String? res;
      res = (await Tflite.loadModel(
        model: "assets/crops/model.tflite",
        labels: "assets/crops/labels.txt",
      ));
      print(res);
    } on PlatformException {
      print('Failed to load model.');
      showErrorProcessing(context);
    }
  }

  onSelect(model) async {
    setState(() {
      _recognitions = null;
    });
    await loadModel();
    if (_image != null) predictImage(File(_image!.path));
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  void showErrorProcessing(BuildContext context) {
    Dialog dialogWithImage = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 410.0,
        width: 300.0,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              child: Text(
                "We encountered a issue while processing!\nTip: Please make sure you take the image up close and with proper lighting.",
                style: TextStyle(
                    fontFamily: "ConcertOne-Regular",
                    color: AppColor.paleBrown,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              height: 200,
              width: 300,
              child: Image.asset(
                'assets/crops/oops.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColor.paleGreen),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => dialogWithImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 25, right: 14, top: 30, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: greeting(),
                            style: TextStyle(
                              color: AppColor.paleBrown,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                              text: ' User!',
                              style: TextStyle(
                                  fontFamily: 'ConcertOne-Regular',
                                  color: AppColor.paleBrown,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Browse new recommended diseases.'),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: AppColor.paleGrey,
                  radius: 30,
                  child: ClipOval(
                      child: Image.asset(
                    'assets/images/user.png',
                    fit: BoxFit.cover,
                    width: 55.0,
                    height: 55.0,
                  )),
                ),
              ],
            ),
          ),
          DiseaseList(),
          SizedBox(height: 10),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(
          color: Colors.white,
          size: 25,
        ),
        visible: dialVisible,
        curve: Curves.bounceInOut,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Toggle',
        heroTag: 'toggele-hero-tag',
        backgroundColor: AppColor.paleGreen,
        foregroundColor: Colors.white,
        overlayOpacity: 0.7,
        elevation: 10.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(
                Icons.camera,
                size: 24,
                color: AppColor.paleGreen,
              ),
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                fontSize: 18.0,
              ),
              onTap: () => getCamera()),
          SpeedDialChild(
              child: Icon(Icons.image, size: 24, color: AppColor.paleGreen),
              backgroundColor: Colors.white,
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => getImage()),
        ],
      ),
    );
  }
}
