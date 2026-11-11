# Thermocouple Temperature Predictor

## Type J Thermocouple Analysis and Temperature Estimation

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Framework-02569B?logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Language-Dart-0175C2?logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Charts-fl__chart-764ABC" alt="fl_chart" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-3DDC84" alt="Platforms" />
</p>

Thermocouple Temperature Predictor is an educational Flutter application developed as part of a **Control Engineering** course. It provides an interface for entering Type J thermocouple voltage readings and viewing the corresponding reference temperature, displayed prediction, and error.

The application also visualizes error values across multiple analysis attempts, offering a simple way to explore thermocouple readings and temperature estimation.

## Key Features

- **Voltage Input:** Enter Type J thermocouple readings in millivolts (mV).
- **Temperature Results:** View the displayed predicted temperature and reference temperature in Celsius.
- **Error Calculation:** Display the absolute difference between the predicted and reference temperatures.
- **Live Error Chart:** Visualize error values across successive analysis attempts.
- **Reset Functionality:** Clear the current input, results, and chart history.
- **Splash Screen:** Show a dedicated introductory screen when launching the application.
- **Clean UI:** Use a Material Design interface with Google Fonts styling.

## Tech Stack

| Technology | Purpose |
| --- | --- |
| Flutter | Cross-platform application development |
| Dart | Application programming language |
| fl_chart | Error chart visualization |
| Google Fonts | Application typography |

## Project Structure

The application separates its main screens, chart visualization, and temperature calculation logic:

```text
lib/
├── main.dart
├── splash_screen.dart
├── home_screen.dart
├── neural_model.dart
└── chart_widget.dart
```

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Dart SDK (included with Flutter)
- Android Studio or Visual Studio Code
- An Android emulator or a connected device

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/elghamry55/thermocouple-temperature-predictor.git
   ```

2. Navigate to the project directory:

   ```bash
   cd thermocouple-temperature-predictor
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application:

   ```bash
   flutter run
   ```

## Screenshots

_Add application screenshots here to demonstrate the splash screen and temperature analysis interface._

## Project Context

This project was developed as part of the **Control Engineering** course to explore Type J thermocouple readings, temperature estimation, and error visualization through a practical mobile application.

> **Implementation Note:** The current implementation includes a hidden-layer calculation in the model code. However, the displayed prediction is currently based on the reference-temperature calculation with a small randomized offset. The displayed error is an absolute difference, not a validated Mean Squared Error (MSE). The project should therefore be considered an educational prototype rather than a fully trained or validated neural-network model.

## Developer

**Mahmoud Elghamry**  
Flutter Developer

- GitHub: [@elghamry55](https://github.com/elghamry55)

---

**Built with Flutter and Dart.**
