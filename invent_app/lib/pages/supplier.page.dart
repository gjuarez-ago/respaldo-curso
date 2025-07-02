import 'package:flutter/material.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({super.key});

  static String routeName = "supplier_page";

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  final List<Map<String, dynamic>> _suppliers = List.generate(8, (index) {
    return {
      "id": index + 1,
      "name": "Proveedor ${index + 1}",
      "contact": "contacto${index + 1}@empresa.com",
      "phone": "+52 ${5550000000 + index}",
      "products": index * 5 + 10,
      "status": index % 3 == 0 ? "Inactivo" : "Activo",
      "lastOrder": "2023-06-${15 + index}",
    };
  });

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proveedores", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros
          _buildFilterChips(),
          // Lista
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: _suppliers.length,
              itemBuilder: (context, index) {
                return _buildSupplierCard(_suppliers[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade600,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => _showSupplierForm(),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey.shade100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip("Todos", true),
            SizedBox(width: 8),
            _buildFilterChip("Activos", false),
            SizedBox(width: 8),
            _buildFilterChip("Inactivos", false),
            SizedBox(width: 8),
            _buildFilterChip("Con stock", false),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: Colors.red.shade100,
      labelStyle: TextStyle(
        color: selected ? Colors.red.shade800 : Colors.black,
      ),
      onSelected: (value) {
        // Lógica de filtrado
      },
    );
  }

  Widget _buildSupplierCard(Map<String, dynamic> supplier) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red.shade100,
          child: Icon(
            Icons.local_shipping,
            color: Colors.red.shade700,
          ),
        ),
        title: Text(
          supplier["name"],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(supplier["contact"]),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.phone, size: 14, color: Colors.grey.shade600),
                SizedBox(width: 4),
                Text(
                  supplier["phone"],
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.remove_red_eye, color: Colors.blue),
                title: Text("Ver detalle"),
                onTap: () {
                  Navigator.pop(context);
                  _showSupplierDetail(supplier);
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.edit, color: Colors.orange),
                title: Text("Editar"),
                onTap: () {
                  Navigator.pop(context);
                  _editSupplier(supplier);
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text("Eliminar"),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDelete(supplier);
                },
              ),
            ),
          ],
        ),
        onTap: () => _showSupplierDetail(supplier),
      ),
    );
  }

  void _showSupplierDetail(Map<String, dynamic> supplier) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ), // ¡Este paréntesis faltaba!
    builder: (context) => Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.red.shade100,
            child: Icon(Icons.local_shipping, size: 40, color: Colors.red.shade700),
          ),
          SizedBox(height: 16),
          Text(
            supplier["name"],
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            supplier["status"],
            style: TextStyle(
              color: supplier["status"] == "Activo" ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          _buildDetailRow(Icons.email, supplier["contact"]),
          _buildDetailRow(Icons.phone, supplier["phone"]),
          _buildDetailRow(Icons.inventory, "${supplier["products"]} productos asociados"),
          _buildDetailRow(Icons.calendar_today, "Último pedido: ${supplier["lastOrder"]}"),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              minimumSize: Size(double.infinity, 50),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text("Cerrar"),
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
void _showSupplierForm() {
  _nameController.clear();
  _contactController.clear();
  _phoneController.clear();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nuevo Proveedor",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildFormField(
              controller: _nameController,
              label: "Nombre*",
              icon: Icons.business,
              validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
            ),
            const SizedBox(height: 16),
            _buildFormField(
              controller: _contactController,
              label: "Contacto*",
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
            ),
            const SizedBox(height: 16),
            _buildFormField(
              controller: _phoneController,
              label: "Teléfono",
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _submitForm,
              child: const Text("GUARDAR PROVEEDOR"),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildFormField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    decoration: _inputDecoration(label, icon),
    keyboardType: keyboardType,
    validator: validator,
  );
}

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.red.shade600),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
    );
  }

  void _editSupplier(Map<String, dynamic> supplier) {
    _nameController.text = supplier["name"];
    _contactController.text = supplier["contact"];
    _phoneController.text = supplier["phone"];

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
                  "Editar Proveedor",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: _inputDecoration("Nombre*", Icons.business),
                  validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _contactController,
                  decoration: _inputDecoration("Contacto*", Icons.email),
                  validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: _inputDecoration("Teléfono", Icons.phone),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () => _updateSupplier(supplier),
                  child: Text("ACTUALIZAR PROVEEDOR"),
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
      final newSupplier = {
        "id": _suppliers.length + 1,
        "name": _nameController.text,
        "contact": _contactController.text,
        "phone": _phoneController.text,
        "products": 0,
        "status": "Activo",
        "lastOrder": "Nunca",
      };

      setState(() {
        _suppliers.add(newSupplier);
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Proveedor creado exitosamente"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _updateSupplier(Map<String, dynamic> supplier) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        supplier["name"] = _nameController.text;
        supplier["contact"] = _contactController.text;
        supplier["phone"] = _phoneController.text;
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Proveedor actualizado exitosamente"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _confirmDelete(Map<String, dynamic> supplier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Eliminar proveedor"),
        content: Text("¿Estás seguro de eliminar a ${supplier["name"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _suppliers.remove(supplier);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Proveedor eliminado"),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: Text("Eliminar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Buscar proveedor"),
        content: TextField(
          decoration: InputDecoration(
            hintText: "Nombre, contacto o teléfono...",
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Buscar"),
          ),
        ],
      ),
    );
  }
}