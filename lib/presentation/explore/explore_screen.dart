import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onjeki/core/utils/image_constant.dart';
import 'package:onjeki/core/utils/size_utils.dart';
import 'package:onjeki/theme/theme_helper.dart';
import 'package:onjeki/widgets/custom_image_view.dart';

import '../../core/test_data.dart';
import '../../data/models/listing_model.dart';
import '../../domain/providers/location_provider.dart';
import '../../widgets/carousel_sliders.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Ensure location is initialized when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationProvider.notifier).initializeLocation();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationProvider);
    final currentLocation = locationState.currentLocation;
    final locationText = currentLocation == null
        ? 'Location loading...'
        : 'Lat: ${currentLocation.latitude}, Long: ${currentLocation.longitude}';
    final addressText = locationState.address ?? 'Address not available';

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 52,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leadingWidth: 0,
        title: Container(
          margin: const EdgeInsets.only(left: 24),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Explore',
                style: TextStyle(
                  fontSize: 20,
                  color: colorsBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                currentLocation == null ? 'Loading Location...' : addressText,
                style: const TextStyle(
                  fontSize: 14,
                  color: colorTextGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 24),
            child: CustomImageView(
              imagePath: ImageConstant.notificationIcon,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          children: [
            // Tab Bar with Green Background and Rounded Edges
            Container(
              // height: 65,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              decoration: BoxDecoration(
                color: const Color(0XFFF4F6F9),
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              child: TabBar(
                dividerHeight: 0,
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                  color: colorPrimary,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  // Tab(
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 12, horizontal: 24),
                  //     decoration: const BoxDecoration(
                  //         //  color: Colors.green,
                  //         // borderRadius: BorderRadius.circular(50),
                  //         ),
                  //     child: const Text('Layover'),
                  //   ),
                  // ),
                  Tab(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Layover",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: Center(
                        child: Text(
                          "For Rent",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: Center(
                        child: Text(
                          "For Sale",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            // Search and Filter Row
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 10),
                          child: CustomImageView(
                            imagePath: ImageConstant.searchIcon,
                            width: 24,
                            height: 24,
                          ),
                        ),
                        hintText: 'Where to stay?',
                        hintStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: colorGray, width: 0.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: colorGray, width: 0.5),
                        ),
                        focusedBorder: (OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        )).copyWith(
                          borderSide:
                              const BorderSide(color: colorPrimary, width: 0.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 45, vertical: 20),
                      ),
                      onChanged: (value) {
                        // Handle search filter here
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: CustomImageView(
                        imagePath: ImageConstant.filterIcon,
                        width: 26,
                        height: 17,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return FilterModal();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  PropertyListView(
                      tab: 'Layover', searchQuery: searchController.text),
                  PropertyListView(
                      tab: 'For Rent', searchQuery: searchController.text),
                  PropertyListView(
                      tab: 'For Sale', searchQuery: searchController.text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyListView extends ConsumerWidget {
  final String tab;
  final String searchQuery;

  PropertyListView({required this.tab, required this.searchQuery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Listing> listings =
        rawData.map((data) => Listing.fromMap(data)).toList();

    // Filter the listings based on the tab and search query
    // final filteredListings = listings.where((listing) {
    //   final matchesSearch = listing.city
    //           .toLowerCase()
    //           .contains(searchQuery.toLowerCase()) ||
    //       listing.district.toLowerCase().contains(searchQuery.toLowerCase());

    //   // Add additional filtering logic based on the tab (e.g., 'For Rent', 'For Sale')
    //   // if (tab == 'For Rent' && listing.filterTypeId == 2) {
    //   //   return matchesSearch;
    //   // } else if (tab == 'For Sale' && listing.filterTypeId == 3) {
    //   //   return matchesSearch;
    //   // } else if (tab == 'Layover' && listing.filterTypeId == 1) {
    //   //   return matchesSearch;
    //   // }
    //   return false;
    // }).toList();

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        shrinkWrap: true,
        itemCount: listings.length,
        itemBuilder: (context, index) {
          final listing = listings[index];
          return Container(
            padding:
                index == 0 ? const EdgeInsets.only(top: 14) : EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE (square)
                Stack(
                  children: [
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        color: colorLightGray,
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 336,
                          child: CarouselSlider(images: listing.advertPhotos),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.starIcon,
                                    width: 14,
                                    height: 14,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${listing.rating}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: colorsBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: CustomImageView(
                                imagePath: ImageConstant.wishlist,
                                width: 20,
                                height: 17,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(20),
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           color: colorWhite,
                    //           borderRadius: BorderRadius.circular(50)),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(10),
                    //         child: CustomImageView(
                    //           imagePath: ImageConstant.wishlist,
                    //           width: 20,
                    //           height: 17,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(20),
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           color: colorWhite,
                    //           borderRadius: BorderRadius.circular(50)),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(10),
                    //         child: Row(
                    //           children: [
                    //             CustomImageView(
                    //               imagePath: ImageConstant.starIcon,
                    //               width: 14,
                    //               height: 14,
                    //             ),
                    //             Text('${listing.rating}')
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),


                // DATE
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    right: 14,
                  ),
                  child: Text(
                    listing.apartmentName,
                    style: const TextStyle(
                      fontSize: 18,
                      color: colorPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                    right: 14,
                  ),
                  child: Text(
                    '${listing.district}, ${listing.country}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: colorTextGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // PRICE / NIGHT
                Padding(
                  padding: const EdgeInsets.only(top: 4,bottom: 24),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '£${listing.pricePerNight.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18, // Adjust size if needed
                              color: colorsBlack),
                        ),
                        const TextSpan(
                          text: '/ per night',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18, // Adjust size if needed
                            color:
                                Colors.grey, // Adjust color to make it lighter
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

final propertyListProvider =
    FutureProvider.family<List<String>, String>((ref, tab) async {
  await Future.delayed(const Duration(seconds: 2));

  if (tab == 'For Rent') {
    return ['House 1 for Rent', 'House 2 for Rent'];
  } else if (tab == 'For Sale') {
    return ['House 1 for Sale', 'House 2 for Sale'];
  } else {
    return ['Layover Property 1', 'Layover Property 2'];
  }
});

class FilterModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Filter by:', style: TextStyle(fontSize: 18)),
          ListTile(
            title: const Text('Price'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Location'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Type'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
