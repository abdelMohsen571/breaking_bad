import 'package:breaking_bad/constants/my_colors.dart';
import 'package:breaking_bad/data/models/Charcters.dart';
import 'package:flutter/material.dart';

class CharctersItem extends StatelessWidget {
  final Character charcter;
  const CharctersItem(
    this.charcter, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        padding: EdgeInsetsDirectional.all(4),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(9)),
        child: GridTile(
          child: Container(
            color: MyColors.swatchColor,
            child: charcter.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.gif",
                    image: charcter.image)
                : Image.asset("assets/images/Capture.PNG"),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            color: Colors.black45,
            alignment: Alignment.bottomCenter,
            child: Text(
              "${charcter.name}",
              style: TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
