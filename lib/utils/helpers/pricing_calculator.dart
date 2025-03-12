class MyPricingCalculator {
  /// Calculates the total price of a product, including tax and shipping costs,
  /// based on the [productPrice] and [location].
  static double calculateTotalPrice(double productPrice, String location) {
    // Get the tax rate for the location and calculate the tax amount.
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    // Get the shipping cost for the location.
    double shippingCost = getShippingCost(location);

    // Calculate the total price by adding product price, tax, and shipping.
    double totalPrice = productPrice + taxAmount + shippingCost;

    return totalPrice;
  }

  /// Calculates and returns the shipping cost based on the product price and [location].
  /// Returns the shipping cost as a formatted string with two decimal places.
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  /// Calculates and returns the tax amount based on the product price and [location].
  /// Returns the tax amount as a formatted string with two decimal places.
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  /// Retrieves the tax rate for the given [location].
  /// This method currently returns a fixed tax rate of 20%.
  static double getTaxRateForLocation(String location) {
    // Example tax rate of 20%
    return 0.20;
  }

  /// Retrieves the shipping cost for the given [location].
  /// This method currently returns a fixed shipping cost of $5.00.
  static double getShippingCost(String location) {
    // Example shipping cost of $5.00
    return 5.00;
  }
}
