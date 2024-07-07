import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../../database/viaggio.dart';
import 'package:intl/intl.dart';

class TripDetailScreen extends StatefulWidget {
  final String? destinazione;

  const TripDetailScreen({Key? key, this.destinazione}) : super(key: key);

  @override
  _TripDetailScreenState createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  List<viaggio> _viaggi = [];

  @override
  void initState() {
    super.initState();
    if (widget.destinazione != null) {
      _loadViaggi();
    }
  }

  Future<void> _loadViaggi() async {
    try {
      final db = DatabaseHelper.instance;
      final viaggiList = await db.getViaggiByDestinazione(widget.destinazione!);
      setState(() {
        _viaggi = viaggiList;
      });
    } catch (e) {
      print('Error loading viaggi: $e');
    }
  }

  Future<void> _refreshViaggi() async {
    await _loadViaggi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Viaggi - ${widget.destinazione ?? 'Tutte le destinazioni'}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _viaggi.isEmpty
            ? const Center(child: Text('Nessun viaggio trovato'))
            : ListView.builder(
          itemCount: _viaggi.length,
          itemBuilder: (context, index) {
            final viaggio = _viaggi[index];
            return Card(
              child: ListTile(
                title: Text(viaggio.titolo),
                subtitle: Text(
                    'Dal ${DateFormat('dd/MM/yyyy').format(viaggio.data_inizio)} al ${DateFormat('dd/MM/yyyy').format(viaggio.data_fine)}\n${viaggio.destinazione}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await DatabaseHelper.instance.deleteViaggio(viaggio.id_viaggio);
                    _refreshViaggi();
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
