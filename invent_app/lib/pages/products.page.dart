import 'package:flutter/material.dart';
import 'package:invent_app/pages/add_product_page.dart';

class ProductPage extends StatefulWidget {


  const ProductPage({super.key});

  static String routeName = "product_movement";


  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {


  final List<Map<String, dynamic>> products = List.generate(10, (index) {
    return {
      "id": index + 1,
      "name": "Producto ${index + 1}",
      "category": "Categoría ${index % 3 + 1}",
      "stock": (index + 5) * 10,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvV6O4XUHWJJIbjoI1SRhFaCOCumNevgpJgQ&s",
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Productos", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildProductCard(products[index]);
        },
      ),
       floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade600,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AddProductPage(),
        ));
        },
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              // Imagen del producto con borde circular
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product["image"],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              // Detalles del producto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product["name"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      product["category"],
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    SizedBox(height: 8),
                    // Barra de progreso para el stock
                    LinearProgressIndicator(
                      value: product["stock"] / 100,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        product["stock"] > 50 ? Colors.green : Colors.orange,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Stock: ${product["stock"]} unidades",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Icono de acción
              IconButton(
                icon: Icon(Icons.chevron_right, color: Colors.blue),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

}