import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';
import '../../../../../../services/api_service.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../widgets/BottomSheets/progress/photo.dart';
import '../../../../../widgets/General/customBotton.dart';
import 'controller/controller.dart';

class Photos extends StatelessWidget {
  const Photos({super.key});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddPhotoBottomSheet(),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
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
  }

  @override
  Widget build(BuildContext context) {
    final photoController = Get.put(PhotoController(ApiService()));

    return Scaffold(
      backgroundColor: grey50,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (photoController.isLoading.value) {
                    return Center(child: CustomLoder(
                      color: colorBlue,
                      size: 35,
                    ));
                  } else if (photoController.errorMessage.isNotEmpty) {
                    return Center(child: Text(photoController.errorMessage.value));
                  } else {
                    return ListView.builder(
                      itemCount: photoController.photos.length,
                      itemBuilder: (context, index) {
                        final photo = photoController.photos[index];
                        return Column(
                          children: [
                            SizedBox(height: 24.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16,),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: grey200,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svgs/cameraa.svg',
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          photo.createdAt,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'BoldCairo',
                                            color: colorDarkBlue,
                                          ),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          icon: SvgPicture.asset('assets/svgs/trash-4.svg'),
                                          onPressed: () {
                                            photoController.deletePhoto(photo.id);
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.0),
                                    GestureDetector(
                                      onTap: () {
                                        _showImageDialog(context, photo.photoUrl);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          photo.photoUrl,
                                          width: double.infinity,
                                          height: 130,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CustomButton(
                  text: 'Upload Photo',
                  onPressed: () {
                    _showBottomSheet(context);
                  },
                ),
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.white.withOpacity(0.6),
                        Colors.white.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
