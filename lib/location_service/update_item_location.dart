import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import '../user_screen/provider/view_model/home_provider.dart';
import 'location_provider.dart';
class SelectLocationBottomSheet extends StatefulWidget {
  const SelectLocationBottomSheet({super.key});
  @override
  State<SelectLocationBottomSheet> createState() => _SelectLocationBottomSheetState();
}
class _SelectLocationBottomSheetState extends State<SelectLocationBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<LocationProvider>(builder: (context, provider, child) {
        return Padding(
          padding:
          const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 25),
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
              const SizedBox(height: 15),
              // 🔍 Search Bar
            Focus(
              onKeyEvent: (node, event) {
                if (event.logicalKey.keyId == LogicalKeyboardKey.backspace.keyId &&
                    event is KeyDownEvent) {
                  if (_searchController.text.isNotEmpty) {
                    _searchController.text =
                        _searchController.text.substring(0, _searchController.text.length - 1);

                    _searchController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _searchController.text.length),
                    );
                  }
                  return KeyEventResult.handled;
                }
                return KeyEventResult.ignored;
              },
              child: GooglePlaceAutoCompleteTextField(
                textEditingController: _searchController,
                googleAPIKey: "AIzaSyDLCESWG3BinAKTPr4ZqFMbWGULb-9Oe70",
                inputDecoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search for area, street name...",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),

                debounceTime: 800,
                countries: const ["in"],

                getPlaceDetailWithLatLng: (Prediction prediction) async {
                  if (prediction.lat != null && prediction.lng != null) {
                    double lat = double.parse(prediction.lat!);
                    double lng = double.parse(prediction.lng!);

                    provider.updateLocation(
                      lat,
                      lng,
                      prediction.description ?? "",
                    );

                    Provider.of<HomeProvider>(context, listen: false).homeApi(context);

                    if (mounted) Navigator.pop(context);
                  }
                },

                itemClick: (Prediction prediction) {
                  _searchController.text = prediction.description ?? "";
                  _searchController.selection = TextSelection.fromPosition(
                    TextPosition(offset: prediction.description!.length),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
              InkWell(
                onTap: provider.isLoading ? null : () => provider.fetchCurrentLocation1(context),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.my_location, color: Colors.green),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomText(
                          provider.isLoading
                              ? "Fetching your location..."
                              : "Use Current Location",
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 25),
              // // ❤️ Saved / Favorite Addresses
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: CustomText(
              //     "Saved Addresses",
              //     fontWeight: FontWeight.w600,
              //     fontSize: 16,
              //     color: Colors.grey.shade800
              //   ),
              // ),
              // const SizedBox(height: 10),
              //
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: _savedAddresses.length,
              //   itemBuilder: (context, index) {
              //     final item = _savedAddresses[index];
              //     return ListTile(
              //       leading: Icon(
              //         item["title"] == "Home"
              //             ? Icons.home
              //             : Icons.work_outline_rounded,
              //         color: Colors.green,
              //       ),
              //       title: CustomText(item["title"]!),
              //       subtitle: CustomText(
              //         item["address"]!,
              //         fontSize: 12,
              //       ),
              //       onTap: () {
              //      provider
              //             .updateLocation(
              //             0.0, 0.0, item["address"] ?? "Unknown Address");
              //         Navigator.pop(context);
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        );
      },)
    );
  }
}
