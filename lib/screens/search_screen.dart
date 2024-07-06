import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/models/trip.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  String _selectedDestination = '';
  DateTime? _selectedDate;
  String _selectedTripType = '';

  final List<Trip> trips = [
    Trip(destination: "Roma", date: DateTime(2024, 7, 20), tripType: "Culturale"),
    Trip(destination: "Parigi", date: DateTime(2024, 5, 18), tripType: "Relax"),
    Trip(destination: "New York", date: DateTime(2023, 12, 25), tripType: "Avventura"),
  ];

  List<Trip> filteredTrips = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_filterTrips);
    filteredTrips = trips;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTrips() {
    List<Trip> results = trips.where((trip) {
      final matchKeyword = _searchController.text.isEmpty ||
          trip.destination.toLowerCase().contains(_searchController.text.toLowerCase());
      final matchDestination = _selectedDestination.isEmpty ||
          trip.destination == _selectedDestination;
      final matchDate = _selectedDate == null ||
          trip.date.isAtSameMomentAs(_selectedDate!) ||
          trip.date.isAfter(_selectedDate!);
      final matchTripType = _selectedTripType.isEmpty ||
          trip.tripType == _selectedTripType;

      return matchKeyword && matchDestination && matchDate && matchTripType;
    }).toList();

    setState(() {
      filteredTrips = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ricerca Viaggi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cerca viaggio per parola chiave',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDestination.isEmpty ? null : _selectedDestination,
              hint: Text('Filtra per destinazione'),
              onChanged: (value) {
                setState(() {
                  _selectedDestination = value ?? '';
                  _filterTrips();
                });
              },
              items: ['Roma', 'Parigi', 'New York']
                  .map<DropdownMenuItem<String>>((String destination) {
                return DropdownMenuItem<String>(
                  value: destination,
                  child: Text(destination),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                    _filterTrips();
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Filtra per data',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: _selectedDate == null
                  ? null
                  : TextEditingController(
                text: DateFormat('dd MMM yyyy').format(_selectedDate!),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedTripType.isEmpty ? null : _selectedTripType,
              hint: Text('Filtra per tipo di viaggio'),
              onChanged: (value) {
                setState(() {
                  _selectedTripType = value ?? '';
                  _filterTrips();
                });
              },
              items: ['Avventura', 'Relax', 'Culturale']
                  .map<DropdownMenuItem<String>>((String tripType) {
                return DropdownMenuItem<String>(
                  value: tripType,
                  child: Text(tripType),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTrips.length,
                itemBuilder: (context, index) {
                  Trip trip = filteredTrips[index];
                  return ListTile(
                    title: Text(trip.destination),
                    subtitle: Text('${DateFormat('dd MMM yyyy').format(trip.date)} - ${trip.tripType}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
