import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:watches_project/models/watch.dart';

import '../models/watch_strap.dart';

class FiltersWidget extends StatefulWidget {
  const FiltersWidget({
    super.key,
    required this.category,
    required this.onFilterChange,
    required this.selectedFilters,
  });

  final String category;
  final Function(String, String, bool) onFilterChange;
  final Map<String, List<String>> selectedFilters;

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  Widget _buildMultiSelect({
    required String title,
    required List<String> items,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: MultiSelectDialogField(
          items: items.map((e) => MultiSelectItem(e, e)).toList(),
          title: Text('Select $title'),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          buttonIcon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          buttonText: Text(
            '$title (${widget.selectedFilters[title]?.length ?? 0})',
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          initialValue: widget.selectedFilters[title] ?? [],
          onConfirm: (selected) {
            final List<String> previousFilters = widget.selectedFilters[title] ?? [];
            for (var item in previousFilters) {
              widget.onFilterChange(title, item, false);
            }
            for (var item in selected) {
              widget.onFilterChange(title, item.toString(), true);
            }
          },
          chipDisplay: MultiSelectChipDisplay.none(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
          _buildMultiSelect(
            title: "Brand", 
            items: WatchBrand.displayWatchBrand,
          ),
        if (widget.category == 'Watch') ...[
          _buildMultiSelect(
            title: "Movement", 
            items: WatchMovement.displayWatchMovement,
          ),
        ],
        if (widget.category == 'Watch Strap') ...[
          _buildMultiSelect(
            title: "Material",
            items: StrapMaterial.displayStrapMaterials,
          ),
          _buildMultiSelect(
            title: "Diameter",
            items: Diameter.displayDiameters,
          ),
        ],
      ],
    );
  }
}