import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../screens/trip_detail_screen.dart';

class Statistiche extends StatelessWidget {
  const Statistiche({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dati esempio, da sostituire con i tuoi dati reali
    final int totaleViaggi = 10;
    final Map<String, int> destinazioni = {
      'New York': 3,
      'Roma': 2,
      'Parigi': 1,
      'Londra': 4,
    };

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistiche Viaggi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              color: const Color(0xFF4C8CFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Numero totale di viaggi effettuati',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      totaleViaggi.toString(),
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Destinazioni più visitate',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: destinazioni.length,
                itemBuilder: (context, index) {
                  String destinazione = destinazioni.keys.elementAt(index);
                  int count = destinazioni[destinazione]!;
                  return Card(
                    color: const Color(0xfff6a250),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        destinazione,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Visite: $count'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TripDetailScreen(destinazione: destinazione),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Andamento dei viaggi nel tempo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              flex: 2,
              child: LineChart(
                LineChartData(
                  minY: 60,
                  maxY: 80,
                  gridData: FlGridData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 65),
                        FlSpot(2, 70),
                        FlSpot(4, 75),
                        FlSpot(6, 78),
                        FlSpot(8, 80),
                        FlSpot(10, 77),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
