import 'package:flutter/material.dart';

import 'package:travel_guide_app/places/models/places_models.dart';

import 'package:travel_guide_app/places/models/places_models.dart'
    as places_models;
import 'package:travel_guide_app/places/services/places_services.dart';
import 'package:travel_guide_app/screen/description_screen.dart';

class LocalPlace extends StatefulWidget {
  const LocalPlace({Key? key}) : super(key: key);

  @override
  State<LocalPlace> createState() => _LocalPlaceState();
}

class _LocalPlaceState extends State<LocalPlace> {
  final placesServices = PlacesServices();
  List<AllPlacesModels> localData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historic Place'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              // Filter the data to show only temples
              localData = snapshot.data!
                  .where((place) => place.title == places_models.Title.LOCAL)
                  .toList();

              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: localData.length,
                itemBuilder: (context, index) {
                  final localPlace = localData[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DescriptionScreen(
                                  name: localPlace.name,
                                  image: localPlace.image,
                                  description: localPlace.description,
                                  address: localPlace.address,
                                  latitude: double.parse(localPlace.latitude),
                                  longitude:
                                      double.parse(localPlace.longitude))));
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
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            child: Image.network(
                              localPlace.image,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  localPlace.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  localPlace.description,
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
                    ),
                  );
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
