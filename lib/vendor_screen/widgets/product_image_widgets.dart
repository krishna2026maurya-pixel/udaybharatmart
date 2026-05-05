import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/product_view_model.dart';
class ProductImagesWidget extends StatefulWidget {
  const ProductImagesWidget({super.key});

  @override
  State<ProductImagesWidget> createState() => _ProductImagesWidgetState();
}

class _ProductImagesWidgetState extends State<ProductImagesWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, provider, child) {

        // Existing API images (URLs)
       /* final List<String> apiImages =
            (provider.getAddedItemDetailRes?.data?.productImages as List?)
                ?.map((e) => e.toString())
                .toList()
                ?? [];*/


        // New picked images (Files)
        final List<File> pickedImages = provider.productImages;

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [

            // ================================
            // 1️⃣ SHOW EXISTING API IMAGES
            // ================================
            if(provider.setProductImage != null)
            Image.network(provider.setProductImage??'',height: 80,width: 80,fit: BoxFit.cover),
            // ...apiImages.asMap().entries.map((entry) {
            //   final index = entry.key;
            //   final imageUrl = entry.value;
            //
            //   return Stack(
            //     children: [
            //       ClipRRect(
            //         borderRadius: BorderRadius.circular(8),
            //         child: Image.network(
            //           imageUrl,
            //           width: 80,
            //           height: 80,
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //
            //       // DELETE BUTTON FOR API IMAGE
            //       // Positioned(
            //       //   right: -8,
            //       //   top: -8,
            //       //   child: IconButton(
            //       //     icon: const Icon(Icons.cancel, color: Colors.red),
            //       //     onPressed: () {
            //       //       provider.removeApiImage(index); // Implement this
            //       //     },
            //       //   ),
            //       // ),
            //     ],
            //   );
            // }).toList(),

            // ================================
            // 2️⃣ SHOW NEWLY PICKED IMAGES
            // ================================
            ...pickedImages.asMap().entries.map((entry) {
              final index = entry.key;
              final File image = entry.value;

              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // DELETE BUTTON
                  Positioned(
                    right: -8,
                    top: -8,
                    child: IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        provider.removePickedImage(index);
                      },
                    ),
                  ),
                ],
              );
            }).toList(),

            // ================================
            // 3️⃣ ADD IMAGE (Both Add/Update)
            // ================================
            GestureDetector(
              onTap: provider.pickImages,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        );
      },
    );
  }
}
