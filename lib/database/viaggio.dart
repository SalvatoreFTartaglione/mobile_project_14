import 'package:intl/intl.dart';

class viaggio {
  //final int id_viaggio;
  final String titolo;
  final DateTime data_inizio;
  final DateTime data_fine;
  final String note;
  final String itinerario;
  final String destinazione;
  final String categoria;

  viaggio({
    //required this.id_viaggio,
    required this.titolo,
    required this.data_inizio,
    required this.data_fine,
    required this.note,
    required this.itinerario,
    required this.destinazione,
    required this.categoria,
  });

  factory viaggio.fromMap(Map<String, dynamic> map) {
    return viaggio(
      //id_viaggio: map['id_viaggio'],
      titolo: map['titolo'],
      itinerario: map['itinerario'],
      data_inizio: DateTime.parse(map['data_inizio']),
      data_fine: DateTime.parse(map['data_fine']),
      note: map['note'],
      destinazione: map['destinazione'],
      categoria: map['categoria'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'id_viaggio': id_viaggio,
      'titolo': titolo,
      'itinerario': itinerario,
      'data_inizio': DateFormat('yyyy-MM-dd').format(data_inizio),
      'data_fine': DateFormat('yyyy-MM-dd').format(data_fine),
      'note': note,
      'destinazione': destinazione,
      'categoria': categoria,
    };
  }

  @override
  String toString() {
    //return 'Viaggio{id_viaggio: $id_viaggio, titolo: $titolo, data_inizio: $data_inizio, data_fine: $data_fine, note: $note, itinerario: $itinerario, destinazione: $destinazione}';
    return 'Viaggio{titolo: $titolo, data_inizio: $data_inizio, data_fine: $data_fine, note: $note, itinerario: $itinerario, destinazione: $destinazione, categoria: $categoria}';
  }
}
