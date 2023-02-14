import 'package:flutter/material.dart';
import 'MyToast.dart';

//----------------- STATE -----------------
class StateDropdown extends StatefulWidget {
  @override
  _StateDropdownState createState() => new _StateDropdownState();
}

class _StateDropdownState extends State<StateDropdown> {
  String dropdownStateValue = 'Bundesland wählen...';
  bool dropdownStateValidInput = false;
  List<String> itemsState = [
    'Bundesland wählen...',
    'Baden-Würtemmberg',
    'Bayern',
    'Berlin',
    'Brandenburg',
    'Bremen',
    'Hamburg',
    'Hessen',
    'Mecklenburg-Vorpommern',
    'Niedersachsen',
    'Nordrhein-Westfalen',
    'Rheinland-Pfalz',
    'Saarland',
    'Sachsen',
    'Sachsen-Anhalt',
    'Schleswig-Holstein',
    'Thüringen'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        isExpanded: true,
        value: dropdownStateValue,
        icon: const Icon(Icons.keyboard_arrow_down_sharp),
        iconSize: 20,
        elevation: 16,
        style: const TextStyle(color: Colors.black87),
        underline: Container(
          height: 2,
          color: Colors.grey[350],
        ),
        onChanged: (String? input) {
          //invalid selection
          if (input == 'Bundesland wählen...') {
            dropdownStateValidInput = false;
            MyToast().showToastInvalidStateSelection();
          }

          //valid selection
          else {
            setState(() {
              dropdownStateValue = input!;
            });
            dropdownStateValidInput = true;
          }
        },
        items: itemsState
            .map<DropdownMenuItem<String>>((String dropdownStateValue) {
          return DropdownMenuItem<String>(
            value: dropdownStateValue,
            child: Text(dropdownStateValue),
          );
        }).toList());
  }
}

//----------------- PET -----------------
class PetDropdown extends StatefulWidget {
  @override
  _PetDropdownState createState() => new _PetDropdownState();
}

class _PetDropdownState extends State<PetDropdown> {
  String dropdownPetValue = 'Haustier wählen...';
  bool dropdownPetValidInput = false;

  List<String> itemsPet = [
    'Haustier wählen...',
    'Hund',
    'Katze',
    'Maus',
    'Ratte',
    'Schlange',
    'Schwein',
    'Vogel',
    'Meerschwein',
    'Chinchilla',
    'Kaninchen',
    'Schildkröte',
    'Hamster'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        isExpanded: true,
        value: dropdownPetValue,
        icon: const Icon(Icons.keyboard_arrow_down_sharp),
        iconSize: 20,
        elevation: 16,
        style: const TextStyle(color: Colors.black87),
        underline: Container(
          height: 2,
          color: Colors.grey[350],
        ),
        onChanged: (String? input) {
          //invalid selection
          if (input == 'Haustier wählen...') {
            dropdownPetValidInput = false;
            MyToast().showToastInvalidPetSelection();
          }
          //valid selection
          else {
            setState(() {
              dropdownPetValue = input!;
            });
            dropdownPetValidInput = true;
          }
        },
        items:
            itemsPet.map<DropdownMenuItem<String>>((String dropdownPetValue) {
          return DropdownMenuItem<String>(
            value: dropdownPetValue,
            child: Text(dropdownPetValue),
          );
        }).toList());
  }
}

/// Aus MyToast.dart der Toast :
///   //PetDropdown invalid Selection
void showToastInvalidPetSelection() {
  Fluttertoast.showToast(
      msg: "Bitte wählen Sie die Art Ihres Haustiers!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
      webPosition: 'center');
}
