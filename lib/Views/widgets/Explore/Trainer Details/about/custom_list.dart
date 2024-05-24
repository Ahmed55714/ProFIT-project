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
                    awardData.imagePath,
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
        child: Image.network(
          awardData.imagePath,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error);
          },
        ),
      ),
    );
  }
}

class AwardsListHorizontal extends StatelessWidget {
  final List<AwardData> awardsList;

  const AwardsListHorizontal({Key? key, required this.awardsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: awardsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: AwardCard(awardData: awardsList[index]),
          );
        },
      ),
    );
  }
}
