import 'package:flutter/material.dart';

class WareHousePage extends StatefulWidget {
  const WareHousePage({super.key});

  static String routeName = "warehouse_page";

  @override
  State<WareHousePage> createState() => _WareHousePageState();
}

class _WareHousePageState extends State<WareHousePage> {
 final List<Map<String, dynamic>> _warehouses = [
    {
      'id': 1,
      'name': 'Almacén Principal',
      'location': 'Piso 1, Edificio A',
      'capacity': 1000,
      'currentStock': 750,
      'lastUpdated': '2023-06-15'
    },
    {
      'id': 2,
      'name': 'Almacén Secundario',
      'location': 'Piso 2, Edificio B',
      'capacity': 500,
      'currentStock': 320,
      'lastUpdated': '2023-06-10'
    },
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _capacityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Almacenes', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade800,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _warehouses.length,
        itemBuilder: (context, index) {
          return _buildWarehouseCard(_warehouses[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade600,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => _showWarehouseForm(),
      ),
    );
  }

  Widget _buildWarehouseCard(Map<String, dynamic> warehouse) {
    final percentage = (warehouse['currentStock'] / warehouse['capacity']) * 100;
    final statusColor = _getStatusColor(percentage);

    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showWarehouseDetails(warehouse),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    warehouse['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.edit, color: Colors.blue),
                          title: Text('Editar'),
                          onTap: () {
                            Navigator.pop(context);
                            _editWarehouse(warehouse);
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.delete, color: Colors.red),
                          title: Text('Eliminar'),
                          onTap: () {
                            Navigator.pop(context);
                            _confirmDelete(warehouse);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                warehouse['location'],
                style: TextStyle(color: Colors.grey.shade600),
              ),
              SizedBox(height: 16),
              LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey.shade200,
                color: statusColor,
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${warehouse['currentStock']}/${warehouse['capacity']}',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWarehouseDetails(Map<String, dynamic> warehouse) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade100,
              child: Icon(Icons.warehouse, size: 40, color: Colors.blue.shade700),
            ),
            SizedBox(height: 16),
            Text(
              warehouse['name'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              warehouse['location'],
              style: TextStyle(color: Colors.grey.shade600),
            ),
            SizedBox(height: 20),
            Divider(),
            _buildDetailRow(Icons.storage, 'Capacidad: ${warehouse['capacity']}'),
            _buildDetailRow(Icons.inventory, 'Stock actual: ${warehouse['currentStock']}'),
            _buildDetailRow(Icons.calendar_today, 'Última actualización: ${warehouse['lastUpdated']}'),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          SizedBox(width: 16),
          Text(text),
        ],
      ),
    );
  }

  void _showWarehouseForm() {
    _nameController.clear();
    _locationController.clear();
    _capacityController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nuevo Almacén',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre*',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.warehouse),
                  ),
                  validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Ubicación*',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _capacityController,
                  decoration: InputDecoration(
                    labelText: 'Capacidad*',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.storage),
                    suffixText: 'unidades',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: _submitForm,
                  child: Text('GUARDAR ALMACÉN'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editWarehouse(Map<String, dynamic> warehouse) {
    _nameController.text = warehouse['name'];
    _locationController.text = warehouse['location'];
    _capacityController.text = warehouse['capacity'].toString();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Editar Almacén',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre*',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.warehouse),
                  ),
                  validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Ubicación*',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _capacityController,
                  decoration: InputDecoration(
                    labelText: 'Capacidad*',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.storage),
                    suffixText: 'unidades',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () => _updateWarehouse(warehouse),
                  child: Text('ACTUALIZAR ALMACÉN'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newWarehouse = {
        'id': _warehouses.length + 1,
        'name': _nameController.text,
        'location': _locationController.text,
        'capacity': int.parse(_capacityController.text),
        'currentStock': 0,
        'lastUpdated': DateTime.now().toString().substring(0, 10),
      };

      setState(() {
        _warehouses.add(newWarehouse);
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Almacén creado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _updateWarehouse(Map<String, dynamic> warehouse) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        warehouse['name'] = _nameController.text;
        warehouse['location'] = _locationController.text;
        warehouse['capacity'] = int.parse(_capacityController.text);
        warehouse['lastUpdated'] = DateTime.now().toString().substring(0, 10);
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Almacén actualizado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _confirmDelete(Map<String, dynamic> warehouse) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar almacén'),
        content: Text('¿Estás seguro de eliminar el almacén ${warehouse['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _warehouses.remove(warehouse);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Almacén eliminado'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Buscar almacén'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Nombre o ubicación...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Buscar'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(double percentage) {
    if (percentage > 90) return Colors.red;
    if (percentage > 60) return Colors.orange;
    return Colors.green;
  }
}