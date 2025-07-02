import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

    static String routeName = "category_page";


  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
 final List<Map<String, dynamic>> _categories = [
    {'id': 1, 'name': 'Electrónicos', 'products': 24, 'color': Colors.blue.value, 'icon': Icons.devices.codePoint},
    {'id': 2, 'name': 'Ropa', 'products': 42, 'color': Colors.purple.value, 'icon': Icons.checkroom.codePoint},
    {'id': 3, 'name': 'Alimentos', 'products': 15, 'color': Colors.orange.value, 'icon': Icons.fastfood.codePoint},
    {'id': 4, 'name': 'Hogar', 'products': 18, 'color': Colors.green.value, 'icon': Icons.home.codePoint},
    {'id': 5, 'name': 'Oficina', 'products': 12, 'color': Colors.red.value, 'icon': Icons.work.codePoint},
    {'id': 6, 'name': 'Deportes', 'products': 22, 'color': Colors.teal.value, 'icon': Icons.sports_soccer.codePoint},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filtros (Scroll horizontal seguro)
            SizedBox(
              height: 60,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 12),
                    _buildFilterChip('Todas', true),
                    _buildFilterChip('Más usadas', false),
                    _buildFilterChip('Recientes', false),
                    _buildFilterChip('Sin productos', false),
                    SizedBox(width: 12),
                  ],
                ),
              ),
            ),
            // Lista adaptable
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                  final childAspectRatio = constraints.maxWidth > 600 ? 1.0 : 1.2;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        return _buildCategoryCard(_categories[index], isSmallScreen);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade600,
        onPressed: _showCategoryForm,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
        label: Text(label),
        backgroundColor: selected ? Colors.purple.shade100 : Colors.grey.shade200,
        labelStyle: TextStyle(
          color: selected ? Colors.purple.shade800 : Colors.grey.shade700,
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category, bool isSmallScreen) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showCategoryDetails(category),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icono con fondo de color
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                decoration: BoxDecoration(
                  color: Color(category['color']).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  IconData(category['icon'], fontFamily: 'MaterialIcons'),
                  color: Color(category['color']),
                  size: isSmallScreen ? 24 : 28,
                ),
              ),
              SizedBox(height: isSmallScreen ? 8 : 12),
              // Nombre de categoría (responsive)
              Text(
                category['name'],
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              // Contador de productos
              Text(
                '${category['products']} productos',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: isSmallScreen ? 11 : 12,
                ),
              ),
              Spacer(),
              // Barra de progreso
              LinearProgressIndicator(
                value: category['products'] / 50,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Color(category['color'])),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Buscar categoría'),
        content: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Nombre de categoría...',
              prefixIcon: Icon(Icons.search),
            ),
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

  void _showCategoryForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxWidth: 600,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nueva Categoría', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Selector de color seguro
              SizedBox(
                height: 70,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildColorOption(Colors.blue),
                      _buildColorOption(Colors.purple),
                      _buildColorOption(Colors.green),
                      _buildColorOption(Colors.orange),
                      _buildColorOption(Colors.red),
                      _buildColorOption(Colors.teal),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Selector de icono seguro
              SizedBox(
                height: 70,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildIconOption(Icons.devices),
                      _buildIconOption(Icons.checkroom),
                      _buildIconOption(Icons.fastfood),
                      _buildIconOption(Icons.home),
                      _buildIconOption(Icons.directions_car),
                      _buildIconOption(Icons.sports),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.purple.shade600,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('GUARDAR CATEGORÍA'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () {},
        child: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          radius: 24,
          child: CircleAvatar(
            backgroundColor: color,
            radius: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildIconOption(IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () {},
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          radius: 24,
          child: Icon(icon, color: Colors.grey.shade700),
        ),
      ),
    );
  }

  void _showCategoryDetails(Map<String, dynamic> category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          maxWidth: 600,
        ),
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Color(category['color']).withOpacity(0.2),
                radius: 30,
                child: Icon(
                  IconData(category['icon'], fontFamily: 'MaterialIcons'),
                  color: Color(category['color']),
                  size: 30,
                ),
              ),
              SizedBox(height: 16),
              Text(
                category['name'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '${category['products']} productos asociados',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              SizedBox(height: 24),
              Divider(),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.blue),
                title: Text('Editar categoría'),
                onTap: () {
                  Navigator.pop(context);
                  _showCategoryForm();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Eliminar categoría'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(category);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar categoría'),
        content: Text('¿Estás seguro de eliminar "${category['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }


}