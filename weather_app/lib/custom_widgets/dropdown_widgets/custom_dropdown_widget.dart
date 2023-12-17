import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomDropDownWidget extends StatelessWidget {
  final String dropDownTitle;
  final String selectedOption;
  // final List<String> optionsForDropdown = ["All", "Pre-Booking", "Subscription",];
  final List<String> optionsForDropdown;
  final ValueChanged<String?> onChanged;
  final bool isEnabled;

  const CustomDropDownWidget({
    super.key,
    required this.dropDownTitle,
    required this.selectedOption,
    required this.optionsForDropdown,
    required this.onChanged,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return _selectDropDownWidget;
  }

  Widget get _selectDropDownWidget {
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: dropDownTitle.tr(),
          border: InputBorder.none,
          labelStyle: TextStyle(
            color: isEnabled ? Colors.blue : Colors.grey,
          ),
        ),
        value: selectedOption,
        onChanged: isEnabled ? onChanged : null,
        items: optionsForDropdown.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
