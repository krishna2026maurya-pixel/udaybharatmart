import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uday_bharat/user_screen/provider/view_model/home_provider.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/session.dart';

import '../repository/payment_repo.dart';
import 'cart_local_provider.dart';
import 'cart_view_model.dart';
import '../model/user_tr_model.dart';

class PaymentProvider with ChangeNotifier {
  late Razorpay _razorpay;
  late BuildContext _appContext;
  final _myRepo = PaymentRepository();

  bool isLoading = false;

  UserTrModel getTrRes = UserTrModel();

  /// Track what type of payment is running
  String _paymentFor = "ORDER"; // OR "WALLET"
  String _walletAmount = "0";
  String _addressId = "";
  String _couponCode = "";
  String _deliveryCharge = "";
  String _discountValue = "";
  String _netGrandTotal = "";
  String _transactionId = "";
  String _walletAppliedAmount = "";
  String _isSchedule = "";
  String _scheduledAt = "";

  void init() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  // ============================================================
  //  ORDER PAYMENT
  // ============================================================
  void openCheckout({
    required BuildContext context,
    required String amount,
    required String name,
    required String number,
    required String addressId,
    required String couponCode,
    required String deliveryCharge,
    required String discountValue,
    required String netGrandTotal,
    String? transactionId,
    required String walletAppliedAmount,
    required String isSchedule,
    required String scheduledAt,
  }) {
    _paymentFor = "ORDER";

    // 👉 Store values for later use
    _addressId = addressId;
    _couponCode = couponCode;
    _deliveryCharge = deliveryCharge;
    _discountValue = discountValue;
    _netGrandTotal = netGrandTotal;
    _transactionId = transactionId ?? '';
    _walletAppliedAmount = walletAppliedAmount;
    _isSchedule = isSchedule;
    _scheduledAt = scheduledAt;


    _openRazorpay(
      amount: amount,
      name: name,
      number: number,
      couponCode: couponCode,
      deliveryCharge: deliveryCharge,
      discountValue: discountValue,
      netGrandTotal: netGrandTotal,
      transactionId: transactionId ?? '',
      razorpayOrderId: '',
      walletAppliedAmount: walletAppliedAmount,
      context: context,
    );
  }


  // ============================================================
  //  ADD MONEY TO WALLET
  // ============================================================
  void addWalletAmountRazorPay({
    required BuildContext context,
    required String amount,
    required String name,
    required String number,
  }) {
    _paymentFor = "WALLET";
    _walletAmount = amount;

    _openRazorpay(
      amount: amount,
      name: name,
      number: number,
      couponCode:'' ,
      deliveryCharge: '',
      discountValue: '',
      netGrandTotal: '',
      transactionId: '',
      walletAppliedAmount: '',
      razorpayOrderId: '',
      context: context,
    );
  }

  // ============================================================
  //  COMMON RAZORPAY OPEN METHOD
  // ============================================================
  void _openRazorpay({
    required String amount, // ignore this for payment
    required String name,
    required String number,
    required String couponCode,
    required String deliveryCharge,
    required String discountValue,
    required String netGrandTotal, // ✅ USE THIS
    required String transactionId,
    required String razorpayOrderId,
    required String walletAppliedAmount,
    required BuildContext context,
  }) {
    final profile =
        Provider.of<HomeProvider>(context, listen: false).usrProfileRes;

    // ✅ ALWAYS use netGrandTotal for Razorpay
    final double finalAmount =
        double.tryParse(netGrandTotal) ?? 0;

    final int razorpayAmount = (finalAmount * 100).round();

    debugPrint("RAZORPAY AMOUNT (PAISE): $razorpayAmount");
    debugPrint("RAZORPAY AMOUNT (RUPEE): $finalAmount");

    var options = {
      "key": profile.razerpayKey.toString(),
      "amount": razorpayAmount,
      "currency": "INR",
      "name": name,
      "prefill": {
        "contact": number,
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Razorpay Error: $e");
    }

    _appContext = context;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    debugPrint("✅ Payment Success: ${response.paymentId}");
    debugPrint("✅ Payment orderId: ${response.orderId}");
    if (_paymentFor == "ORDER") {
      final cart = _appContext.read<CartViewModel>();
      cart.createBookingApi(
        _appContext,
        userAddressId: _addressId,
        paymentMethod:"Online",
        couponCode: _couponCode,
        deliveryCharge: _deliveryCharge,
        discountValue: _discountValue,
        netGrandTotal: _netGrandTotal,
        transactionId: response.paymentId.toString(),
        walletAppliedAmount: _walletAppliedAmount,
        scheduledAt: _scheduledAt,
        isSchedule: _isSchedule
      );
      _showSuccessMessage("Order placed successfully!");
    }
    else {
    }
  }


  // ============================================================
  //  PAYMENT FAILED
  // ============================================================
  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("❌ Payment Failed: ${response.message}");
    ScaffoldMessenger.of(_appContext).showSnackBar(
      const SnackBar(
        content: CustomText("Payment Failed! Please try again."),
        backgroundColor: Colors.red,
      ),
    );
  }

  // ============================================================
  //  EXTERNAL WALLET
  // ============================================================
  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("📦 External Wallet Selected: ${response.walletName}");
  }

  // ============================================================
  //  SHOW SUCCESS MESSAGE
  // ============================================================
  void _showSuccessMessage(String msg) {
    ScaffoldMessenger.of(_appContext).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  // ============================================================
  //  GET USER TRANSACTIONS
  // ============================================================
  Future<void> getWalletTransactionApi() async {
    isLoading = true;
    notifyListeners();

    final userId = await MySharedPreferences.getUserId();

    try {
      getTrRes =
      await _myRepo.getWalletTransactionRepo({"user_id": userId});
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTransactionApi({dynamic?data}) async {
    isLoading = true;
    notifyListeners();
    try {
      await _myRepo.createTransactionRepo(data
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
