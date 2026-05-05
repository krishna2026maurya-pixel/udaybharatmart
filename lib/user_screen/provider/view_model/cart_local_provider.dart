import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import 'cart_view_model.dart';

class CartLocalProvider extends ChangeNotifier {
  final cartBox = Hive.box('cartBox');
  final queueBox = Hive.box('queueBox');
  final addedItemsBox = Hive.box('addedItemsBox');

  int get grandTotalAmount {
    int total = 0;

    for (var key in cartBox.keys) {
      final item = Map<String, dynamic>.from(cartBox.get(key));

      int qty = item["qty"] ?? 0;
      int sellingPrice = item["sellingPrice"] ?? 0;

      total += qty * sellingPrice;
    }

    return total;
  }

  int get totalSavedAmount {
    int total = 0;

    for (var key in cartBox.keys) {
      final item = Map<String, dynamic>.from(cartBox.get(key));

      int qty = item["qty"] ?? 0;
      int saved = item["cartSavedAmount"] ?? 0;

      total += qty * saved;
    }

    return total;
  }
  int apiTotalAmount = 0;

  void updateApiTotal(int amt) {
    apiTotalAmount = amt;
    notifyListeners();
  }


  int getQty(String productId) {
    // print('getQtyById----->${productId}');
    return cartBox.get(productId, defaultValue: {"qty": 0})["qty"];
  }

  int get totalQty {
    int sum = 0;
    for (var key in cartBox.keys) {
      sum += cartBox.get(key)["qty"] as int;
    }
    return sum;
  }

  void setTotalFromApi(Map<String, dynamic> apiCartData) {

    for (var item in apiCartData["cart_items"] ?? []) {

      String productId = item["product_id"].toString();

      int qty = int.tryParse(item["qty"].toString()) ?? 0;
      int sellingPrice = int.tryParse(item["selling_price"].toString()) ?? 0;
      int mrp = int.tryParse(item["mrp"].toString()) ?? 0;

      if (qty > 0) {
        cartBox.put(productId, {
          "qty": qty,
          "sellingPrice": sellingPrice,
          "mrp": mrp,
          "cartSavedAmount": mrp - sellingPrice
        });
      }
    }

    notifyListeners();
  }


  void clearCart() {
    cartBox.clear();      // remove all items from cart
    queueBox.clear();     // clear pending queue
    // addedItemsBox.clear();   // uncomment if you want to clear history also
    notifyListeners();
  }

  void updateLocal(
      String productId,
      int qty,
      int sellingPrice,
      int mrp,
      ) {
    if (qty <= 0) {
      cartBox.delete(productId);
    } else {

      cartBox.put(productId, {
        "qty": qty,
        "sellingPrice": sellingPrice,
        "mrp": mrp,
        "cartSavedAmount": mrp - sellingPrice
      });
      print("LOCAL SAVE -> price:$sellingPrice mrp:$mrp qty:$qty");

    }
    notifyListeners();
  }

  // void addToQueue(String productId, String type, String status) {
  //   queueBox.add({
  //     "product_id": productId,
  //     "type": type,
  //     "status": status
  //   });
  //
  //   processQueue();
  // }


  void addToQueue(String productId, String type, String status) {
    final task = {
      "product_id": productId,
      "type": type,
      "status": status,
      "timestamp": DateTime.now().toString(),
    };

    // Store into queue for processing
    queueBox.add(task);

    // ALSO store complete history
    addedItemsBox.add(task);

    processQueue();
  }


  List<Map> getAddedHistory() {
    return addedItemsBox.values.map((e) => Map.from(e)).toList();
  }

// inside CartLocalProvider class
  int getQuantityOf(String productId) {
    return getQty(productId);
  }

  bool isProcessing = false;

  void processQueue() async {
    if (isProcessing) return;
    isProcessing = true;

    while (queueBox.isNotEmpty) {
      final task = queueBox.getAt(0);

      try {
        // ⬇️ Context removed — now global navigator key used
        final context = navigatorKey.currentContext!;
        final cartVM = Provider.of<CartViewModel>(context, listen: false);

        await cartVM.addRemoveCartApi(
          context,
          productId: task["product_id"],
          type: task["type"],
          status: task["status"],
        );

        queueBox.deleteAt(0);
      } catch (e) {
        print("Queue Error: $e");
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    isProcessing = false;
  }
}
