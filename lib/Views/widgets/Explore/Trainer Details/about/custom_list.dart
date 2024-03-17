import 'package:flutter/material.dart';

class AwardData {
  final String imagePath;

  AwardData({
    required this.imagePath,
  });
}

class AwardCard extends StatelessWidget {
  final AwardData awardData;

  const AwardCard({Key? key, required this.awardData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Image.asset(
      awardData.imagePath,
      width: 100,
    );
  }
}


class AwardsListHorizontal extends StatelessWidget {
  final List<AwardData> awardsList;

  const AwardsListHorizontal({Key? key, required this.awardsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: awardsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 5.0),
            child: AwardCard(awardData: awardsList[index]),
          );
        },
      ),
    );
  }
}
