import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../models/trip.dart';

class TripEditScreen extends StatefulWidget {
  const TripEditScreen({super.key, this.trip});

  final Trip? trip;

  @override
  _TripEditScreenState createState() => _TripEditScreenState();
}

class _TripEditScreenState extends State<TripEditScreen> { 
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _destinationController;
  late TextEditingController _itineraryController;
  late TextEditingController _notesController;
  DateTime? _date;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.trip?.title ?? '');
    _destinationController = TextEditingController(text: widget.trip?.destination ?? '');
    _itineraryController = TextEditingController(text: widget.trip?.itinerary ?? '');
    _notesController = TextEditingController(text: widget.trip?.notes ?? '');
    _date = widget.trip?.date;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _destinationController.dispose();
    _itineraryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
  );
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
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
      print('Data: ${_date != null ? DateFormat('dd MMM yyyy').format(_date!) : 'N/A'}');
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
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Titolo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Per favore, inserisci un titolo';
                  }
                  return null;
                },
                onSaved: (value) {
                  // Non serve fare nulla qui, il salvataggio è già gestito
                },
              ),
              TextFormField(
                controller: _destinationController,
                decoration: InputDecoration(labelText: 'Destinazione'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Per favore, inserisci una destinazione';
                  }
                  return null;
                },
                onSaved: (value) {
                  // Non serve fare nulla qui, il salvataggio è già gestito
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _date != null ? DateFormat('dd MMM yyyy').format(_date!) : 'Nessuna data selezionata',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: Text('Seleziona Data'),
                  ),
                ],
              ),
              TextFormField(
                controller: _itineraryController,
                decoration: InputDecoration(labelText: 'Itinerario'),
                maxLines: 3,
                onSaved: (value) {
                  // Non serve fare nulla qui, il salvataggio è già gestito
                },
              ),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'Note'),
                maxLines: 3,
                onSaved: (value) {
                  // Non serve fare nulla qui, il salvataggio è già gestito
                },
              ),
              SizedBox(height: 20),
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
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Seleziona Immagine'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
