import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectNgoScreen extends StatefulWidget {
  const SelectNgoScreen({super.key});

  @override
  State<SelectNgoScreen> createState() => _SelectNgoScreenState();
}

class _SelectNgoScreenState extends State<SelectNgoScreen> {
  List<String> ngoList = ["NGO A", "NGO B", "NGO C"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchableDropdown(ngoNames: ngoList),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          padding: EdgeInsets.symmetric(
            horizontal: 100.w,
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                "NGO Name",
                style: TextStyle(fontSize: 15.h, color: Colors.black),
              ),
              leading: Icon(Icons.perm_identity),
              trailing: Text(
                "NGO A",
                style: TextStyle(fontSize: 15.h, color: Colors.black),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SearchableDropdown extends StatelessWidget {
  final List<String> ngoNames;

  const SearchableDropdown({super.key, required this.ngoNames});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownSearch<String>(
        items: ngoNames,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Select an NGO",
            contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
            border: OutlineInputBorder(),
          ),
        ),
        popupProps: const PopupProps.menu(
          showSearchBox: true,
        ),
        onChanged: (String? newValue) {
          print(newValue);
        },
      ),
    );
  }
}
