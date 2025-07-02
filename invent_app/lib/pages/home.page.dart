import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invent_app/bloc/post/bloc.dart';
import 'package:invent_app/pages/categories.page.dart';
import 'package:invent_app/pages/movement.page.dart';
import 'package:invent_app/pages/products.page.dart';
import 'package:invent_app/pages/reports.page.dart';
import 'package:invent_app/pages/supplier.page.dart';
import 'package:invent_app/pages/warehouse.page.dart';

class HomePag extends StatefulWidget {
  const HomePag({super.key});

  static String routeName = "analisis_page";

  @override
  State<HomePag> createState() => _HomePagState();
}

class _HomePagState extends State<HomePag> {
  final List<Map<String, dynamic>> menuItems = [
    {
      "index": 1,
      "icon": Icons.inventory,
      "title": "Productos",
      "color": Colors.blue
    },
    {
      "index": 2,
      "icon": Icons.warehouse,
      "title": "Almacenes",
      "color": Colors.green
    },
    {
      "index": 3,
      "icon": Icons.swap_vert,
      "title": "Movimientos",
      "color": Colors.orange
    },
    {
      "index": 4,
      "icon": Icons.category,
      "title": "Categorías",
      "color": Colors.purple
    },
    {
      "index": 5,
      "icon": Icons.local_shipping,
      "title": "Proveedores",
      "color": Colors.red
    },
    {
      "index": 6,
      "icon": Icons.analytics,
      "title": "Reportes",
      "color": Colors.teal
    },
  ];

  PostBloc? _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc =
        BlocProvider.of<PostBloc>(context); // Obtener instancia del BLoC
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel de Control", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.indigo.shade900],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey.shade50, Colors.grey.shade100],
          ),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return _buildMenuItemCard(menuItems[index]);
          },
        ),
      ),
    );
  }

  Widget _buildMenuItemCard(Map<String, dynamic> item) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          
          navigateScreen(item['index']);
        }, // Sin lógica
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                item["color"].withOpacity(0.8),
                item["color"].withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item["icon"], size: 40, color: Colors.white),
              SizedBox(height: 10),
              Text(
                item["title"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateScreen(index) {

    print(index);


    switch (index) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ProductPage(),
        ));
        break;
      case 2:
  Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const WareHousePage(),
        ));
        break;

      case 3:
       Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MovementsPage(),
        ));
        break;

      case 4:
       Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CategoriesPage(),
        ));
        break;

      case 5:
       Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SupplierPage(),
        ));
        break;

          case 6:
       Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ReportsPage(),
        ));
        break;

      default:
    }
  }
}
