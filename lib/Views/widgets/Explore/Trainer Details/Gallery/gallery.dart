import 'package:flutter/material.dart';
import 'package:profit1/utils/colors.dart';


class TransformationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: grey200),
          
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              Row(
                children: [
                 Expanded(child: RoundedImage()),
                 Expanded(child: RoundedImage()),
                ],
              ),
              
                 Text(
                  'محمد أنور',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color:colorDarkBlue
                  ),
                ),
                SizedBox(height: 8),
                Divider(color: grey200, thickness: 1,
                indent: 16,
                endIndent: 16,
                ),
              
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'محمد فاقد 3 كيلو وشد ونحت وزاد وزن وشد بشكل عام على.\n'
                  'رغم ظروفه الصعبة وظروف وبعد وجود رمضان داخل الأوكي',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color:colorDarkBlue
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class RoundedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 160, 
        height: 199, 
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8), 
          child: Image.asset(
            'assets/images/photo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}