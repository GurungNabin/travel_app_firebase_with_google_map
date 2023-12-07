import 'package:flutter/material.dart';
import 'package:travel_guide_app/places/models/places_models.dart';

import 'package:travel_guide_app/places/services/places_services.dart';
import 'package:travel_guide_app/screen/description_screen.dart';

class AllPlaces extends StatefulWidget {
  const AllPlaces({Key? key, required this.initialPlaces}) : super(key: key);

  final List<AllPlacesModels> initialPlaces;

  @override
  State<AllPlaces> createState() => _AllPlacesState();
}

class _AllPlacesState extends State<AllPlaces> {
  final placesServices = PlacesServices();
  List<AllPlacesModels> allPlacesData = [];

  @override
  void initState() {
    super.initState();
    // Initialize the allPlacesData with the initial places
    allPlacesData = widget.initialPlaces;
  }

  void updateFilteredPlaces(List<AllPlacesModels> filteredPlaces) {
    setState(() {
      allPlacesData = filteredPlaces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
        child: FutureBuilder(
          future: placesServices.getPlacesData(context: context),
          builder: (context, AsyncSnapshot<List<AllPlacesModels>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              allPlacesData = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.initialPlaces.length,
                itemBuilder: (context, index) {
                  final place = widget.initialPlaces[index];
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DescriptionScreen(
                                      name: place.name,
                                      image: place.image,
                                      description: place.description,
                                      address: place.address,
                                      latitude: double.parse(place.latitude),
                                      longitude: double.parse(place.longitude),
                                    )));
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15.0)),
                              child: Image.network(
                                place.image,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    place.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    place.description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              );
            } else {
              return const Center(
                child: Text('No data available'),
              );
            }
          },
        ),
      ),
    );
  }
}
