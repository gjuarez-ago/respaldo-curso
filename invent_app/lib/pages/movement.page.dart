import 'package:flutter/material.dart';

class MovementsPage extends StatefulWidget {
  const MovementsPage({super.key});

  static String routeName = "movement_page";

  @override
  State<MovementsPage> createState() => _MovementsPageState();
}

class _MovementsPageState extends State<MovementsPage> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movimientos", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: "ENTRADAS", icon: Icon(Icons.input)),
            Tab(text: "SALIDAS", icon: Icon(Icons.output)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMovementList("ENTRADA"),
          _buildMovementList("SALIDA"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade600,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => _showMovementForm(context),
      ),
    );
  }

  Widget _buildMovementList(String type) {
    final movements = List.generate(5, (index) {
      return {
        "id": index + 1,
        "product": "Producto ${index + 1}",
        "warehouse": "Almacén ${index % 2 + 1}",
        "quantity": (index + 1) * 5,
        "date": "2023-11-${10 + index}",
        "user": "Usuario ${index + 1}",
      };
    });

    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: movements.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: type == "ENTRADA" ? Colors.green.shade100 : Colors.red.shade100,
              width: 2,
            ),
          ),
          child: ListTile(
            leading: Icon(
              type == "ENTRADA" ? Icons.input : Icons.output,
              color: type == "ENTRADA" ? Colors.green : Colors.red,
            ),
            title: Text(movements[index]["product"] as String),
            subtitle: Text(
              "${movements[index]["quantity"]} uds. | ${movements[index]["warehouse"]}",
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(movements[index]["date"] as String, style: TextStyle(fontSize: 12)),
                Text(movements[index]["user"] as String, style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMovementForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Nuevo Movimiento",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Producto",
                    border: OutlineInputBorder(),
                  ),
                  items: ["Producto 1", "Producto 2", "Producto 3"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 12),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Almacén",
                    border: OutlineInputBorder(),
                  ),
                  items: ["Almacén 1", "Almacén 2"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Cantidad",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Movimiento registrado"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: Text("REGISTRAR"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  
}