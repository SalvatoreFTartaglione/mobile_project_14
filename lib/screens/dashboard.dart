import 'package:flutter/material.dart';
// import 'package:prova/aggiungiviaggio.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prossimo viaggio in programma',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 250, // Altezza delle card
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1, // Numero di viaggi pianificati
              itemBuilder: (context, index) {
                return Container(
                  width: 340, // Larghezza delle card
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    color: const Color(0xFF4C8CFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.asset(
                            'assets/images/newYork.jpg',
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Viaggio ${index + 1}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Text(
                            'Dettagli del viaggio ${index + 1}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Ultime destinazioni visitate',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: 2, // Numero di ultime destinazioni
              itemBuilder: (context, index) {
                return Card(
                  color: const Color(0xfff6a250),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Text(
                      'Destinazione ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Dettagli della destinazione ${index + 1}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            /* mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TripEditScreen(trip: null), // Passa null se è un nuovo viaggio
                    ),
                  );
                },
                child: const Text('Aggiungi Viaggio'),
              ),
            ], */
          ),
        ],
      ),
    );
  }
}

