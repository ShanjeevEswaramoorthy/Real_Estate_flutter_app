import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../custom/border_box.dart';

class StreamPropertiesListScreenUI extends StatelessWidget {
  final List streamPropertiesData;
  final double padding;
  final ThemeData themeData;
  final void Function(dynamic propertiesData) onTap;
  const StreamPropertiesListScreenUI(
      {super.key,
      required this.streamPropertiesData,
      required this.padding,
      required this.themeData,
      required this.onTap});

  /// This will used the delete the all cache image which stored in the app
  /// [DefaultCacheManager().emptyCache();]
  ///
  /// This will remove the particular image from the cache
  /// [DefaultCacheManager().removeFile(imageUrl);]
  ///
  /// Clears all temporary files stored in the app, including cached images.
  /// getTemporaryDirectory() + .deleteSync(recursive: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: streamPropertiesData.length,
      itemBuilder: (context, index) {
        final streamProperty = streamPropertiesData[index].data();

        return GestureDetector(
          onTap: () {
            onTap.call(streamProperty);
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
                      child:
                          /*CachedNetworkImage(
                          imageUrl: streamProperty.image,
                          // placeholder: (context, url) =>
                          //     const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                          errorListener: (e) {
                            if (e is SocketException) {
                              debugPrint(
                                  'Error with ${e.address} and message ${e.message}');
                            } else {
                              debugPrint(
                                  'Image Exception is: ${e.runtimeType}');
                            }
                          },
                        )*/
                          Image.network(
                        streamProperty.image,
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
                          .format(streamProperty.price),
                      style: themeData.textTheme.displayLarge,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        streamProperty.address,
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
                  '${streamProperty.bedRooms} bedrooms / ${streamProperty.bathRooms} bathrooms  / ${streamProperty.area} sqft',
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
