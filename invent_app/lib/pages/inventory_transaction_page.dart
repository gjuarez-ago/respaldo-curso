import 'package:flutter/material.dart';

class InventoryTransactionPage extends StatefulWidget {
  const InventoryTransactionPage({super.key});

  static String routeName = "inventory_movement_page";

  @override
  State<InventoryTransactionPage> createState() =>
      _InventoryTransactionPageState();
}

class _InventoryTransactionPageState extends State<InventoryTransactionPage> {
  
  String _transactionType = 'ENTRADA'; // 'ENTRADA' o 'SALIDA'
  int? _selectedProductId;
  int? _selectedWarehouseId;
  int _quantity = 0;

  // Datos simulados
  final List<Map<String, dynamic>> _products = [
    {'id': 1, 'name': 'Laptop HP', 'current_stock': 15},
    {'id': 2, 'name': 'Mouse Inalámbrico', 'current_stock': 42},
    {'id': 3, 'name': 'Teclado Mecánico', 'current_stock': 23},
  ];

  final List<Map<String, dynamic>> _warehouses = [
    {'id': 1, 'name': 'Almacén Principal'},
    {'id': 2, 'name': 'Almacén Secundario'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro de Movimiento',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: _transactionType == 'ENTRADA'
            ? Colors.green.shade700
            : Colors.orange.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.white),
            onPressed: () {
              // Navegar a historial de movimientos
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Selector de tipo de movimiento
            _buildTransactionTypeSelector(),
            SizedBox(height: 30),

            // Formulario de movimiento
            _buildProductDropdown(),
            SizedBox(height: 20),

            _buildWarehouseDropdown(),
            SizedBox(height: 20),

            _buildQuantityInput(),
            SizedBox(height: 30),

            // Resumen y acción
            _buildStockInfo(),
            SizedBox(height: 40),

            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTypeSelector() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTypeButton('ENTRADA', Icons.input, Colors.green),
            _buildTypeButton('SALIDA', Icons.output, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButton(String type, IconData icon, Color color) {
    final isSelected = _transactionType == type;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _transactionType = type),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? Border.all(color: color, width: 2) : null,
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? color : Colors.grey),
              SizedBox(height: 5),
              Text(
                type,
                style: TextStyle(
                  color: isSelected ? color : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Producto',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: _selectedProductId,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          ),
          items: _products.map((product) {
            return DropdownMenuItem<int>(
              value: product['id'],
              child: Text(product['name']),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedProductId = value),
          hint: Text('Seleccione un producto'),
        ),
      ],
    );
  }

  Widget _buildWarehouseDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Almacén',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: _selectedWarehouseId,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          ),
          items: _warehouses.map((warehouse) {
            return DropdownMenuItem<int>(
              value: warehouse['id'],
              child: Text(warehouse['name']),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedWarehouseId = value),
          hint: Text('Seleccione un almacén'),
        ),
      ],
    );
  }

  Widget _buildQuantityInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cantidad',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            hintText: 'Ingrese la cantidad',
            suffixIcon: Icon(Icons.format_list_numbered),
          ),
          onChanged: (value) {
            setState(() {
              _quantity = int.tryParse(value) ?? 0;
            });
          },
        ),
      ],
    );
  }

  Widget _buildStockInfo() {
    if (_selectedProductId == null) return SizedBox();

    final product = _products.firstWhere(
      (p) => p['id'] == _selectedProductId,
      orElse: () => {'current_stock': 0},
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stock actual:',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                Text(
                  '${product['current_stock']} unidades',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stock después:',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                Text(
                  '${_calculateNewStock(product['current_stock'])} unidades',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: _transactionType == 'ENTRADA'
                        ? Colors.green.shade700
                        : Colors.orange.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _calculateNewStock(int currentStock) {
    if (_transactionType == 'ENTRADA') {
      return currentStock + _quantity;
    } else {
      return currentStock - _quantity;
    }
  }

  Widget _buildSubmitButton() {
    final isValid = _selectedProductId != null &&
        _selectedWarehouseId != null &&
        _quantity > 0;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _transactionType == 'ENTRADA'
            ? Colors.green.shade600
            : Colors.orange.shade600,
        foregroundColor: Colors.white, // Color del texto/icono
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
      ),
      onPressed: isValid ? _submitTransaction : null,
      child: Text(
        _transactionType == 'ENTRADA'
            ? 'REGISTRAR ENTRADA'
            : 'REGISTRAR SALIDA',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _submitTransaction() {
    // Simulación de registro exitoso
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Movimiento registrado'),
        content: Text(
          'Se ha registrado ${_transactionType == 'ENTRADA' ? 'entrada' : 'salida'} '
          'de $_quantity unidades',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetForm();
            },
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _selectedProductId = null;
      _selectedWarehouseId = null;
      _quantity = 0;
    });
  }
}
