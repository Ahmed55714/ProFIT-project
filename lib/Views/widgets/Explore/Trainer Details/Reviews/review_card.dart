import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/utils/colors.dart';

class ReviewCard extends StatelessWidget {
  final double rating;
  final String comment;
  final String traineeName;
  final String reviewDate;
  final String avatarUrl;

  const ReviewCard({
    Key? key,
    required this.rating,
    required this.comment,
    required this.traineeName,
    required this.reviewDate,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: grey200,
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/svgs/star-2.svg'),
                SizedBox(width: 4),
                Text(
                  rating.toStringAsFixed(1),
                  style: TextStyle(
                    color: greenReview,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              comment,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: avatarUrl.isNotEmpty
                        ? Image.network(
                            avatarUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/profileHome.png',
                                width: 50,
                                height: 50,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/images/profileHome.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      traineeName,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: colorDarkBlue,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      reviewDate,
                      style: TextStyle(
                        color: grey500,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
