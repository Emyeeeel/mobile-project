
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/country_state.dart' as cs_model;
import '../../providers/user_providers.dart';
import '../../services/api_services.dart';


class LocationsPage extends ConsumerStatefulWidget {
  const LocationsPage({super.key});

  @override
  ConsumerState<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends ConsumerState<LocationsPage> {

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

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        ),
                        const SizedBox(height: 15,),
                        Text(
                          'This helps us find you more relevant content. We won’t show it on your profile',
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
                              underline: const SizedBox(), 
                              icon: const Icon(
                                IconData(0xf579, fontFamily: 'MaterialIcons', matchTextDirection: true),
                                color: Color(0xFF0F0E0F), 
                              ),
                              items: countries.map((String country) {
                                return DropdownMenuItem(
                                  value: country,
                                  child: Text(
                                    country,
                                  ),
                                );
                              }).toList(),
                              onChanged: (selectedValue) {
                                setState(() {
                                  selectedCountry = selectedValue!;
                                });
                                ref.read(userProvider.notifier).setLocation(selectedCountry.trim());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
        )
      ],
    );
  }
}