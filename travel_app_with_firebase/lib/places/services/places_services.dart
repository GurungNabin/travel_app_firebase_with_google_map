import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_guide_app/places/models/places_models.dart';

class PlacesServices {
  Future<List<AllPlacesModels>> getPlacesData({
    required BuildContext context,
  }) async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/json/all_places.json');
      return allPlacesModelsFromJson(jsonString);
    } catch (e) {
      throw e.toString();
    }
  }
}
