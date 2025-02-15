import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImageUI extends StatelessWidget {
  const CacheImageUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context, index) => SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  fit: BoxFit.cover,
                  imageUrl:
                      'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg')
              //     Image.network(
              //   'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
              //   fit: BoxFit.cover,
              // ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
          itemCount: 20),
    );
  }
}
