# Thermocouple Temperature Predictor

## Type J Thermocouple Analysis with Flutter

A Flutter educational application developed as part of a Control Engineering course. The app lets users enter Type J thermocouple voltage readings, view the corresponding predicted and reference temperatures, and monitor the displayed error across multiple attempts.

## Features

- **Voltage Input:** Enter a Type J thermocouple reading in millivolts (mV).
- **Temperature Results:** View the predicted temperature and the reference temperature in Celsius.
- **Error Display:** See the absolute prediction error presented as an MSE Loss value in the interface.
- **Live Error Chart:** Visualize the error values across analysis attempts.
- **Reset Functionality:** Clear the current input, results, and chart history.
- **Clean UI:** Material Design interface with Google Fonts styling and a dedicated splash screen.

## Tech Stack

- **Flutter** — Cross-platform UI framework
- **Dart** — Application programming language
- **fl_chart** — Live error chart visualization
- **Google Fonts** — Typography

## Project Structure

```
lib/
├── main.dart
├── splash_screen.dart
├── home_screen.dart
├── neural_model.dart
└── chart_widget.dart
```

## How It Works

1. Enter a voltage value in mV.
2. Select **Analyze Reading**.
3. The app displays the predicted and reference temperatures, along with the calculated absolute error.
4. Each analysis adds an error point to the live chart.
5. Use the reset button to start a new testing session.

## Getting Started

### Prerequisites

- Flutter SDK installed
- Dart SDK compatible with the project's Flutter version
- Android Studio or VS Code

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

## Project Context

This project was created for a **Control Engineering** course to explore thermocouple voltage readings, temperature estimation, and error visualization through a mobile application.

> **Implementation note:** This repository is an educational prototype. The current model code includes a hidden-layer calculation, while the displayed prediction is presently generated from the reference-temperature calculation with a small randomized offset. It should not be presented as a fully trained or validated neural-network model.

## Developer

**Mahmoud Elghamry**  
Flutter Developer

- GitHub: [@elghamry55](https://github.com/elghamry55)
