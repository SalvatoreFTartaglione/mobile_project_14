import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../models/trip.dart'; // Assicurati che il percorso del modello sia corretto

class TripEditScreen extends StatefulWidget {
  const TripEditScreen({super.key, this.trip});

  final Trip? trip;

  @override
  _TripEditScreenState createState() => _TripEditScreenState();
}

class _TripEditScreenState extends State<TripEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trip != null ? 'Modifica il tuo viaggio' : 'Aggiungi un nuovo viaggio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddModifyTripScreen(trip: widget.trip),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color(0xFF4C8CFF),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: 
              Text(
                  'Nuovo Viaggio',
                  style: TextStyle(
                    color: Color.fromARGB(255, 24, 23, 23), // colore del testo
                    fontSize: 15.0, // dimensione del font
                    fontWeight: FontWeight.bold, // spessore del font
                  ),
                )
            ),

            //MODIFICA VIAGGIO
            if (widget.trip != null) // Se c'è un trip, visualizza i dettagli del viaggio
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text('Modifica Viaggio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dettagli del viaggio:'),
                        SizedBox(height: 5),
                        Text('Titolo: ${widget.trip!.title}'),
                        Text('Destinazione: ${widget.trip!.destination}'),
                        Text('Data: ${DateFormat('dd MMM yyyy').format(widget.trip!.date)}'),
                        // Altri dettagli del viaggio
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// Widget per la schermata di aggiunta/modifica del viaggio
class AddModifyTripScreen extends StatefulWidget {
  final Trip? trip;

  const AddModifyTripScreen({Key? key, this.trip}) : super(key: key);

  @override
  _AddModifyTripScreenState createState() => _AddModifyTripScreenState();
}

class _AddModifyTripScreenState extends State<AddModifyTripScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _destinationController;
  late TextEditingController _itineraryController;
  late TextEditingController _notesController;
  DateTime? _datestart;
  DateTime? _dateend;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.trip?.title ?? '');
    _destinationController = TextEditingController(text: widget.trip?.destination ?? '');
    _itineraryController = TextEditingController(text: widget.trip?.itinerary ?? '');
    _notesController = TextEditingController(text: widget.trip?.notes ?? '');
    _datestart = widget.trip?.date;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _destinationController.dispose();
    _itineraryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickStartDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _datestart ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _datestart = picked;
      });
    }
  }

  Future<void> _pickEndDate() async {
    if (_datestart == null) {
      // Mostra un messaggio di errore se la data di inizio non è stata selezionata
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Per favore seleziona prima la data di inizio')),
      );
      return;
    }

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateend ?? _datestart!,
      firstDate: _datestart!,
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (picked.isAfter(_datestart!)) {
        setState(() {
          _dateend = picked;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('La data di fine deve essere successiva alla data di inizio')),
        );
      }
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Logica per salvare o aggiornare il viaggio
      String title = _titleController.text;
      String destination = _destinationController.text;
      String itinerary = _itineraryController.text;
      String notes = _notesController.text;
      print('Titolo: $title');
      print('Destinazione: $destination');
      print('Data inizio: ${_datestart != null ? DateFormat('dd MMM yyyy').format(_datestart!) : 'N/A'}');
      print('Data fine: ${_dateend != null ? DateFormat('dd MMM yyyy').format(_dateend!) : 'N/A'}');
      print('Itinerario: $itinerary');
      print('Note: $notes');
      print('Immagine: ${_imageFile != null ? _imageFile!.path : 'N/A'}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trip != null ? 'Modifica il tuo viaggio' : 'Aggiungi un nuovo viaggio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputDecorator(
                labelText: 'Titolo',
                controller: _titleController,
              ),
              SizedBox(height: 10),
              _buildInputDecorator(
                labelText: 'Destinazione',
                controller: _destinationController,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _datestart != null ? DateFormat('dd MMM yyyy').format(_datestart!) : 'Nessuna data di inizio selezionata',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickStartDate,
                    child: Text('Seleziona Data Inizio'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _dateend != null ? DateFormat('dd MMM yyyy').format(_dateend!) : 'Nessuna data di fine selezionata',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickEndDate,
                    child: Text('Seleziona Data Fine'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _buildInputDecorator(
                labelText: 'Itinerario',
                controller: _itineraryController,
                maxLines: 3,
              ),
              SizedBox(height: 10),
              _buildInputDecorator(
                labelText: 'Note',
                controller: _notesController,
                maxLines: 3,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  _imageFile != null
                      ? Image.file(
                          _imageFile!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[300],
                          child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
                        ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Seleziona Immagine'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Salva'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputDecorator({
    required String labelText,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration.collapsed(
          hintText: '',
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); // Converte XFile in File
      });
    }
  }
}


