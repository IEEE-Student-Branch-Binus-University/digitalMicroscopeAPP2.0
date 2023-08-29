// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ESPdataState extends ChangeNotifier {
  int brightness = 0;
  int xpos = 0;
  int ypos = 0;
  int zpos = 0;
  int currentValue = 0;
  int multiplier = 1;
  bool doingTask = false;
  bool ishoming = false;

  void updateValue(int newValue) {
    currentValue = newValue;
    notifyListeners();
  }

  void updateMultiplier(int newMultiplier) {
    multiplier = newMultiplier;
    notifyListeners();
  }

  void updateBrightness(int newBrightness) {
    brightness = newBrightness;
    notifyListeners();
  }

  void subtractAndUpdateText(
      int subtractAmount, TextEditingController controller) {
    int currentValue = int.tryParse(controller.text) ?? 0;
    int result = currentValue - subtractAmount;
    controller.text = result.toString();
  }

  void addValue(int currentValue, int addAmount) {
    currentValue = (currentValue + addAmount).clamp(1, 1000);
    updateValue(currentValue);
    notifyListeners();
  }

  void updateXPos(int newXPos) {
    xpos = newXPos;
    notifyListeners();
  }

  void updateYPos(int newYPos) {
    ypos = newYPos;
    notifyListeners();
  }

  void updateZPos(int newZPos) {
    zpos = newZPos;
    notifyListeners();
  }

  void toggleTaskStatus() {
    doingTask = !doingTask;
    notifyListeners();
  }

  Future<void> submitValues() async {
    doingTask = !doingTask;
    notifyListeners();

    final Map data = {
      'brightness': brightness,
      'xpos': xpos,
      'ypos': ypos,
      'zpos': zpos,
    };

    const String url = 'http://esp.local/pos';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle lock status');
    } else {
      doingTask = !doingTask;
      notifyListeners();
    }
  }

  Future<void> resetValue() async {
    ishoming = !ishoming;
    notifyListeners();
    const String url = 'http://esp.local/reset';

    final Map data = {};

    final response = await http.post(
      Uri.parse(url),
      body: json.encode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to toggle lock status');
    } else {
      ishoming = !ishoming;
      notifyListeners();
    }
  }
}

class MaxInputFormatter extends TextInputFormatter {
  final int maxValue;

  MaxInputFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '0');
    } else {
      final parsed = int.tryParse(newValue.text);
      if (parsed != null && parsed <= maxValue) {
        return newValue;
      }
      return oldValue;
    }
  }
}
