import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';

import '../../../../utils/colors.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/BottomSheets/add_challenge.dart';
import '../../../widgets/Diet/custom_image_and_details.dart';
import '../../../widgets/Diet/food_alternate.dart';
import '../../../widgets/Explore/Trainer Details/Packages/package.dart';
import '../../Profile/profile Screen/profile_screen.dart';
import '../Diet Plan Overview/Meals/Breakfast.dart';

class ShoppingList extends StatefulWidget {
  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  int selectedFoodIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: 'Shopping List',
        isShowFavourite: true,
      ),
      body: Column(
        children: [
          const CustomLabelWidget(title: 'Carbs'),
          const SizedBox(height: 8),
          CustomRecipeCard(
            showFoodAlternateConfirmation: () {
              _showLanguageConfirmation(context);
            },
          ),
          const CustomLabelWidget(title: 'Protein'),
          const SizedBox(height: 8),
          CustomRecipeCard(
            showFoodAlternateConfirmation: () {
              _showLanguageConfirmation(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageConfirmation(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.55,
          ),
          child: Column(
            children: <Widget>[
              CustomHeaderWithCancel(
                title: 'Choose Food Alternate',
                onCancelPressed: () => Navigator.pop(context),
              ),
              FoodAlternateSelector(
                index: 0,
                isSelected: selectedFoodIndex == 0,
                title: 'Whole Wheat Bread',
                description: '1 slice',
                price: '0.5',
                price2: 'EGP',
                svgAsset: 'assets/svgs/Frame 52676.svg',
                onTap: () {
                  setState(() {
                    selectedFoodIndex = 0;
                  });
                },
              ),
              const SizedBox(height: 8),
              FoodAlternateSelector(
                index: 1,
                isSelected: selectedFoodIndex == 1,
                title: 'Whole Wheat Bread',
                description: '1 slice',
                price: '0.5',
                price2: 'EGP',
                svgAsset: 'assets/svgs/Frame 52676.svg',
                onTap: () {
                  setState(() {
                    selectedFoodIndex = 1;
                  });
                },
              ),
              const SizedBox(height: 8),
              CustomButton(text: 'Save Change', onPressed: () {}),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class CustomRecipeCard extends StatefulWidget {
  final VoidCallback showFoodAlternateConfirmation;

  const CustomRecipeCard(
      {Key? key, required this.showFoodAlternateConfirmation})
      : super(key: key);

  @override
  _CustomRecipeCardState createState() => _CustomRecipeCardState();
}

class _CustomRecipeCardState extends State<CustomRecipeCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
        },
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: isSelected
                  ? Image.asset('assets/images/checkbox.png')
                  : SvgPicture.asset('assets/svgs/Input.svg'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(
                    color: isSelected ? green300 : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomStackedImage(
                          image: 'assets/images/meat.jpeg',
                          text: '150 ',
                          unit: 'gm',
                        ),
                        const SizedBox(width: 16),
                        CustomDetalies(),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              widget.showFoodAlternateConfirmation();
                            },
                            child:
                                SvgPicture.asset('assets/svgs/refreach.svg')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

