import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_estate_app/ui/map_screen_ui.dart';
import 'package:real_estate_app/utils/constant.dart';

import '../custom/border_box.dart';
import '../custom/leading_icon_with_text.dart';

class PropertyScreenDetail extends StatelessWidget {
  final dynamic propertiesData;

  const PropertyScreenDetail({super.key, required this.propertiesData});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        propertiesData.image),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            NumberFormat.currency(
                                    symbol: '\$', decimalDigits: 0)
                                .format(propertiesData.price),
                            style: themeData.textTheme.displayLarge,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            propertiesData.address,
                            style: themeData.textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('House Information',
                              style: themeData.textTheme.headlineMedium),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 120,
                            child: _propertyChip(
                              '${propertiesData.area},${propertiesData.bedRooms},${propertiesData.bathRooms},${propertiesData.garage}',
                              context,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            propertiesData.description,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 25,
                left: 20,
                child: BorderBoxUI(
                  onTap: () => Navigator.of(context).pop(),
                  icons: Icons.arrow_back,
                ),
              ),
              const Positioned(
                top: 25,
                right: 20,
                child: BorderBoxUI(
                  icons: Icons.favorite_outline,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          child: LeadingIconWithText(
            title: 'Map View',
            icon: Icons.map,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MapScreenUI(
                  idAsName: propertiesData.address,
                  lat: propertiesData.location.latitude,
                  long: propertiesData.location.longitude,
                  image: propertiesData.image,
                ),
              ));
            },
          ),
        ),
      ],
    );
  }

  Widget _propertyChip(String title, BuildContext context) {
    final titles = title.split(',').toList();
    final chipDetails = ['Square Foot', 'Bedrooms', 'Bathrooms', 'Garage'];
    final themeData = Theme.of(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 90,
              margin: const EdgeInsets.only(
                right: 20,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: COLOR_GREY.withAlpha(40), width: 2),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  titles[index],
                  style: themeData.textTheme.displayMedium,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              chipDetails[index],
              style: themeData.textTheme.headlineSmall,
            ),
          ],
        );
      },
    );
  }
}
