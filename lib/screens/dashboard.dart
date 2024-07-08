import 'package:flutter/material.dart';
// import 'package:prova/aggiungiviaggio.dart';
import 'package:untitled/screens/add_&_modify_trip.dart';


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
            height: 250, // Altezza delle card+
            child: Align(
              alignment: Alignment.center,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1, // Numero di viaggi pianificati
                itemBuilder: (context, index) {
                  return Container(
                    width: 350, // Larghezza delle card
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
                            child: Center(
                              child: Text(
                                '${index + 1}° VIAGGIO',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TripEditScreen(trip: null), // Passa null se è un nuovo viaggio
                        ),
                      );
                    },
                    child: Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 247, 22, 22),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.mode_of_travel_sharp,   //oppure Icons.travel_explore,  
                          color: Colors.white,
                          size: 36.0,                   // Dimensione button
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0), // Spazio tra il bottone e il testo
                  const Text(
                    'NUOVO VIAGGIO',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

