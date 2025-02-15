import 'package:flutter/material.dart';
import 'package:real_estate_app/api/firebase_api.dart';
import 'package:real_estate_app/api/properties_response.dart';
import 'package:real_estate_app/custom/border_box.dart';
import 'package:real_estate_app/ui/property_detail_screen_ui.dart';
import 'package:real_estate_app/utils/constant.dart';
import '../api/firebase_property_response.dart';
import '../api/properties_api.dart';
import 'properties_list_screen_ui.dart';
import 'stream_property_list_ui.dart';

class LandingScreenUI extends StatelessWidget {
  const LandingScreenUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    const double padding = 25;
    const sidePadding = EdgeInsets.all(padding);
    // final PropertiesApi propertiesApi = PropertiesApi();
    final FirebaseApi firebaseApi = FirebaseApi();
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: COLOR_WHITE,
          child: Padding(
            padding: sidePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BorderBoxUI(
                      icons: Icons.menu,
                    ),
                    BorderBoxUI(
                      icons: Icons.settings,
                    ),
                  ],
                ),
                const SizedBox(
                  height: padding,
                ),
                Text(
                  'City',
                  style: themeData.textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'San Francisco',
                  style: themeData.textTheme.displayLarge,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Divider(
                    color: COLOR_GREY,
                  ),
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: [
                      "<\$220,000",
                      "For Sale",
                      "3-4 Beds",
                      ">1000 sqft",
                      "2 floor"
                    ].map(
                      (chipName) {
                        return _chipOption(themeData, chipName);
                      },
                    ).toList())),
                Expanded(
                    child: StreamBuilder(
                  stream: firebaseApi.getPropertyDocument(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List data = snapshot.data?.docs ?? [];
                      // futurePropertyData(propertiesApi, padding, themeData),
                      return StreamPropertiesListScreenUI(
                        streamPropertiesData: data,
                        padding: padding,
                        themeData: themeData,
                        onTap: (propertiesData) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                // const CacheImageUI()
                                PropertyScreenDetail(
                              propertiesData: propertiesData,
                            ),
                          ));
                        },
                      );
                    } else {
                      return Text('${snapshot.error}');
                    }
                  },
                )

                    // futurePropertyData(propertiesApi, padding, themeData),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<PropertyList> futurePropertyData(PropertiesApi propertiesApi,
      double padding, ThemeData themeData, PropertyData p) {
    return FutureBuilder(
      future: propertiesApi.loadProperties(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.properties.isEmpty) {
          return const Center(child: Text("No properties found"));
        } else {
          final propertiesData = snapshot.data!.properties;
          return PropertiesListScreenUI(
            propertiesData: propertiesData,
            padding: padding,
            themeData: themeData,
            onTap: (propertiesData) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PropertyScreenDetail(
                  propertiesData: propertiesData,
                ),
              ));
            },
          );
        }
      },
    );
  }

  Widget _chipOption(ThemeData themeData, String chipName) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          color: COLOR_GREY.withAlpha(40),
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        chipName,
        style: themeData.textTheme.headlineSmall,
      ),
    );
  }
}
