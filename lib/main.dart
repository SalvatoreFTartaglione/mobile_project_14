import 'package:flutter/material.dart';
import 'package:untitled/screens/add_&_modify_trip.dart';
import '../../screens/dashboard.dart';
import '../../screens/trip_detail_screen.dart';
import '../../screens/destination_screen.dart';
import '../../screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Colors.orange,
        title: Row(
          children: [
            const SizedBox(width: 10),
            const Text(
              'TravelWorld',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          Dashboard(),
          TripDetailScreen(),
          TripEditScreen(),
          DestinationScreen(),
          SearchScreen(),
        ],

      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.airplanemode_active), label: 'Dettaglio viaggio'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Aggiungi/Modifica viaggio'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Destinazioni'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Ricerca'),
          BottomNavigationBarItem(icon: Icon(Icons.query_stats), label: 'Statistiche'),

        ],
      ),
    );
  }
}


