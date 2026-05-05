import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';

import '../../../user_screen/provider/view_model/category_view_model.dart';
import '../../vendor_provider/view_model/product_view_model.dart';

class ProductLabelSelector extends StatefulWidget {
  final Function(String) onChanged;
  final String? initialValue;

  const ProductLabelSelector({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<ProductLabelSelector> createState() => _ProductLabelSelectorState();
}

class _ProductLabelSelectorState extends State<ProductLabelSelector> {
  String? _selectedLabel;
  bool _apiValueApplied = false;

  @override
  void initState() {
    super.initState();
    _selectedLabel = widget.initialValue;  // static default value
  }

  void _onSelect(String label) {
    setState(() {
      if (_selectedLabel == label) {
        _selectedLabel = null;
      } else {
        _selectedLabel = label;
      }
    });
    widget.onChanged(_selectedLabel ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, provider, child) {

        /// 👇 API value sirf ek baar set hogi
        if (!_apiValueApplied && provider.getAddedItemDetailRes.data != null) {
          final apiValue = provider.getAddedItemDetailRes.data?.productLabel;
          if (apiValue != null && apiValue.isNotEmpty) {
            _selectedLabel = apiValue;
          }
          _apiValueApplied = true;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const CustomText(
              "Product Label",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),

            // ----- Inclusive -----
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CheckboxListTile(
                activeColor: AppColors.appColor,
                checkboxShape: const CircleBorder(),
                title: CustomText("Inclusive of all taxes", color: Colors.grey),
                value: _selectedLabel == "Inclusive of all taxes",
                onChanged: (_) => _onSelect("Inclusive of all taxes"),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),

            const SizedBox(height: 10),

            // ----- Exclusive -----
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CheckboxListTile(
                checkboxShape: const CircleBorder(),
                activeColor: AppColors.appColor,
                title: CustomText("Exclusive of all taxes", color: Colors.grey),
                value: _selectedLabel == "Exclusive of all taxes",
                onChanged: (_) => _onSelect("Exclusive of all taxes"),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          ],
        );
      },
    );
  }
}

