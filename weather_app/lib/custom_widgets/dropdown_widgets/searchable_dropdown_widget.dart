import 'package:easy_localization/easy_localization.dart' as loc;
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:weather_app/constants/app_color_constants.dart';

class SearchableDropdown extends StatelessWidget {
  final List<String> listOfItems;
  final String? selectedItem;
  final String labelText;
  final Function(String?) onChanged;
  final bool isEnabled;
  final bool showLabelText;

  const SearchableDropdown({
    Key? key,
    required this.listOfItems,
    required this.selectedItem,
    required this.labelText,
    required this.onChanged,
    required this.isEnabled,
    required this.showLabelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextDirection currentDirection = Directionality.of(context);

    return IgnorePointer(
      ignoring: !isEnabled,
      child: Theme(
        data: ThemeData.light(useMaterial3: false),
        child: DropdownSearch<String>(
          popupProps: PopupProps.modalBottomSheet(
            fit: FlexFit.loose,
            constraints: BoxConstraints.tightFor(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.81,
            ),
            modalBottomSheetProps: const ModalBottomSheetProps(
              elevation: 16.0,
              enableDrag: false,
              useSafeArea: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              backgroundColor: AppColorConstants.pageBgColor,
            ),
            showSearchBox: true,
            title: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "${"Search".tr()} $labelText",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                ),
              ),
              autofocus: false,
            ),
            showSelectedItems: true,
            isFilterOnline: false,
            searchDelay: const Duration(milliseconds: 300),
          ),
          items: listOfItems,
          dropdownButtonProps: DropdownButtonProps(
            color: isEnabled ? null : Colors.grey.withOpacity(0.7),
            padding: EdgeInsets.only(
              left: currentDirection == TextDirection.ltr ? 25 : 0,
              right: currentDirection == TextDirection.rtl ? 25 : 0,
            ),
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(
              color: isEnabled ? null : Colors.grey,
              fontWeight: FontWeight.w500,
            ),
            dropdownSearchDecoration: InputDecoration(
              labelText: showLabelText ? labelText : null,
              hintText: labelText,
              enabled: isEnabled,
              labelStyle: TextStyle(
                color: isEnabled ? Colors.blue : Colors.grey,
              ),
              border: InputBorder.none,
            ),
          ),
          onChanged: onChanged,
          selectedItem: selectedItem,
        ),
      ),
    );
  }
}
