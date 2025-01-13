import 'package:flutter/material.dart';
import 'package:onjeki/core/utils/image_constant.dart';
import 'package:onjeki/theme/theme_helper.dart';
import 'package:onjeki/widgets/custom_image_view.dart';

import '../data/models/listing_model.dart';
import 'carousel_sliders.dart';

class AdvertCardWidget extends StatelessWidget {
   final List<Listing> listings;

  const AdvertCardWidget({
    Key? key,
     required this.listings
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var images = listings.advertPhotos;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE (square)
          Stack(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: colorLightGray,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CarouselSlider(images: ['images']),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: CustomImageView(
                    imagePath: ImageConstant.wishlist,
                  ),
                ),
              )
            ],
          ),

          // LOCATION and Star Rating
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('lorem , lagos'),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 15,
                    ),
                    Text('5'),
                  ],
                )
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(14),
            child: Text('Hosted By'),
          ),

          // DATE
          Text('2022 - 2024'),

          // PRICE / NIGHT
          Padding(
            padding: EdgeInsets.only(top: 14),
            child: Text('200'),
          ),
        ],
      ),
    );
  }
}
