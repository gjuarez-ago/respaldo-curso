import 'package:flutter/material.dart';

class WareHousePage extends StatefulWidget {
  const WareHousePage({super.key});

  static String routeName = "warehouse_page";

  @override
  State<WareHousePage> createState() => _WareHousePageState();
}

class _WareHousePageState extends State<WareHousePage> {
  final warehouses = [
    {"name": "Almacén Principal", "location": "Piso 1", "items": 45},
    {"name": "Almacén Secundario", "location": "Piso 2", "items": 28},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Almacenes", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green.shade700,
      ),
      body: Column(
        children: [
          // Mapa visual (simulado)
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://via.placeholder.com/800x400?text=Mapa+Almacenes"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Ubicación de Almacenes",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          // Lista de almacenes
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: warehouses.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.warehouse, color: Colors.green.shade700),
                              SizedBox(width: 10),
                              Text(
                                warehouses[index]["name"] as String,
                                style: TextStyle( 
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Ubicación: ${warehouses[index]["location"]}",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: (warehouses[index]["items"] as int).toDouble() / 50,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green.shade400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${warehouses[index]["items"]} productos",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade600,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}