import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../popups/loaders.dart';

class NetworkManager extends GetxController {
  // Singleton pour accéder à l'instance unique de NetworkManager
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  // Statut de la connexion réseau
  final RxList<ConnectivityResult> _connectionStatus = <ConnectivityResult>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Écoute les changements de connectivité
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Met à jour le statut de la connexion réseau
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus.value = result;

    // Affiche une notification si aucune connexion n'est disponible
    if (result.contains(ConnectivityResult.none)) {
      MyLoaders.warningSnackBar(title: 'Pas de connexion internet');
    }
  }

  /// Vérifie si l'appareil est actuellement connecté à Internet
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();

      if(result.any((element) => element == ConnectivityResult.none)){
        return false;
      }else {
        return true;
      }

    } on PlatformException catch (e) {
      // Vous pouvez loguer l'erreur si nécessaire
      print('Erreur lors de la vérification de la connectivité : $e');
      return false;
    }
  }

  @override
  void onClose() {
    // Annule l'abonnement au flux de connectivité pour éviter les fuites de mémoire
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
