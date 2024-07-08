// lib/models/trip.dart

class Trip {
  final String destination;
  final DateTime date;
  final bool isCompleted;
  final String? title;
    final String? itinerary;
  final String? notes;
  final String tripType;

  Trip({
    required this.destination,
    required this.date,
    this.isCompleted = false,
    this.title,
        this.itinerary,
    this.notes,
    required this.tripType,
  });
}


