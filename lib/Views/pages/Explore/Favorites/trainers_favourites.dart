import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';
import 'package:profit1/utils/colors.dart';

import '../../../widgets/Explore/Trainers/trainer_continer.dart';
import '../../Tabs/Explore/controller/trainer_controller.dart';
import '../../Tabs/Explore/model/trainer.dart';

class TrainerFavourites extends StatefulWidget {
  const TrainerFavourites({Key? key}) : super(key: key);

  @override
  _TrainerFavouritesState createState() => _TrainerFavouritesState();
}

class _TrainerFavouritesState extends State<TrainerFavourites> {
  final ExploreController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.fetchFavoriteTrainers();
  }

  void removeTrainerFromList(Trainer trainer) {
    controller.favoriteTrainers.remove(trainer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.favoriteTrainers.isEmpty) {
          return Center(child: Text('No favorite trainers found'));
        }
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.favoriteTrainers.length,
          itemBuilder: (context, index) {
            Trainer trainer = controller.favoriteTrainers[index];
            return Column(
              children: [
                TrainerCard(
                  trainer: trainer,
                  isFavoriteScreen: true,
                  onFavoriteChanged: () => removeTrainerFromList(trainer),
                ),
               
              ],
            );
          },
        );
      }),
    );
  }
}

