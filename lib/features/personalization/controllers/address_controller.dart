import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/texts/section_heading.dart';
import '../../../data/repositories/address/address_repository.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../models/address_model.dart';
import '../screens/address/add_new_address.dart';
import '../screens/address/widgets/single_address.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  /// Fetch all user specific addresses
  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      MyLoaders.errorSnackBar(
          title: 'Adresse non trouvée', message: e.toString());
      return [];
    }
  }

  Future selectAddress({required AddressModel newSelectedAddress}) async {
    try {
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            AuthenticationRepository.instance.getUserID,
            selectedAddress.value.id,
            false);
      }

      // Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the "selected" field to true for the newly selected address
      await addressRepository.updateSelectedField(
          AuthenticationRepository.instance.getUserID,
          selectedAddress.value.id,
          true);
    } catch (e) {
      MyLoaders.errorSnackBar(
          title: 'Erreur de sélection', message: e.toString());
    }
  }

  /// Add new Address
  addNewAddresses() async {
    try {
      // Start Loading
      MyFullScreenLoader.openLoadingDialog(
          'Enregistrement de l\'adresse...', MyImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        MyFullScreenLoader.stopLoading();
        return;
      }

      // Save Address Data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(
          address, AuthenticationRepository.instance.getUserID);

      // Update Selected Address status
      address.id = id;
      await selectAddress(newSelectedAddress: address);

      // Remove Loader
      MyFullScreenLoader.stopLoading();

      // Show Success Message
      MyLoaders.successSnackBar(
          title: 'Félicitations',
          message: 'Votre adresse a été enregistrée avec succès.');

      // Refresh Addresses Data
      refreshData.toggle();

      // Reset fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // Remove Loader
      MyFullScreenLoader.stopLoading();
      MyLoaders.errorSnackBar(
          title: 'Adresse non trouvée', message: e.toString());
    }
  }

  /// Show Addresses ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup({required BuildContext context}) {
    // If shipping Address is true that means do not show any selected Address but let the user choose his new Shipping address
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(MySizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MySectionHeading(
                  title: 'Nouvelle Address', showActionButton: false),
              const SizedBox(height: MySizes.spaceBtwItems),
              FutureBuilder(
                future: allUserAddresses(),
                builder: (_, snapshot) {
                  /// Helper Function: Handle Loader, No Record, OR ERROR Message
                  final response = MyCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot);
                  if (response != null) return response;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => SingleAddress(
                      address: snapshot.data![index],
                      onTap: () async {
                        await selectAddress(
                          newSelectedAddress: snapshot.data![index],
                        );
                        Get.back();
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: MySizes.defaultSpace),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(MyColors.primary),
                    ),
                    onPressed: () => Get.to(() => const AddNewAddressScreen()),
                    child: const Text('Ajouter nouvelle adresse')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// INIT Values to text fields
  initUpdateAddressValues(AddressModel address) {
    name.text = address.name;
    phoneNumber.text = address.phoneNumber;
  }

  /// Update Address
  updateAddress(AddressModel oldAddress) async {
    try {
      // Start Loading
      MyFullScreenLoader.openLoadingDialog(
          'Mise à jour de votre adresse...', MyImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        MyFullScreenLoader.stopLoading();
        return;
      }

      // Save Address Data
      final address = AddressModel(
        id: oldAddress.id,
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        selectedAddress: oldAddress.selectedAddress,
      );
      await addressRepository.updateAddress(
          address, AuthenticationRepository.instance.getUserID);

      // Remove Loader
      MyFullScreenLoader.stopLoading();

      // Show Success Message
      MyLoaders.successSnackBar(
          title: 'Félicitations',
          message: 'Votre adresse a été mise à jour avec succès.');

      // Refresh Addresses Data
      refreshData.toggle();

      // Reset fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // Remove Loader
      MyFullScreenLoader.stopLoading();
      MyLoaders.errorSnackBar(
          title: 'Erreur de mise à jour de l\'adresse', message: e.toString());
    }
  }

  /// Function to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    addressFormKey.currentState?.reset();
  }

  Future<void> deleteAddress(String addressId) async {
    try {
      // Afficher le loader
      MyFullScreenLoader.openLoadingDialog(
          'Suppression de l\'adresse...', MyImages.docerAnimation);

      // Vérifier la connexion Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyFullScreenLoader.stopLoading();
        return;
      }

      // Supprimer l'adresse de Firebase
      await addressRepository.deleteAddress(
          AuthenticationRepository.instance.getUserID, addressId);

      // Fermer le loader
      MyFullScreenLoader.stopLoading();

      // Afficher un message de succès
      MyLoaders.successSnackBar(
          title: 'Adresse supprimée',
          message: 'L\'adresse a été supprimée avec succès.');

      // Rafraîchir les données
      refreshData.toggle();
    } catch (e) {
      MyFullScreenLoader.stopLoading();
      MyLoaders.errorSnackBar(
          title: 'Erreur de suppression', message: e.toString());
    }
  }
}
