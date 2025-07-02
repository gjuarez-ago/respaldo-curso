import 'package:flutter/material.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({super.key});

  static String routeName = "supplier_page";

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  final suppliers = List.generate(8, (index) {
    return {
      "name": "Proveedor ${index + 1}",
      "contact": "contacto${index + 1}@empresa.com",
      "products": "${index * 5 + 10} productos",
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proveedores", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Expanded(
                  child: Chip(
                    label: Text("Todos"),
                    backgroundColor: Colors.red.shade100,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Chip(
                    label: Text("Activos"),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Chip(
                    label: Text("Inactivos"),
                  ),
                ),
              ],
            ),
          ),
          // Lista
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: suppliers.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red.shade100,
                      child: Icon(Icons.local_shipping, color: Colors.red),
                    ),
                    title: Text(
                      suppliers[index]["name"] as String,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(suppliers[index]["contact"] as String),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          suppliers[index]["products"] as String,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade600,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}