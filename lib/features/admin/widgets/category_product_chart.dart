import 'package:amazon_clone_flutter/features/admin/models/sales.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> salesData;

  const CategoryProductsChart({Key? key, required this.salesData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1E2C), Color(0xFF2A2A3D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sales by Category",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _getMaxY(),

                /// 🔥 TOOLTIP
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipPadding: const EdgeInsets.all(10),
                    tooltipMargin: 8,
                    tooltipBorderRadius: BorderRadius.circular(12),
                    getTooltipColor: (group) => const Color(0xFF2A2A3D),
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${salesData[groupIndex].label}\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: _formatRupiah(rod.toY),
                            style: const TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                /// 🔥 TITLES
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= salesData.length) {
                          return const SizedBox.shrink();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            salesData[index].label,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),

                /// 🔥 GRID
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(color: Colors.white10, strokeWidth: 1);
                  },
                ),

                borderData: FlBorderData(show: false),

                /// 🔥 BAR DATA
                barGroups: salesData.asMap().entries.map((entry) {
                  final index = entry.key;
                  final sales = entry.value;

                  return BarChartGroupData(
                    x: index,
                    barsSpace: 4,
                    barRods: [
                      BarChartRodData(
                        toY: sales.earning.toDouble(),
                        width: 18,
                        borderRadius: BorderRadius.circular(6),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF00C9A7)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  );
                }).toList(),
              ),
              swapAnimationDuration: const Duration(milliseconds: 300),
              swapAnimationCurve: Curves.easeOut,
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 FORMAT ANGKA (hapus .0)
  String _formatNumber(double value) {
    String result = value.toStringAsFixed(1);
    if (result.endsWith('.0')) {
      result = result.replaceAll('.0', '');
    }
    return result;
  }

  /// 🔥 FORMAT RUPIAH FLEXIBLE
  String _formatRupiah(double value, {bool short = true}) {
    if (value >= 1000000000000) {
      return short
          ? 'Rp ${_formatNumber(value / 1000000000000)}T'
          : 'Rp ${_formatNumber(value / 1000000000000)} Triliun';
    } else if (value >= 1000000000) {
      return short
          ? 'Rp ${_formatNumber(value / 1000000000)}M'
          : 'Rp ${_formatNumber(value / 1000000000)} Miliar';
    } else if (value >= 1000000) {
      return short
          ? 'Rp ${_formatNumber(value / 1000000)}JT'
          : 'Rp ${_formatNumber(value / 1000000)} Juta';
    } else if (value >= 1000) {
      return short
          ? 'Rp ${_formatNumber(value / 1000)}K'
          : 'Rp ${_formatNumber(value / 1000)} Ribu';
    } else {
      return 'Rp ${value.toInt()}';
    }
  }

  /// 🔥 MAX Y DINAMIS
  double _getMaxY() {
    if (salesData.isEmpty) return 10;

    double maxEarning = 0;
    for (var sale in salesData) {
      if (sale.earning > maxEarning) {
        maxEarning = sale.earning.toDouble();
      }
    }

    return maxEarning == 0 ? 10 : maxEarning * 1.3;
  }
}
