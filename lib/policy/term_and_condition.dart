import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uday_bharat/policy/model/term_condition_model.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';

class TermAndCondition extends StatefulWidget {
  const TermAndCondition({super.key});

  @override
  State<TermAndCondition> createState() => _TermAndConditionState();
}

class _TermAndConditionState extends State<TermAndCondition> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  @override
  TermConditionModel? data =  TermConditionModel();
  bool isLoading = true;
  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var request = http.Request(
          'GET',
          Uri.parse('https://udaybharatmarts.com/api/pages/terms-and-conditions')
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String jsonString = await response.stream.bytesToString();
        print(jsonString);
        setState(() {
          data = TermConditionModel.fromJson(json.decode(jsonString));
        });
        // notifyListeners();
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Error: $e");
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }
  Widget build(BuildContext context) {
    final terms = data?.data;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          backgroundColor: AppColors.appColor,
          title: CustomText(terms?.title ?? "Terms & Conditions")),
      body: terms == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              terms.content ?? "",
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            if (terms.sections != null && terms.sections!.isNotEmpty)
              ...terms.sections!.map(
                    (section) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.heading ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      section.text ?? "",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

            const SizedBox(height: 10),

            Text(
              "Last Updated: ${terms.lastUpdated ?? "-"}",
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

}
