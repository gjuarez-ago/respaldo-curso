import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProductPage extends StatefulWidget {
   final Map<String, dynamic>? product;

  const AddProductPage({
    super.key,
    this.product,
  });
  
  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
 final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _barcodeController = TextEditingController();

  File? _selectedImage;
  Category? _selectedCategory;
  Supplier? _selectedSupplier;

  // Datos simulados basados en tus relaciones JPA
  final List<Category> _categories = [
    Category(id: 1, name: "Electrónicos"),
    Category(id: 2, name: "Ropa"),
    Category(id: 3, name: "Alimentos"),
  ];

  final List<Supplier> _suppliers = [
    Supplier(id: 1, name: "Proveedor Tech", contact: "contact@tech.com"),
    Supplier(id: 2, name: "Distribuidora Moda", contact: "contact@moda.com"),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Producto", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sección de imagen
              _buildImageSection(),
              SizedBox(height: 30),
              
              // Campo Nombre
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration(
                  label: "Nombre del Producto*",
                  icon: Icons.shopping_bag_outlined,
                ),
                validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
              ),
              SizedBox(height: 20),
              
              // Campo Descripción
              TextFormField(
                controller: _descriptionController,
                decoration: _inputDecoration(
                  label: "Descripción",
                  icon: Icons.description_outlined,
                ),
                maxLines: 3,
                maxLength: 200,
              ),
              SizedBox(height: 20),
              
              // Campo Código de Barras
              TextFormField(
                controller: _barcodeController,
                decoration: _inputDecoration(
                  label: "Código de Barras",
                  icon: Icons.barcode_reader,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(height: 20),
              
              // Selector de Categoría (ManyToOne)
              DropdownButtonFormField<Category>(
                value: _selectedCategory,
                decoration: _inputDecoration(
                  label: "Categoría*",
                  icon: Icons.category_outlined,
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                validator: (value) => value == null ? "Seleccione una categoría" : null,
                onChanged: (value) => setState(() => _selectedCategory = value),
              ),
              SizedBox(height: 20),
              
              // Selector de Proveedor (ManyToOne)
              DropdownButtonFormField<Supplier>(
                value: _selectedSupplier,
                decoration: _inputDecoration(
                  label: "Proveedor*",
                  icon: Icons.local_shipping_outlined,
                ),
                items: _suppliers.map((supplier) {
                  return DropdownMenuItem<Supplier>(
                    value: supplier,
                    child: Text(supplier.name),
                  );
                }).toList(),
                validator: (value) => value == null ? "Seleccione un proveedor" : null,
                onChanged: (value) => setState(() => _selectedSupplier = value),
              ),
              SizedBox(height: 30),
              
              // Botón de Guardar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: _submitForm,
                child: Text("GUARDAR PRODUCTO", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String label, required IconData icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blue.shade600),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    );
  }

  Widget _buildImageSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: _showImagePickerOptions,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.blue.shade200,
                width: 2,
                style: BorderStyle.solid,
              ),
              image: _selectedImage != null
                  ? DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: _selectedImage == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo, size: 40, color: Colors.grey.shade400),
                      SizedBox(height: 8),
                      Text("Agregar imagen", style: TextStyle(color: Colors.grey.shade600)),
                    ],
                  )
                : null,
          ),
        ),
        SizedBox(height: 10),
        if (_selectedImage != null)
          TextButton(
            onPressed: _showImagePickerOptions,
            child: Text("Cambiar imagen", style: TextStyle(color: Colors.blue.shade600)),
          ),
      ],
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Galería"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Cámara"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al seleccionar imagen: $e")),
      );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Crear objeto Product basado en tus entidades JPA
      final newProduct = {
        "name": _nameController.text,
        "description": _descriptionController.text,
        "barcode": _barcodeController.text,
        "category": {"id": _selectedCategory!.id},
        "supplier": {"id": _selectedSupplier!.id},
        "image": _selectedImage?.path,
        "dateCreated": DateTime.now().toIso8601String(),
        "dateUpdated": DateTime.now().toIso8601String(),
      };

      // Simulación de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Producto creado exitosamente"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      
      Navigator.pop(context, newProduct);
    }
  }
}

// Modelos basados en tus entidades JPA
class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});
}

class Supplier {
  final int id;
  final String name;
  final String contact;

  Supplier({required this.id, required this.name, required this.contact});
}