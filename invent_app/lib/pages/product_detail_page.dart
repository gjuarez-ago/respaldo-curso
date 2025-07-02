import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(0, 0),
                      )
                    ],
                  )),
              background: Hero(
                tag: 'product-image-${product['id']}',
                child: Image.network(
                  product['image'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // Acción para compartir
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPriceSection(),
                  const SizedBox(height: 20),
                  _buildInfoSection(),
                  const SizedBox(height: 20),
                  _buildDescriptionSection(),
                  const SizedBox(height: 20),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '\$${product['price'].toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: product['stock'] < 10 
                ? Colors.orange.shade100 
                : Colors.green.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            product['stock'] < 10 ? 'Stock bajo' : 'Disponible',
            style: TextStyle(
              color: product['stock'] < 10 
                  ? Colors.orange.shade800 
                  : Colors.green.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        const Text('4.8', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildInfoRow('Categoría', product['category']),
          const Divider(height: 20),
          _buildInfoRow('SKU', 'PRD-${product['id'].toString().padLeft(4, '0')}'),
          const Divider(height: 20),
          _buildInfoRow('En stock', '${product['stock']} unidades'),
          const Divider(height: 20),
          _buildInfoRow('Proveedor', 'ElectroTech S.A.'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 15,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descripción',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          product['description'],
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade800,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Especificaciones',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _buildSpecificationItem('Modelo', '2023'),
        _buildSpecificationItem('Garantía', '12 meses'),
        _buildSpecificationItem('Color', 'Negro'),
        _buildSpecificationItem('Dimensiones', '40 x 30 x 15 cm'),
      ],
    );
  }

  Widget _buildSpecificationItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: Colors.grey.shade500),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.edit, size: 20),
            label: const Text('EDITAR'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              side: BorderSide(color: Colors.blue.shade700),
            ),
            onPressed: () {
              // Acción para editar
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.shopping_cart, size: 20),
            label: const Text('PEDIR MÁS'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: () {
              // Acción para pedir más
            },
          ),
        ),
      ],
    );
  }
}