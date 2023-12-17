import 'package:flutter/material.dart';
import 'package:weather_app/constants/city_list_constants.dart';
import 'package:weather_app/custom_widgets/dropdown_widgets/searchable_dropdown_widget.dart';

class CityNamesDropDownWidget extends StatelessWidget {
  final Function(String?) onCityNameSelected;
  final String labelText;
  final String selectedItem;
  final bool isEnabled;
  final bool showLabelText;

  const CityNamesDropDownWidget({
    super.key,
    required this.onCityNameSelected,
    required this.labelText,
    required this.selectedItem,
    required this.isEnabled,
    this.showLabelText = false,
  });

  @override
  Widget build(BuildContext context) {
    return _cityNameDropDownFieldWidget;
  }

  Widget get _cityNameDropDownFieldWidget {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity, // Occupy full width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3), // Changes the shadow position
          ),
        ],
      ),
      child: SearchableDropdown(
        showLabelText: showLabelText,
        isEnabled: isEnabled,
        labelText: labelText,
        listOfItems: CityData.getAllCityNames(),
        selectedItem: selectedItem,
        onChanged: (value) {
          onCityNameSelected(value);
        },
      ),
    );
  }
}
