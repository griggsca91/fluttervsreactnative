import 'location.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class ConstructionList extends StatelessWidget {
  const ConstructionList({
    super.key,
    required this.constructionSites,
    required this.onItemFocus,
    required this.onItemClick,
  });

  final List<Location> constructionSites;
  final void Function(Location) onItemFocus;
  final void Function(Location) onItemClick;

  void _onItemFocus(int index) {
    onItemFocus(constructionSites[index]);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
      onItemFocus: _onItemFocus,
      itemSize: 350 + 5 + 5,
      itemBuilder: (BuildContext context, int index) {
        return ConstructionCard(
          location: constructionSites[index],
          onItemClick: onItemClick,
        );
      },
      itemCount: constructionSites.length,
      reverse: true,
    );
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
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(imageURL),
                              ],
                            ))),
                    Expanded(
                        flex: 2,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(location.displayName),
                                Text(location.address),
                              ],
                            ))),
                  ],
                ),
              ),
            )));
  }
}
