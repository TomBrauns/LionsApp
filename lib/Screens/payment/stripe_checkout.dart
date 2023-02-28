@JS()
library stripe;

import 'package:js/js.dart'
    if (dart.library.io) ''
    if (dart.library.html) 'package:js/js.dart';

void stripeWebCheckout(context, productId) async {
  final stripe = Stripe(
      "pk_test_51Mf6KIGgaqubfEkY4mjPoHhaJCcKIl202B51rY22iMrPKfh4mqNREIT0cBn9EmypeyJ92nC7mJpCwWHg1ZexBY8V00BAEi7S8t");

  stripe.redirectToCheckout(CheckoutOptions(
    lineItems: [LineItem(price: productId, quantity: 1)],
    mode: "payment",
    //TODO: URLs ersetzen durch richtige
    successUrl: "http://localhost:60941/#/Donations/UserType/PayMethode",
    cancelUrl: "http://localhost:60941/#/Donations/UserType/PayMethode",
  ));
}

@JS()
class Stripe {
  external Stripe(String key);

  external redirectToCheckout(CheckoutOptions options);
}

@JS()
@anonymous
class CheckoutOptions {
  external List<LineItem> get lineItems;

  external String get mode;

  external String get successUrl;

  external String get cancelUrl;

  external factory CheckoutOptions({
    List<LineItem> lineItems,
    String mode,
    String successUrl,
    String cancelUrl,
    String sessionId,
  });
}

@JS()
@anonymous
class LineItem {
  external String get price;

  external int get quantity;

  external factory LineItem({String price, int quantity});
}
