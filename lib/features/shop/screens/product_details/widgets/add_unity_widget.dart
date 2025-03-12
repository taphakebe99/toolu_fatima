import 'dart:io'; // Import pour détecter la plateforme

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/product/cart_controller.dart';
import '../../../controllers/unity_controller.dart';

class AddUnity extends StatelessWidget {
  final String unit;
  final CartController controller = CartController.instance;

  // Le constructeur initialise la valeur par défaut de "unit" dans le contrôleur.
  AddUnity({super.key, required this.unit}) {
    controller.unit.value = unit;
  }

  /// Génère le DropdownButtonFormField pour Android
  Widget androidDropdown() {
    final unitController = Get.put(UnityController());
    final List unitsList = unitController.allUnities;
    return Obx(() {
      return Expanded(
        child: DropdownButtonFormField<String>(
          value: controller.unit.value,
          decoration: InputDecoration(
            labelText: 'Unité',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: unitsList.map<DropdownMenuItem<String>>((unitItem) {
            return DropdownMenuItem<String>(
              value: unitItem.unity,
              child: Text(unitItem.unity),
            );
          }).toList(),
          onChanged: (value) {
            controller.unit.value = value!;
          },
        ),
      );
    });
  }

  /// Génère le CupertinoPicker pour iOS avec un label et une boîte stylisée
  Widget iOSPicker() {
    final unitController = Get.put(UnityController());
    final List unitsList = unitController.allUnities;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bouton qui ouvre le picker
        GestureDetector(
          onTap: () {
            showCupertinoModalPopup(
              context: Get.context!,
              builder: (context) {
                return Container(
                  height: 300,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: CupertinoPicker(
                          backgroundColor: Colors.white,
                          itemExtent: 32.0,
                          onSelectedItemChanged: (index) {
                            controller.unit.value = unitsList[index].unity;
                          },
                          children: unitsList
                              .map<Widget>((unitItem) => Text(unitItem.unity))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(
                      controller.unit.value,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    )),
                const Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Retourne le widget adapté en fonction de la plateforme
    return Platform.isIOS ? iOSPicker() : androidDropdown();
  }
}
