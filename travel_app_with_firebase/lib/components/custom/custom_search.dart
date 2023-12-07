import 'package:flutter/material.dart';
import 'package:travel_guide_app/places/models/places_models.dart';

class MySearchBar extends StatefulWidget {
  final List<AllPlacesModels> placesList;
  final Function(List<AllPlacesModels>) onPlaceFiltered;

  const MySearchBar({
    Key? key,
    required this.placesList,
    required this.onPlaceFiltered,
  }) : super(key: key);

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  TextEditingController _textController = TextEditingController();
  List<AllPlacesModels> filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      debounce(() {
        filterPlaces(_textController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.background,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: _textController,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search places...',
            suffixIcon: _textController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      clearSearch();
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }

  void filterPlaces(String query) {
    setState(() {
      if (query.isNotEmpty) {
        // Filter places that start with the typed query in the name
        filteredPlaces = widget.placesList.where((place) {
          final lowerCaseQuery = query.toLowerCase();
          final lowerCaseName = place.name.toLowerCase();
          return lowerCaseName.startsWith(lowerCaseQuery);
        }).toList();
      } else {
        filteredPlaces = List.from(widget.placesList);
      }
      print('Filtered Places: $filteredPlaces');
      widget.onPlaceFiltered(filteredPlaces);
      print('Callback triggered with filtered places');
    });
  }

  void clearSearch() {
    setState(() {
      _textController.clear();
      filteredPlaces = List.from(widget.placesList);
      widget.onPlaceFiltered(filteredPlaces);
    });
  }

  void debounce(VoidCallback callback, {int milliseconds = 300}) {
    Future.delayed(Duration(milliseconds: milliseconds), callback);
  }
}
