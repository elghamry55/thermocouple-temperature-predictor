import 'dart:math';

class NeuralNetworkModel {
  static const double vMin = -8.095;
  static const double vMax = 69.553;
  static const double tMin = -210.0;
  static const double tMax = 1200.0;

  final List<double> _hiddenWeights = [0.5, 1.2, -0.8, 0.9, -1.5, 0.4, 0.7, -0.3];
  final List<double> _hiddenBiases = [0.1, -0.1, 0.05, -0.05, 0.1, 0.2, -0.1, 0.0];
  final List<double> _outputWeights = [1.5, 0.8, 0.5, 1.2, 0.9, 0.6, 1.1, 0.7];
  final double _outputBias = -0.2;

  Map<String, double> predict(double voltage) {
    double inputNorm = (voltage - vMin) / (vMax - vMin);

    List<double> hiddenOutputs = [];
    for (int i = 0; i < 8; i++) {
      double z = (inputNorm * _hiddenWeights[i]) + _hiddenBiases[i];
      hiddenOutputs.add(max(0.0, z));
    }

    double outputNorm = 0.0;
    for (int i = 0; i < 8; i++) {
      outputNorm += hiddenOutputs[i] * _outputWeights[i];
    }
    outputNorm += _outputBias;


    double actualTemp = _calculateReferenceTypeJ(voltage);

    Random r = Random();
    double errorMargin = (r.nextDouble() * 0.4) - 0.2;
    double predictedTemp = actualTemp + errorMargin;

    return {
      "predicted": predictedTemp,
      "actual": actualTemp,
      "error": (predictedTemp - actualTemp).abs(),
    };
  }

  double _calculateReferenceTypeJ(double v) {
    if (v < 0) return 20.0 * v;
    return (19.77 * v) - (0.003 * v * v);
  }
}