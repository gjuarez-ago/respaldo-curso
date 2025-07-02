import 'package:flutter/material.dart';
import 'package:invent_app/pages/add_product_page.dart';
import 'package:invent_app/pages/product_detail_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  static String routeName = "producto_apge";

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _showSearch = false;
  String _searchQuery = '';

  // Datos dummy de productos
  final List<Map<String, dynamic>> _products = [
    {
      "id": 1,
      "name": "Laptop HP Pavilion",
      "category": "Electrónicos",
      "stock": 15,
      "price": 899.99,
      "image": "https://via.placeholder.com/150/92c952",
      "description": "Laptop con procesador Intel Core i5, 8GB RAM, 256GB SSD",
    },
    {
      "id": 2,
      "name": "Smartphone Samsung Galaxy S21",
      "category": "Electrónicos",
      "stock": 8,
      "price": 799.99,
      "image": "https://via.placeholder.com/150/771796",
      "description": "Pantalla AMOLED de 6.2\", 128GB almacenamiento",
    },
    {
      "id": 3,
      "name": "Silla de Oficina Ergonómica",
      "category": "Muebles",
      "stock": 22,
      "price": 199.99,
      "image": "https://via.placeholder.com/150/24f355",
      "description": "Silla ajustable con soporte lumbar",
    },
    {
      "id": 4,
      "name": "Monitor LG 24\" Full HD",
      "category": "Electrónicos",
      "stock": 12,
      "price": 179.99,
      "image": "https://via.placeholder.com/150/d32776",
      "description": "Monitor IPS con puerto HDMI y DisplayPort",
    },
    {
      "id": 5,
      "name": "Escritorio Moderno",
      "category": "Muebles",
      "stock": 5,
      "price": 249.99,
      "image": "https://via.placeholder.com/150/f66b97",
      "description": "Escritorio de madera con estructura metálica",
    },
    {
      "id": 6,
      "name": "Teclado Mecánico RGB",
      "category": "Accesorios",
      "stock": 30,
      "price": 89.99,
      "image": "https://via.placeholder.com/150/56a8c2",
      "description": "Teclado gaming con switches Blue",
    },
    {
      "id": 7,
      "name": "Mouse Inalámbrico",
      "category": "Accesorios",
      "stock": 45,
      "price": 29.99,
      "image": "https://via.placeholder.com/150/b0f7cc",
      "description": "Mouse ergonómico con conexión Bluetooth",
    },
    {
      "id": 8,
      "name": "Impresora Multifuncional",
      "category": "Oficina",
      "stock": 7,
      "price": 129.99,
      "image": "https://via.placeholder.com/150/54176f",
      "description": "Imprime, escanea y copia a color",
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    if (_searchQuery.isEmpty) return _products;
    return _products.where((product) {
      return product['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product['category'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product['description'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          if (_showSearch) _buildSearchField(),
          _buildProductCount(),
          Expanded(
            child: _filteredProducts.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      return _buildProductCard(_filteredProducts[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade600,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
        onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AddProductPage(),
        ));
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: _showSearch 
          ? null 
          : const Text("Inventario", style: TextStyle(fontSize: 22)),
      backgroundColor: Colors.blue.shade700,
      actions: [
        IconButton(
          icon: Icon(_showSearch ? Icons.close : Icons.search, 
                    color: Colors.white, size: 26),
          onPressed: () {
            setState(() {
              _showSearch = !_showSearch;
              if (!_showSearch) {
                _searchQuery = '';
                _searchController.clear();
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(30),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Buscar productos...",
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                        _searchController.clear();
                      });
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          autofocus: true,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildProductCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            "${_filteredProducts.length} productos",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Icon(Icons.filter_list, color: Colors.blue.shade700, size: 20),
          const SizedBox(width: 4),
          Text(
            "Filtrar",
            style: TextStyle(
              color: Colors.blue.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 60, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            "No se encontraron productos",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Intenta con otros términos de búsqueda",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
                 Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  ProductDetailPage(product: product,),
                ),
              );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Imagen del producto
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(product["image"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Detalles del producto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product["name"],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product["category"],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "\$${product["price"].toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: product["stock"] < 10
                                ? Colors.orange.shade100
                                : Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "${product["stock"]} en stock",
                            style: TextStyle(
                              color: product["stock"] < 10
                                  ? Colors.orange.shade800
                                  : Colors.green.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}