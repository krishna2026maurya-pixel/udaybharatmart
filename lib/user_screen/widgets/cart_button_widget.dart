import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/auth/login.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/session.dart';
import 'package:uday_bharat/utils/size.dart';
import '../provider/view_model/cart_local_provider.dart';





class AddToCartWidget extends StatefulWidget {
  final String productId;
  final String itemImage;
  final String? status;
  final String? stockStatus;
  final int value;
  final Function(String image)? onCartChanged;
  final int? sellingPrice;
  final int? mrp;

  const AddToCartWidget({
    super.key,
    required this.productId,
    required this.itemImage,
    required this.value,
    this.onCartChanged,
    this.stockStatus,
    this.status,
    this.mrp,
    this.sellingPrice
  });

  @override
  State<AddToCartWidget> createState() => _AddToCartWidgetState();
}

class _AddToCartWidgetState extends State<AddToCartWidget> {
  late int counter;

  @override
  void initState() {
    super.initState();

    final local = Provider.of<CartLocalProvider>(context, listen: false);
    int localQty = local.getQuantityOf(widget.productId);

    if (localQty != 0) {
      counter = localQty;
    } else {
      counter = widget.value;
      if (widget.value > 0) {
        local.updateLocal(
          widget.productId,
          counter,
          widget.sellingPrice ?? 0,
          widget.mrp ?? 0,
        );
      }
    }

  }

  CartLocalProvider local(context) =>
      Provider.of<CartLocalProvider>(context, listen: false);

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _increment() async {
    int stock = int.tryParse(widget.stockStatus ?? "0") ?? 0;
    int maxLimit = stock < 5 ? stock : 5;

    if (stock == 0) {
      _showSnack("Item is out of stock!");
      return;
    }

    if (counter >= maxLimit) {
      _showSnack("You can add maximum $maxLimit item(s) of this product.");
      return;
    }

    setState(() => counter++);
    local(context).updateLocal(
      widget.productId,
      counter,
      widget.sellingPrice??0,
      widget.mrp??0,
    );

    local(context).addToQueue(widget.productId, "plus", widget.status ?? "");
    widget.onCartChanged?.call(widget.itemImage);
  }

  Future<void> _decrement() async {
    if (counter > 0) {
      setState(() => counter--);
      local(context).updateLocal(
        widget.productId,
        counter,
        widget.sellingPrice??0,
        widget.mrp??0,
      );

      local(context).addToQueue(widget.productId, "minus", widget.status ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);

    int stock = int.tryParse(widget.stockStatus ?? "0") ?? 0;
    int maxLimit = stock < 5 ? stock : 5;

    return Consumer<CartLocalProvider>(
      builder: (context, cart, child) {
        counter = cart.getQuantityOf(widget.productId);

        /// ------------------ ADD BUTTON ------------------
        if (counter == 0) {
          return stock == 0
              ? Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomText(
                  'OUT OF STOCK',
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
              : GestureDetector(
            onTap: () async {
              final userId = await MySharedPreferences.getUserId();
              if (userId == '' || userId == null) {
                showLoginPrompt(context);
              } else {
                if (stock == 0) {
                  _showSnack("Item is out of stock!");
                } else {
                  _increment();
                }
              }
            },
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [Color(0xFF32CD32), Color(0xFF228B22)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.4),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const CustomText(
                "ADD",
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          );
        }

        /// ------------------ COUNTER UI ------------------
        return Container(
          width: fontSize.w / 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// MINUS BUTTON
              InkWell(
                onTap: _decrement,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.remove,
                    size: 18,
                    color: Colors.green,
                  ),
                ),
              ),

              /// COUNTER
              CustomText(
                "$counter",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),

              /// PLUS BUTTON
              InkWell(
                onTap: counter >= maxLimit ? null : _increment,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: counter >= maxLimit
                        ? Colors.grey.withOpacity(0.2)
                        : Colors.green.withOpacity(0.2),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 18,
                    color: counter >= maxLimit ? Colors.grey : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}





void showLoginPrompt(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.lock_outline,
              size: 40,
              color: Colors.orange,
            ),
            const SizedBox(height: 15),
            const CustomText(
              'Login Required',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            const CustomText(
              'Please log in to add items to your cart.',
              textAlign: TextAlign.center,
              fontSize: 15,
              color: Colors.black54,
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade400),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const CustomText(
                      'Cancel',
                        color: Colors.black87, fontSize: 16
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const CustomText(
                      'Login',
                        color: Colors.white, fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}



void showCustomSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 8,
      backgroundColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      duration: const Duration(seconds: 2),
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomText(
              message,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}
