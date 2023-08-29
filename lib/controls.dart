import 'package:digimicapp/model.dart';
import 'package:digimicapp/staticclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'component/slide.dart';

class newControlPanel extends StatefulWidget {
  const newControlPanel({super.key});

  @override
  State<newControlPanel> createState() => _newControlPanelState();
}

class _newControlPanelState extends State<newControlPanel> {
  int indexTop = 0;
  double valueBottom = 20;
  TextEditingController _brightnessController =
      TextEditingController(text: '0');
  TextEditingController _xposController = TextEditingController(text: '0');
  TextEditingController _yposController = TextEditingController(text: '0');
  TextEditingController _zposController = TextEditingController(text: '0');

  void _incrementValue(TextEditingController controller, int maxValue) {
    final int currentValue = int.tryParse(controller.text) ?? 0;
    final int newValue = currentValue + Variable.slidervalue;
    if (newValue <= maxValue) {
      controller.text = newValue.toString();
    } else {
      controller.text = maxValue.toString();
    }
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
  }

  void _incrementValueMin(TextEditingController controller, int minValue) {
    final int currentValue = int.tryParse(controller.text) ?? 0;
    final int newValue = currentValue - Variable.slidervalue;
    if (newValue >= minValue) {
      controller.text = newValue.toString();
    } else {
      controller.text = minValue.toString();
    }
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final espDataState = Provider.of<ESPdataState>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SliderLabelWidget(
            indexTop: indexTop,
            onTopSliderChanged: (value) {
              setState(() {
                indexTop = value.toInt();
              });
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _incrementValueMin(_brightnessController, 0);
                  final brightness = int.tryParse(_brightnessController.text);
                  if (brightness != null) {
                    espDataState.updateBrightness(brightness);
                  }
                },
                icon: Icon(Icons.arrow_left),
              ),
              Expanded(
                child: TextField(
                  controller: _brightnessController,
                  onChanged: (newBrightness) {
                    if (newBrightness.trim().isEmpty) {
                      espDataState.updateBrightness(0);
                    } else {
                      final brightness = int.tryParse(newBrightness);
                      if (brightness != null) {
                        espDataState.updateBrightness(brightness);
                      }
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    MaxInputFormatter(255),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Enter Brightness',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _incrementValue(_brightnessController, 255);
                  final brightness = int.tryParse(_brightnessController.text);
                  if (brightness != null) {
                    espDataState.updateBrightness(brightness);
                  }
                },
                icon: Icon(Icons.arrow_right),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _incrementValueMin(_xposController, 0);
                  final xpos = int.tryParse(_xposController.text);
                  if (xpos != null) {
                    espDataState.updateXPos(xpos);
                  }
                },
                icon: Icon(Icons.arrow_left),
              ),
              Expanded(
                child: TextField(
                  controller: _xposController,
                  onChanged: (newXPos) {
                    if (newXPos.trim().isEmpty) {
                      espDataState.updateXPos(0);
                    } else {
                      final xpos = int.tryParse(newXPos);
                      if (xpos != null && xpos <= 6000) {
                        // Pastikan nilai tidak melebihi 6000
                        espDataState.updateXPos(xpos);
                      }
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    MaxInputFormatter(
                        6000), // Buat kustom formatter untuk membatasi maksimum nilai
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Enter X Position',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _incrementValue(_xposController, 6000);
                  final xpos = int.tryParse(_xposController.text);
                  if (xpos != null) {
                    espDataState.updateXPos(xpos);
                  }
                },
                icon: Icon(Icons.arrow_right),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _incrementValueMin(_yposController, 0);
                  final ypos = int.tryParse(_yposController.text);
                  if (ypos != null) {
                    espDataState.updateYPos(ypos);
                  }
                },
                icon: Icon(Icons.arrow_left),
              ),
              Expanded(
                child: TextField(
                  controller: _yposController,
                  onChanged: (newYPos) {
                    if (newYPos.trim().isEmpty) {
                      espDataState.updateYPos(0);
                    } else {
                      final ypos = int.tryParse(newYPos);
                      if (ypos != null) {
                        espDataState.updateYPos(ypos);
                      }
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    MaxInputFormatter(6000),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Enter Y Position',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _incrementValue(_yposController, 6000);
                  final ypos = int.tryParse(_yposController.text);
                  if (ypos != null) {
                    espDataState.updateYPos(ypos);
                  }
                },
                icon: Icon(Icons.arrow_right),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _incrementValueMin(_zposController, 0);
                  final zpos = int.tryParse(_zposController.text);
                  if (zpos != null) {
                    espDataState.updateZPos(zpos);
                  }
                },
                icon: Icon(Icons.arrow_left),
              ),
              Expanded(
                child: TextField(
                  controller: _zposController,
                  onChanged: (newZPos) {
                    if (newZPos.trim().isEmpty) {
                      espDataState.updateZPos(0);
                    } else {
                      final zpos = int.tryParse(newZPos);
                      if (zpos != null) {
                        espDataState.updateZPos(zpos);
                      }
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    MaxInputFormatter(2000),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Enter Z Position',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _incrementValue(_zposController, 6000);
                  final zpos = int.tryParse(_zposController.text);
                  if (zpos != null) {
                    espDataState.updateZPos(zpos);
                  }
                },
                icon: Icon(Icons.arrow_right),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  espDataState.submitValues();
                },
                child: const Text('Submit Value'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _brightnessController.clear();
                  _xposController.clear();
                  _yposController.clear();
                  _zposController.clear();
                  espDataState.resetValue();
                },
                child: const Text('Reset Value'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
