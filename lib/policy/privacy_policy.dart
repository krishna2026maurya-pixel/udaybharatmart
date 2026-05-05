import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uday_bharat/policy/model/privacy_policy_model.dart';
import '../utils/color.dart';
import '../utils/cutom_text.dart';

class PrivacyPolicyScreen extends StatefulWidget {


  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  PrivacyPolicyModel? data =  PrivacyPolicyModel();
  bool isLoading = true;
  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var request = http.Request(
          'GET',
          Uri.parse('https://udaybharatmarts.com/api/pages/privacy-policy')
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String jsonString = await response.stream.bytesToString();
        print(jsonString);

        setState(() {
          data = PrivacyPolicyModel.fromJson(json.decode(jsonString));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        centerTitle: true,
        title: CustomText(data?.data?.title??''),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child:isLoading?Center(child: CircularProgressIndicator()): Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data?.data?.content??'',
                fontSize: 15, color: Colors.black87
            ),
            const SizedBox(height: 20),

            ...?(data?.data?.sections ?? []).map((section) => Column(
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
                CustomText(
                  section.text ?? "",
                    fontSize: 14, color: Colors.black87,
                ),
                const SizedBox(height: 16),
              ],
            )),


            const SizedBox(height: 20),

            Text(
              "Last Updated: ${data?.data?.lastUpdated}",
              style: const TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
