import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:uday_bharat/user_screen/provider/model/order_detail_model.dart';

// ================= MAIN PDF FUNCTION =================

Future<void> generateInvoicePdf(Data order) async {
  final pdf = pw.Document();

  final logo = await imageFromAssetBundle('assets/appstore-modified.png');
  final signature = await imageFromAssetBundle('assets/pdf_signature.png');

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(12),

      build: (context) {
        return pw.Column(
          children: [
            // ================= HEADER =================
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  children: [
                    pw.Image(logo, height: 40),
                    pw.SizedBox(width: 10),
                    pw.Text(
                      "ZiplyMart",
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                pw.Text(
                  "TAX INVOICE",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            pw.Divider(),

            // ================= SELLER + META =================
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  flex: 3,
                  child: blockBox([
                    boldRow("Sold By :", "Ziplymart"),
                    normalRow("Address :", "Varanasi, Uttar Pradesh"),
                    normalRow("GSTIN :", "09AQJPY0123D1ZX"),
                    normalRow("FSSAI :", "22725630000543"),
                    normalRow("Email :", "info.ziplymart.vns@gmail.com"),
                  ]),
                ),

                pw.SizedBox(width: 10),

                pw.Expanded(
                  flex: 2,
                  child: blockBox([
                    normalRow("Invoice No :", order.orderNumber ?? ""),
                    normalRow("Order ID :", order.orderId.toString()),
                    normalRow("Invoice Date :", order.createdAt ?? ""),
                    normalRow("Payment :", order.paymentMethod ?? ""),
                    normalRow("Status :", order.paymentStatus ?? ""),
                    normalRow("Place Of Supply :", "Varanasi, Uttar Pradesh"),
                  ]),
                ),
              ],
            ),

            pw.SizedBox(height: 10),

            // ================= CUSTOMER =================
            blockBox([
              boldRow("Invoice To :", order.shippingAddress?.name ?? ""),
              normalRow("Mobile :", order.shippingAddress?.mobileNo ?? ""),
              normalRow("Address :", order.shippingAddress?.gpsAddress ?? ""),
              // normalRow("State :", "Gujrat"),
            ]),

            pw.SizedBox(height: 10),

            // ================= ITEM TABLE =================
            pw.Table.fromTextArray(
              border: pw.TableBorder.all(),

              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 9,
              ),

              cellStyle: const pw.TextStyle(fontSize: 9),

              headers: [
                "Sr",
                "Item",
                "Qty",
                "MRP",
                "Discount",
                "Rate",
                "Total",
              ],

              data: List.generate(order.orderItems!.length, (index) {
                final item = order.orderItems![index];

                final price =
                    double.tryParse(item.sellingPrice.toString()) ?? 0;

                final qty = int.tryParse(item.quantity.toString()) ?? 1;

                // ✅ SAFE MRP parse
                final mrp = double.tryParse(item.mrp?.toString() ?? "0") ?? 0;

                // TOTAL
                final total = price * qty;

                // ✅ Correct discount formula
                final discount = mrp - price;

                return [
                  "${index + 1}",
                  item.productName ?? "",
                  qty.toString(),
                  formatAmount(mrp), // ✅ REAL MRP
                  formatAmount(discount), // ✅ REAL DISCOUNT
                  formatAmount(price),
                  formatAmount(total),
                ];
              }),
            ),
            pw.SizedBox(height: 10),
            // ================= TOTAL =================
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Container(
                width: 260,
                child: pw.Column(
                  children: [
                    totalRow("Subtotal", order.subtotalAmount),
                    if (double.tryParse(order.deliveryCharge.toString()) != 0)
                      totalRow("Delivery Charge", order.deliveryCharge),
                    pw.Divider(),
                    totalRow("Grand Total", order.totalAmount, bold: true),
                    pw.SizedBox(height: 5),
                    pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        "Total Items: ${order.orderItems?.length ?? 0}",
                        style: pw.TextStyle(
                          fontSize: 8,
                          fontStyle: pw.FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // pw.SizedBox(height: 10),
            //
            // pw.Text(
            //   "Amount In Words : Rupees ${order.totalAmount} Only",
            //   style: pw.TextStyle(fontSize: 10),
            // ),
            pw.SizedBox(height: 15),

            // ================= FOOTER =================
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Ziplymart",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text("FSSAI: 22725630000543"),
                    pw.Text("GSTIN: 09AQJPY0123D1ZX"),
                  ],
                ),

                pw.Column(
                  children: [
                    pw.Text("For Ziplymart"),
                    pw.SizedBox(height: 30),
                    pw.Image(signature, height: 40),
                    pw.Text("Authorised Signatory"),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Divider(),
            pw.Text(
              "Terms & Conditions:\n"
              "1. If you have any issues or queries in respect of your order, please contact customer chat support through the ZiplyMart platform or drop in email at : info.ziplymart.vns@gmail.com.\n"
              "2. Please note that we never ask for bank account details such as CVV, account number, UPI Pin, etc. across our support channels. For your safety please do not share these details with anyone over any medium. \n",
              style: pw.TextStyle(fontSize: 8),
              textAlign: pw.TextAlign.left,
            ),
          ],
        );
      },
    ),
  );

  final dir = await getApplicationDocumentsDirectory();
  final filePath = "${dir.path}/invoice_${order.orderNumber}.pdf";
  final file = File(filePath);

  await file.writeAsBytes(await pdf.save());

  await OpenFilex.open(filePath);
}

// ================= HELPER FUNCTIONS =================

pw.Widget blockBox(List<pw.Widget> children) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(8),
    decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black)),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: children,
    ),
  );
}

pw.Widget normalRow(String title, String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 2),
    child: pw.Row(
      children: [
        pw.Text(title, style: const pw.TextStyle(fontSize: 9)),
        pw.SizedBox(width: 5),
        pw.Expanded(
          child: pw.Text(value, style: const pw.TextStyle(fontSize: 9)),
        ),
      ],
    ),
  );
}

pw.Widget boldRow(String title, String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 2),
    child: pw.Row(
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(width: 5),
        pw.Expanded(
          child: pw.Text(
            value,
            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

pw.Widget totalRow(String title, dynamic value, {bool bold = false}) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Text(
        title,
        style: pw.TextStyle(
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
      pw.Text(
        formatAmount(value),
        style: pw.TextStyle(
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    ],
  );
}

String formatAmount(dynamic amount) {
  double val = double.tryParse(amount.toString()) ?? 0;
  return "${val.toStringAsFixed(2)}";
}
