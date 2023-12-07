import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_guide_app/places/services/places_services.dart';

import '../places/models/places_models.dart';

class ViewFavouriteScreen extends StatefulWidget {
  const ViewFavouriteScreen({super.key});

  @override
  State<ViewFavouriteScreen> createState() => _ViewFavouriteScreenState();
}

class _ViewFavouriteScreenState extends State<ViewFavouriteScreen> {
  bool isLoading = false;
  late SharedPreferences preferences;
  late List<String> bookmarkList;
  List<AllPlacesModels> allPlacesModel = [];
  List<AllPlacesModels> bookmarkedPlaces = [];
  final PlacesServices placesServices = PlacesServices();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _removeBookmarkPlace(String name, int index) async {
    bookmarkList.remove(name);
    bookmarkedPlaces.removeAt(index);
    await preferences.remove(name);
    await preferences.setStringList("places", bookmarkList);
    setState(() {});
  }

  Future<void> _loadPreferences() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    bookmarkList = preferences.getStringList("places") ?? [];
    if (bookmarkList.isNotEmpty) {
      if (!context.mounted) return;
      allPlacesModel = await placesServices.getPlacesData(context: context);
      for (int i = 0; i < allPlacesModel.length; i++) {
        if (bookmarkList.contains(allPlacesModel[i].name)) {
          bookmarkedPlaces.add(allPlacesModel[i]);
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Favourites Screen"),
      ),
      body: ListView.builder(
          itemCount: bookmarkedPlaces.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(bookmarkedPlaces[index].name)),
                  Image.network(
                    bookmarkedPlaces[index].image,
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      _removeBookmarkPlace(bookmarkedPlaces[index].name, index);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
