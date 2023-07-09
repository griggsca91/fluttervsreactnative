import 'location.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:snapping_page_scroll/snapping_page_scroll.dart';

class ConstructionList extends StatelessWidget {
  ConstructionList({
    super.key,
    required this.constructionSites,
    required this.onItemFocus,
    required this.onItemClick,
  });

  final List<Location> constructionSites;
  final void Function(Location) onItemFocus;
  final void Function(Location) onItemClick;

  final controller = PageController(
    viewportFraction: 0.75,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    developer.log("width: $width");
    return SnappingPageScroll(
        onPageChanged: (i) => onItemFocus(constructionSites[i]),
        controller: controller,
        children: constructionSites
            .map((e) => ConstructionCard(
                  location: e,
                  onItemClick: onItemClick,
                ))
            .toList());
  }
}

class ConstructionCard extends StatelessWidget {
  final Location location;
  final void Function(Location) onItemClick;
  const ConstructionCard(
      {super.key, required this.location, required this.onItemClick});

  static const imagePlaceholder =
      "https://geekflare.com/wp-content/uploads/2023/03/img-placeholder.png";

  @override
  Widget build(BuildContext context) {
    var imageURL = location.displayImage ?? imagePlaceholder;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: GestureDetector(
            onTap: () => onItemClick(location),
            child: SizedBox(
              width: 350,
              height: 10,
              child: Card(
                color: const Color(0xffffffff),
                semanticContainer: false,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [Image.network(imageURL)],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(location.displayName),
                              Text(location.address),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            )));
  }
}
