import 'package:flutter/material.dart';
import 'package:ligth_step_app/screens/consumo.dart';
import 'package:ligth_step_app/screens/inicio.dart';
import 'package:ligth_step_app/screens/perfil.dart';
import 'package:ligth_step_app/screens/personalizacion.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _selectedIndex = 0; // Mantiene el índice de la pestaña seleccionada

  final List<Widget> _screens = [
    Inicio(),
    const Personalizacion(),
    const ConsumoScreen(),
    const Perfil(),
  ];

  // Cambiar el índice cuando se presiona el Tab
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // El widget cambia según el índice
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(137, 59, 59, 59),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: SizedBox(
            height: 90,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onTabSelected, // Cambiar el índice cuando se presiona el Tab
              backgroundColor: Colors.black,
              selectedItemColor: Colors.purpleAccent,
              unselectedItemColor: Color.fromARGB(255, 159, 156, 156),
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 30),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.palette, size: 30),
                  label: 'Personalizar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart, size: 30),
                  label: 'Consumo',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 30),
                  label: 'Perfil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}