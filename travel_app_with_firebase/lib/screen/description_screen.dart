import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:travel_guide_app/map/location_tracking_map.dart';
import 'package:readmore/readmore.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.description,
      required this.address,
      required this.latitude,
      required this.longitude});

  final String name;
  final String image;
  final String description;
  final String address;
  final double latitude;
  final double longitude;

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  late double lat = 0.0;
  late double lon = 0.0;
  bool isLoading = false;
  bool isFavourite = false;
  late SharedPreferences preferences;
  late List<String> bookmarkList;

  @override
  void initState() {
    super.initState();

    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    isFavourite = preferences.getBool(widget.name) ?? false;
    bookmarkList = preferences.getStringList("places") ?? [];
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _bookmarkPlace(String bookmarkPlace) async {
    isFavourite = await preferences.setBool(bookmarkPlace, true);
    bookmarkList.add(bookmarkPlace);
    await preferences.setStringList("places", bookmarkList);
    setState(() {});
  }

  Future<void> _removeBookmarkPlace(String name) async {
    bookmarkList.remove(name);
    await preferences.remove(name);
    await preferences.setStringList("places", bookmarkList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
        title: Text(widget.name),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (isFavourite) {
                  _removeBookmarkPlace(widget.name);
                } else {
                  _bookmarkPlace(widget.name);
                }
                isFavourite = !isFavourite;
              });
            },
            icon: Icon(
              Icons.favorite,
              color: isFavourite ? Colors.red : Colors.white,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Image.network(
                      widget.image,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        const SizedBox(
                            width:
                                8), // Add some space between the icon and text
                        Expanded(
                          child: Text(
                            widget.address,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 18),
                            maxLines: 2,
                          ),
                        ),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationTrackingPage(
                                          placeName: widget.name,
                                          latitude: widget.latitude,
                                          longitude: widget.longitude,
                                        )),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.map,
                                    color:
                                        Colors.black), // Add your desired icon
                                SizedBox(
                                    width:
                                        8.0), // Adjust the spacing between icon and text
                                Text(
                                  'Map',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ReadMoreText(
                      trimCollapsedText: 'Show More',
                      trimExpandedText: 'Show Less',
                      textAlign: TextAlign.justify,
                      moreStyle: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                      lessStyle: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                      widget.description,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
