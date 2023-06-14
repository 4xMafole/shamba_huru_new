import 'package:flutter/material.dart';
import 'package:shamba_huru/features/crop_detection/diseases/AppleScab.dart';
import 'package:shamba_huru/features/crop_detection/diseases/CornCommonRust.dart';
import 'package:shamba_huru/features/crop_detection/diseases/GrapeBlackRot.dart';
import 'package:shamba_huru/features/crop_detection/diseases/PotatoEarlyBlight.dart';

class DiseaseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CornCommonRust(
                          title: '',
                        )),
              );
            },
            child:
                diseases('assets/crops/10.jpg', 'Trending', 'Corn Common Rust'),
            // Photo from https://unsplash.com/photos/wHUFmZRMpLc
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AppleScab(
                          title: '',
                        )),
              );
            },
            child: diseases('assets/crops/2.jpg', 'Trending', 'Apple Scab'),
            // Photo from https://unsplash.com/photos/2d4lAQAlbDA
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PotatoEarlyBlight(
                            title: '',
                          )),
                );
              },
              child: diseases(
                  'assets/crops/18.jpg', 'Trending', 'Potato Early Blight')
              // Photo from https://unsplash.com/photos/561igiTyvSk
              ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GrapeBlackRot(
                            title: '',
                          )),
                );
              },
              child:
                  diseases('assets/crops/25.jpg', 'Trending', 'Grape Black Rot')
              // Photo from https://unsplash.com/photos/561igiTyvSk
              )
        ],
      ),
    );
  }

  Widget diseases(
    String imageurl,
    String tag,
    String name,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: <Widget>[
              Image.asset(
                imageurl,
                height: 330,
                width: 230,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 16,
                left: 140,
                child: Container(
                    height: 25.0,
                    width: 80.00,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Color(0xff0F0F0F),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff0F0F0F).withOpacity(0.3),
                          )
                        ]),
                    child: Center(
                      child: Text(
                        tag,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            name,
            style: TextStyle(fontFamily: 'ConcertOne-Regular'),
          ),
        ),
      ],
    );
  }
}
