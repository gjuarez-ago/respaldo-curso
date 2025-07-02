import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  static String routeName = "reports_page";


  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {

 int _currentTabIndex = 0;
  final List<String> _reportTabs = ['Stock', 'Movimientos', 'Categorías'];

  // Datos simulados
  final List<WarehouseData> _warehouseData = [
    WarehouseData('Almacén A', 150, 80),
    WarehouseData('Almacén B', 90, 60),
    WarehouseData('Almacén C', 200, 120),
  ];

  final List<MovementData> _movementData = [
    MovementData(DateTime(2023, 1, 1), 12, 8),
    MovementData(DateTime(2023, 2, 1), 15, 10),
    MovementData(DateTime(2023, 3, 1), 8, 5),
  ];

  final List<CategoryData> _categoryData = [
    CategoryData('Electrónicos', 35, Colors.blue),
    CategoryData('Ropa', 28, Colors.purple),
    CategoryData('Alimentos', 20, Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportes de Inventario'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Column(
        children: [
          // Selector de pestañas
          _buildTabSelector(),
          SizedBox(height: 10),
          // Contenido del reporte seleccionado
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IndexedStack(
                index: _currentTabIndex,
                children: [
                  _buildStockReport(),    // Pestaña 0: Stock
                  _buildMovementReport(), // Pestaña 1: Movimientos
                  _buildCategoryReport(), // Pestaña 2: Categorías
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _reportTabs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(_reportTabs[index]),
              selected: _currentTabIndex == index,
              selectedColor: Colors.blue.shade200,
              onSelected: (selected) {
                setState(() {
                  _currentTabIndex = index;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildStockReport() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Gráfico de barras - Stock por almacén
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stock por Almacén',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 250,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        barGroups: _warehouseData.map((data) {
                          return BarChartGroupData(
                            x: _warehouseData.indexOf(data),
                            barRods: [
                              BarChartRodData(
                                toY: data.totalStock.toDouble(),
                                color: Colors.blue.shade400,
                                width: 20,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(6),
                                ),
                              ),
                              BarChartRodData(
                                toY: data.currentStock.toDouble(),
                                color: Colors.green.shade400,
                                width: 20,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(6),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    _warehouseData[value.toInt()].name,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                            ),
                          ),
                        ),
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegend(Colors.blue, 'Capacidad Total'),
                      SizedBox(width: 20),
                      _buildLegend(Colors.green, 'Stock Actual'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          // Indicadores de porcentaje
          LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) { 
                return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(constraints.maxWidth > 600 ? 24 : 16),
              child: _buildStockIndicators(constraints),
            ),
          );
        
           },),
        ],
      ),
    );
  }

  Widget _buildMovementReport() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Gráfico de líneas - Tendencias mensuales
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Movimientos Mensuales',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 250,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: _movementData.map((data) {
                              return FlSpot(
                                data.date.month.toDouble(),
                                data.entradas.toDouble(),
                              );
                            }).toList(),
                            color: Colors.green,
                            isCurved: true,
                            barWidth: 4,
                            belowBarData: BarAreaData(show: false),
                          ),
                          LineChartBarData(
                            spots: _movementData.map((data) {
                              return FlSpot(
                                data.date.month.toDouble(),
                                data.salidas.toDouble(),
                              );
                            }).toList(),
                            color: Colors.red,
                            isCurved: true,
                            barWidth: 4,
                          ),
                        ],
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final month = DateFormat('MMM').format(
                                  DateTime(2023, value.toInt(), 1),
                                );
                                return Text(month);
                              },
                            ),
                          ),
                        ),
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegend(Colors.green, 'Entradas'),
                      SizedBox(width: 20),
                      _buildLegend(Colors.red, 'Salidas'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryReport() {
    final totalProducts = _categoryData.fold(
        0, (sum, category) => sum + category.productCount);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Gráfico circular - Distribución por categoría
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Distribución por Categoría',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 300,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 60,
                        sections: _categoryData.map((data) {
                          return PieChartSectionData(
                            color: data.color,
                            value: data.productCount.toDouble(),
                            title: '${((data.productCount / totalProducts) * 100).toStringAsFixed(1)}%',
                            radius: 80,
                            titleStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Leyenda interactiva
                  Column(
                    children: _categoryData.map((data) {
                      return ListTile(
                        leading: Container(
                          width: 20,
                          height: 20,
                          color: data.color,
                        ),
                        title: Text(data.name),
                        trailing: Text(
                          '${data.productCount} productos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
    Widget _buildStockIndicators(BoxConstraints constraints) {
    // Calculamos el tamaño mínimo requerido para cada tarjeta
    final cardWidth = constraints.maxWidth > 600 
        ? (constraints.maxWidth - 72) / 3  // 3 columnas con padding
        : (constraints.maxWidth - 48) / 2;  // 2 columnas con padding

    return Wrap(
      spacing: constraints.maxWidth > 600 ? 24 : 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: _warehouseData.map((data) {
        final percentage = (data.currentStock / data.totalStock) * 100;
        return SizedBox(
          width: cardWidth,
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(constraints.maxWidth > 600 ? 16 : 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nombre del almacén
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      data.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxWidth > 600 ? 16 : 14,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Indicador circular
                  Container(
                    width: constraints.maxWidth > 600 ? 80 : 70,
                    height: constraints.maxWidth > 600 ? 80 : 70,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: percentage / 100,
                          backgroundColor: Colors.grey.shade200,
                          color: percentage > 75
                              ? Colors.red
                              : percentage > 50
                                  ? Colors.orange
                                  : Colors.green,
                          strokeWidth: constraints.maxWidth > 600 ? 10 : 8,
                        ),
                        Text(
                          '${percentage.toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: constraints.maxWidth > 600 ? 16 : 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Detalles de stock
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 4),
                    child: Text(
                      '${data.currentStock.toInt()}/${data.totalStock.toInt()}',
                      style: TextStyle(
                        fontSize: constraints.maxWidth > 600 ? 14 : 12,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Etiqueta de estado (solo en pantallas grandes)
                  if (constraints.maxWidth > 600)
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        _getStockStatus(percentage),
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(percentage),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getStockStatus(double percentage) {
    if (percentage > 90) return 'ALTO STOCK';
    if (percentage > 50) return 'STOCK MEDIO';
    return 'BAJO STOCK';
  }

  Color _getStatusColor(double percentage) {
    if (percentage > 90) return Colors.red;
    if (percentage > 50) return Colors.orange;
    return Colors.green;
  }

  Widget _buildLegend(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}

// Modelos de datos
class WarehouseData {
  final String name;
  final int totalStock;
  final int currentStock;

  WarehouseData(this.name, this.totalStock, this.currentStock);
}

class MovementData {
  final DateTime date;
  final int entradas;
  final int salidas;

  MovementData(this.date, this.entradas, this.salidas);
}

class CategoryData {
  final String name;
  final int productCount;
  final Color color;

  CategoryData(this.name, this.productCount, this.color);
}