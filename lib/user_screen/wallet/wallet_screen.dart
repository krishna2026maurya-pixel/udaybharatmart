import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/provider/view_model/payment_provider.dart';
import 'package:uday_bharat/utils/cutom_text.dart';

class UserWalletScreen extends StatefulWidget {
  const UserWalletScreen({super.key});
  @override
  State<UserWalletScreen> createState() => _UserWalletScreenState();
}
class _UserWalletScreenState extends State<UserWalletScreen> {
  double walletBalance = 450.00;
@override
  void initState() {
    super.initState();
    Provider.of<PaymentProvider>(context,listen: false).getWalletTransactionApi();
  }
  int selectedAmount = 0;
  final List<int> quickAmounts = [100, 200, 300, 500, 1000];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          "My Wallet",
            fontWeight: FontWeight.w600
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),

      body: Consumer<PaymentProvider>(builder: (context, provider, child) {
        final getTr =  provider.getTrRes;
        return  provider.isLoading?Center(child: CircularProgressIndicator()) :
        Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        const CustomText(
                          "Wallet Balance",
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        const SizedBox(height: 6),
                        CustomText(
                          "₹${getTr.walletBalance??'0'}",
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ],),
                      Image.asset('assets/coin.png',height: 100,width: 100,fit: BoxFit.cover),
                    ],),
                  //
                  // const SizedBox(height: 12),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //
                  //
                  //     Wrap(
                  //       spacing: 10,
                  //       runSpacing: 10,
                  //       children: quickAmounts.map((amount) {
                  //         final bool isSelected = selectedAmount == amount;
                  //         return GestureDetector(
                  //           onTap: () {
                  //             setState(() {
                  //               selectedAmount = isSelected ? 0 : amount;
                  //             });
                  //           },
                  //           child: AnimatedContainer(
                  //             duration: const Duration(milliseconds: 200),
                  //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  //             decoration: BoxDecoration(
                  //               color: isSelected ? Colors.green.shade700 : Colors.white,
                  //               border: Border.all(
                  //                 color: isSelected ? Colors.green.shade700 : Colors.grey.shade300,
                  //               ),
                  //               borderRadius: BorderRadius.circular(10),
                  //               boxShadow: isSelected
                  //                   ? [
                  //                 BoxShadow(
                  //                   color: Colors.green.withOpacity(0.3),
                  //                   blurRadius: 10,
                  //                   spreadRadius: 1,
                  //                 )
                  //               ]
                  //                   : [],
                  //             ),
                  //             child: Text(
                  //               "₹$amount",
                  //               style: TextStyle(
                  //                 color: isSelected ? Colors.white : Colors.black,
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       }).toList(),
                  //     ),
                  //     const SizedBox(height: 10),
                  //     ElevatedButton.icon(
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: Colors.white,
                  //         foregroundColor: Colors.green.shade700,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //       ),
                  //       onPressed: () {
                  //         print("Selected Amount: ₹$selectedAmount");
                  //         if(selectedAmount!=0){
                  //           Provider.of<PaymentProvider>(context,listen: false).
                  //           addWalletAmountRazorPay(
                  //               amount: selectedAmount.toString(),
                  //               context: context,
                  //               name: 'krishna',
                  //               number: '8423485660 '
                  //           );
                  //         }
                  //
                  //       },
                  //       icon: const Icon(Iconsax.add),
                  //       label: const CustomText("Add Money"),
                  //     ),
                  //
                  //   ],
                  // )

                ],
              ),
            ),
            // Section Title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              alignment: Alignment.centerLeft,
              child: const CustomText(
                "Recent Transactions",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            // Transaction List
            Expanded(
              child: (getTr.userTransactionList==null||getTr.userTransactionList!.isEmpty)
                  ? _buildEmptyState()
                  : ListView.builder(
                itemCount: getTr.userTransactionList?.length??0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final tx = getTr.userTransactionList?[index];
                  final isCredit = tx?.operationType == 'credit';
                  return Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: isCredit
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          child: Icon(
                            isCredit ? Iconsax.arrow_down : Iconsax.arrow_up,
                            color: isCredit ? Colors.green : Colors.red,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  tx?.remark??"",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600
                              ),
                              const SizedBox(height: 2),
                              CustomText(
                                formatDate(tx?.createdAt ?? ''),
                                color: Colors.grey,
                                fontSize: 12,
                              ),

                            ],
                          ),
                        ),
                        CustomText(
                          tx?.amt??'',
                          color: isCredit ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },)
    );
  }
  String formatDate(String dateString) {
    if (dateString.isEmpty) return "";
    DateTime date = DateTime.parse(dateString);
    return DateFormat("d MMM yyyy : HH:mm").format(date);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.wallet, size: 60, color: Colors.grey.shade400),
          const SizedBox(height: 10),
          const CustomText(
            "No transactions yet",
            fontSize: 16, fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 6),
          CustomText(
            "Your transaction history will appear here",
              color: Colors.grey.shade500
          ),
        ],
      ),
    );
  }
}
