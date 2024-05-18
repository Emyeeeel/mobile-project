import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinterest_clone/models/country_state_repo.dart';
import 'package:pinterest_clone/models/user_model.dart';
import 'package:pinterest_clone/screens/landing_page.dart';
import 'package:pinterest_clone/widgets/button.dart';

import 'package:pinterest_clone/models/country_state.dart' as cs_model;
import 'package:http/http.dart' as http;

class LocationPage extends ConsumerStatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends ConsumerState<LocationPage> {
  final CountryStateCityRepo _countryStateCityRepo = CountryStateCityRepo();

  List<String> countries = [];
  cs_model.CountryStateModel countryStateModel =
      cs_model.CountryStateModel(error: false, msg: '', data: []);

  String selectedCountry = 'Select Country';
  String selectedState = 'Select State';
  bool isDataLoaded = false;

  String finalTextToBeDisplayed = '';

  getCountries() async {
    countryStateModel = await _countryStateCityRepo.getCountriesStates();
    countries.add('Select Country');
    for (var element in countryStateModel.data) {
      countries.add(element.name);
    }
    isDataLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  Future<void> sendUsersData(BuildContext context, WidgetRef ref) async {
    try {
      // Get the user data from the provider
      final user = ref.read(userProvider);

      String dateOfBirthString = user.dateOfBirth!.toIso8601String();

      final firestore = FirebaseFirestore.instance;

      await firestore.collection('users').add({
        'email': user.email,
        'password': user.password,
        'name': user.name,
        'dateOfBirth': dateOfBirthString,
        'gender': user.gender,
        'location': user.location,
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingPage(),
        ),
      );
    } catch (e) {
      print('Error sending user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: !isDataLoaded
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30,),
                        Text(
                          'Where do you live?',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0F0E0F),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Text(
                          'This helps us find you more relevant content. We won’t show it on your profile',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0F0E0F),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: 380,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 2, color: const Color(0xFF0F0E0F))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectedCountry,
                              dropdownColor: Colors.black, 
                              underline: const SizedBox(), 
                              icon: const Icon(
                                IconData(0xf579, fontFamily: 'MaterialIcons', matchTextDirection: true),
                                color: Colors.white, 
                              ),
                              items: countries.map((String country) {
                                return DropdownMenuItem(
                                  value: country,
                                  child: Text(
                                    country,
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF0F0E0F),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (selectedValue) {
                                setState(() {
                                  selectedCountry = selectedValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          const Spacer(),
          ButtonWidget(text: 'Next', textColor: 'white', buttonColor: 'red', onPressed: (){
            if (selectedCountry.isNotEmpty) {
                ref.read(userProvider.notifier).setLocation(selectedCountry);
                // Send user data
                sendUsersData(context, ref);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select your country')),
                );
              }
          } ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
