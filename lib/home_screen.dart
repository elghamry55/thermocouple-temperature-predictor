import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'neural_model.dart';
import 'chart_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _voltageCtrl = TextEditingController();
  final NeuralNetworkModel _model = NeuralNetworkModel();

  List<FlSpot> liveErrorPoints = [];
  double attemptCounter = 0;

  double? predictedTemp;
  double? actualTemp;
  double? mseError;
  bool showResults = false;

  final Color primaryDark = const Color(0xFF1565C0);
  final Color primaryLight = const Color(0xFF673AB7);
  final Color background = const Color(0xFFF0F2F5);

  void _calculate() {
    if (_voltageCtrl.text.isEmpty) return;
    try {
      double v = double.parse(_voltageCtrl.text);
      var result = _model.predict(v);

      setState(() {
        predictedTemp = result['predicted'];
        actualTemp = result['actual'];
        mseError = result['error'];
        showResults = true;

        attemptCounter++;
        liveErrorPoints.add(FlSpot(attemptCounter, mseError!));
      });
      FocusScope.of(context).unfocus();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text("Please enter a valid number", style: GoogleFonts.poppins()),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _resetGraph() {
    setState(() {
      liveErrorPoints.clear();
      attemptCounter = 0;
      showResults = false;
      _voltageCtrl.clear();
      predictedTemp = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        title: Text("Type J Thermocouple",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, color: const Color(0xFF37474F))),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF37474F)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
              ],
            ),
            child: IconButton(
              onPressed: _resetGraph,
              icon: const Icon(Icons.refresh_rounded, color: Color(0xFF1565C0)),
              tooltip: "Reset Graph",
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFF1565C0).withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sensor Reading",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600)),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _voltageCtrl,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF37474F)),
                    decoration: InputDecoration(
                      hintText: "Enter Voltage (e.g. 5.269)",
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.grey.shade400),
                      filled: true,
                      fillColor: const Color(0xFFF5F7FA),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("mV",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: primaryDark)),
                      ),
                      prefixIcon: Icon(Icons.electric_bolt_rounded,
                          color: Colors.amber.shade700),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 20),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [primaryDark, primaryLight]),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: primaryDark.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6))
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.online_prediction_rounded,
                              color: Colors.white),
                          const SizedBox(width: 10),
                          Text("Analyze Reading",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            if (showResults) ...[
              Row(
                children: [
                  _buildModernResultCard(
                    title: "Predicted",
                    value: "${predictedTemp!.toStringAsFixed(2)}°C",
                    icon: Icons.thermostat_rounded,
                    color: const Color(0xFF2196F3),
                    bgColor: const Color(0xFFE3F2FD),
                  ),
                  const SizedBox(width: 15),
                  _buildModernResultCard(
                    title: "Reference",
                    value: "${actualTemp!.toStringAsFixed(2)}°C",
                    icon: Icons.menu_book_rounded,
                    color: const Color(0xFF00BFA5),
                    bgColor: const Color(0xFFE0F2F1),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.analytics_outlined,
                        color: Colors.red.shade400, size: 20),
                    const SizedBox(width: 8),
                    Text("MSE Loss: ",
                        style:
                            GoogleFonts.poppins(color: Colors.grey.shade600)),
                    Text(
                      mseError!.toStringAsFixed(4),
                      style: GoogleFonts.poppins(
                          color: Colors.red.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
            ],
            LiveErrorChartWidget(errorPoints: liveErrorPoints),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildModernResultCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                offset: const Offset(0, 5))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: bgColor, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 15),
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            Text(value,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: const Color(0xFF37474F),
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
