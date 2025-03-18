import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons/lucide_icons.dart'; // Usa íconos modernos

class AppbarStyle extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPowerPressed; // Agregar función para el botón
  final PreferredSizeWidget? bottom;

  const AppbarStyle({
    super.key,
    required this.title,
    this.onPowerPressed,
    this.bottom, // Agregar parámetro para la barra de pestañas
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'LightStep',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 26,
          // fontWeight: FontWeight.bold,
        ),
      ),
      toolbarHeight: 80, // Ajusta la altura del AppBar
      leading: Padding(
        padding: const EdgeInsets.all(1),
        child: SvgPicture.asset(
          'assets/img/logo.svg',
          width: 150, // Tamaño deseado
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Borde externo circular
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(0, 255, 153, 0),
                  Color.fromARGB(0, 255, 153, 0),
                  Color.fromARGB(255, 246, 88, 211),
                  Color.fromARGB(0, 255, 153, 0),
                  Color.fromARGB(0, 255, 153, 0),
                  Color.fromARGB(0, 255, 153, 0),
                  Color.fromARGB(0, 255, 153, 0),
                  Color.fromARGB(0, 255, 153, 0),
                  Color.fromARGB(0, 255, 153, 0),
                  Color.fromARGB(250, 117, 48, 238),
                  Color.fromARGB(0, 255, 153, 0),
                  Color.fromARGB(0, 255, 153, 0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(4), // Espacio para el borde externo
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Borde interno circular
                color: const Color.fromARGB(
                    255, 44, 1, 51), // Color de fondo interno
              ),
              padding: const EdgeInsets.all(5), // Espacio para el borde externo
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Borde interno circular
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 246, 88, 211),
                      Color.fromARGB(251, 142, 86, 240),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding:
                    const EdgeInsets.all(3), // Espacio para el borde interno
                child: Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    //   color: Color.fromARGB(
                    //       150, 39, 38, 39), // Color de fondo interno
                    // ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 246, 88, 211),
                        Color.fromARGB(251, 142, 86, 240),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding:
                      const EdgeInsets.all(0), // Espacio para el borde interno
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(
                          255, 55, 2, 63), // Color de fondo interno
                    ),
                    child: IconButton(
                      icon: const Icon(LucideIcons.power, color: Colors.white),
                      onPressed: onPowerPressed ?? () {},
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      bottom: bottom, // Se asigna el TabBar aquí
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

// class TabBarStyle extends StatelessWidget implements PreferredSizeWidget {
//   final List<Tab> tabs;
//   final TabController? controller;

//   const TabBarStyle({super.key, required this.tabs, this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return TabBar(
//       tabs: tabs,
//       controller: controller ?? DefaultTabController.of(context),
//       labelColor: Colors.white,
//       unselectedLabelColor: Colors.white70,
//       indicatorSize: TabBarIndicatorSize.label,
//       indicatorColor: Colors.white,
//       indicatorWeight: 3,
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(50);
// }