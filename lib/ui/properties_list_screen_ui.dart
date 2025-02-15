import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/properties_response.dart';
import '../custom/border_box.dart';

class PropertiesListScreenUI extends StatelessWidget {
  final List<Property> propertiesData;
  final double padding;
  final ThemeData themeData;
  final void Function(Property propertiesData) onTap;
  const PropertiesListScreenUI(
      {super.key,
      required this.propertiesData,
      required this.padding,
      required this.themeData,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: propertiesData.length,
      itemBuilder: (context, index) {
        final property = propertiesData[index];
        return GestureDetector(
          onTap: () {
            onTap.call(property);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(padding),
                      child: Image.asset(
                        property.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: BorderBoxUI(
                        icons: Icons.favorite_outline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      NumberFormat.currency(symbol: '\$', decimalDigits: 0)
                          .format(property.amount),
                      style: themeData.textTheme.displayLarge,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        property.address,
                        style: themeData.textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${property.bedrooms} bedrooms / ${property.bathrooms} bathrooms / ${property.area} sqft',
                  style: themeData.textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
