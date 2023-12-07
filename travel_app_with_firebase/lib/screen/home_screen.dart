import 'package:flutter/material.dart';
import 'package:travel_guide_app/components/custom/custom_search.dart';
import 'package:travel_guide_app/components/my_catagories.dart';
import 'package:travel_guide_app/components/my_drawer.dart';

import 'package:travel_guide_app/places/all_places.dart';
import 'package:travel_guide_app/places/models/places_models.dart';
import 'package:travel_guide_app/places/services/places_services.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<AllPlacesModels> allPlaces = [];
  List<AllPlacesModels> filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    fetchPlacesData();
  }

  Future<void> fetchPlacesData() async {
    try {
      final placesData = await PlacesServices().getPlacesData(context: context);
      setState(() {
        allPlaces = placesData;
        filteredPlaces = placesData;
      });
    } catch (e) {
      print('Error fetching places data: $e');
    }
  }

  void onPlaceFiltered(List<AllPlacesModels> filteredPlaces) {
    setState(() {
      this.filteredPlaces = filteredPlaces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Travel App',
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MySearchBar(
              placesList: allPlaces, // Pass a list of AllPlacesModels
              onPlaceFiltered: (List<AllPlacesModels> filteredPlaces) {
                setState(() {
                  this.filteredPlaces = filteredPlaces;
                });
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: MyCatagories(),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Builder(
              builder: (context) => AllPlaces(
                initialPlaces: filteredPlaces,
              ),
            ),
          )
        ],
      ),
    );
  }
}
