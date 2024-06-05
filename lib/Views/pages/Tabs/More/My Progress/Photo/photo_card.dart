import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../utils/colors.dart';

class PhotoCard extends StatelessWidget {
  final String imageUrl;
  final String date;

  const PhotoCard({Key? key, required this.imageUrl, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/svgs/cameraa.svg',
                ),
                SizedBox(width: 8.0),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BoldCairo',
                    color: colorDarkBlue,
                  ),
                ),
                Spacer(),
                SvgPicture.asset(
                  'assets/svgs/trash-4.svg',
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 130,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error);
              },
            ),
          ],
        ),
      ),
    );
  }
}
