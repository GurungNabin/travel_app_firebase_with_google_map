import 'package:flutter/material.dart';
import 'package:travel_guide_app/screen/catagories/adventure_scree.dart';
import 'package:travel_guide_app/screen/catagories/historic_screen.dart';
import 'package:travel_guide_app/screen/catagories/local_screen.dart';
import 'package:travel_guide_app/screen/catagories/monastery_screen.dart';
import 'package:travel_guide_app/screen/catagories/park_screen.dart';
import 'package:travel_guide_app/screen/catagories/temples_screen.dart';

class MyCatagories extends StatefulWidget {
  const MyCatagories({Key? key}) : super(key: key);

  @override
  State<MyCatagories> createState() => _MyCatagoriesState();
}

class _MyCatagoriesState extends State<MyCatagories> {
  int selectedindex = -1; // Start with no selection

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildIconButton(Icons.temple_hindu, 'Temple', 0),
          buildIconButton('assets/icons/sightseeing.png', 'Sightseeing', 1),
          buildIconButton(Icons.temple_buddhist, 'Monastery', 2),
          buildIconButton('assets/icons/hiking.png', 'Adventure', 3),
          buildIconButton('assets/icons/palace.png', 'Historical', 4),
          buildIconButton(Icons.location_history, 'Local', 5),
        ],
      ),
    );
  }

  IconButton buildIconButton(dynamic icon, String categoryName, int index) {
    Color iconColor = selectedindex == index ? Colors.black : Colors.grey;

    return IconButton(
      icon: Column(
        children: [
          icon is IconData
              ? Icon(icon, color: iconColor)
              : ImageIcon(
                  AssetImage(icon as String),
                  color: iconColor,
                ),
          const SizedBox(height: 4.0),
          Text(
            categoryName,
            style: TextStyle(fontSize: 12.0, color: iconColor),
          ),
        ],
      ),
      onPressed: () {
        navigateToCategory(index);
      },
    );
  }

  void navigateToCategory(int index) {
    setState(() {
      selectedindex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TemplePlace(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyPark(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MonasteryPlace(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdventurePlace(),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HistoricalPlace(),
          ),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LocalPlace(),
          ),
        );
        break;
    }
  }
}
