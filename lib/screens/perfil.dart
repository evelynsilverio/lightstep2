import 'package:flutter/material.dart';
import 'package:ligth_step_app/widgets/appbar.dart';
// import 'package:ligthstep/widgets/appbar.dart';
// import 'package:ligthstep/widgets/tabbar.dart'; // Esto ya no se necesita si lo simplificamos
import '../widgets/scaffold_con_degradado.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Perfil(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  int _selectedIndex = 0;

  // Define your screens here, just like you had it in TabBarScreen
  final List<Widget> _screens = [
    const Center(child: Text('Inicio', style: TextStyle(fontSize: 24))),
    const Center(
        child: Text('Personalización', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Consumo', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Perfil', style: TextStyle(fontSize: 24))),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldConDegradado(
      appBar: const AppbarStyle(title: "Perfil"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color.fromARGB(142, 121, 119, 119),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              "Kevin Arroyo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: _buildSectionTitle("Tus configuraciones favoritas"),
            ),
            _buildConfigBox(),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: _buildSectionTitle("Centro de ayuda"),
            ),
            _buildHelpBox(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        color: Colors.transparent,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onTabSelected,
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
              label: 'Personalización',
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
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pinkAccent, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 90, 8, 88),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildConfigBox() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Colores",
              style: TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildColorBox(const Color.fromARGB(255, 35, 8, 144)),
              _buildColorBox(const Color.fromARGB(255, 245, 4, 193)),
              _buildColorBox(const Color.fromARGB(255, 196, 200, 7)),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Efectos",
              style: TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.purpleAccent,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.waves, color: Colors.white),
                SizedBox(width: 8),
                Text("Arco iris", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorBox(Color color) {
    return Container(
      width: 35,
      height: 35,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget _buildHelpBox() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(132, 255, 255, 255).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Escríbenos o haznos una pregunta...",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 10),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              filled: true,
              fillColor:
                  const Color.fromARGB(131, 255, 255, 255).withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.purpleAccent,
              ),
              child:
                  const Text("Enviar", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}