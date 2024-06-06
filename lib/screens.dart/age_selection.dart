import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgeSelection extends StatefulWidget {
  const AgeSelection({super.key});

  @override
  State<AgeSelection> createState() => _AgeSelectionState();
}

class _AgeSelectionState extends State<AgeSelection> {
  String? _selectedAgeGroup;

  void _saveAgeGroup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('age_group', _selectedAgeGroup!);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text(
              'Select Your Age Group',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioListTile(
              title: const Text('Below 30'),
              value: 'below 30',
              groupValue: _selectedAgeGroup,
              onChanged: (value) {
                setState(() {
                  _selectedAgeGroup = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Below 40'),
              value: 'below 40',
              groupValue: _selectedAgeGroup,
              onChanged: (value) {
                setState(() {
                  _selectedAgeGroup = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Below 50'),
              value: 'below 50',
              groupValue: _selectedAgeGroup,
              onChanged: (value) {
                setState(() {
                  _selectedAgeGroup = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Below 60'),
              value: 'below 60',
              groupValue: _selectedAgeGroup,
              onChanged: (value) {
                setState(() {
                  _selectedAgeGroup = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: _selectedAgeGroup == null ? null : _saveAgeGroup,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.teal, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
