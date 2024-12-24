import 'package:flutter/material.dart';
import 'package:watches_project/models/product_manager.dart';
import 'package:watches_project/widgets/list_item.dart';
import 'package:watches_project/widgets/slider.dart' as custom_slider;
import '../../widgets/app_bar.dart';
import '../../widgets/search_bar.dart' as custom_search;
import '../../widgets/toggle_buttons.dart';
import '../../widgets/filters.dart';
import '../../widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.productManager});
  final ProductManager productManager;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Watch';
  Map<String, List<String>> selectedFilters = {
    'Brand': [],
    'Material': [],
    'Diameter': [],
    'Movement': [],
  };
  String searchQuery = '';

  void _onCategoryChange(String category) {
    setState(() {
      selectedCategory = category;
      selectedFilters = {
        'Brand': [],
        'Material': [],
        'Diameter': [],
        'Movement': [],
      };
    });
  }

  void _onFilterChange(String filterType, String filter, bool isSelected) {
    setState(() {
      if (isSelected) {
        if (!selectedFilters[filterType]!.contains(filter)) {
          selectedFilters[filterType]!.add(filter);
        }
      } else {
        selectedFilters[filterType]!.remove(filter);
      }
    });
  }

  void _onSearchChange(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Watches'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  custom_search.SearchBar(onChange: _onSearchChange),
                  const SizedBox(height: 16),
                  ToggleButtonsWidget(
                      selectedCategory: selectedCategory,
                      onCategoryChange: _onCategoryChange),
                  const SizedBox(height: 16),
                  FiltersWidget(
                    category: selectedCategory,
                    onFilterChange: _onFilterChange,
                    selectedFilters: selectedFilters,
                  ),
                  const SizedBox(height: 16),
                ])),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedCategory == 'Watch')
                    const SectionTitle(title: 'Trending Watches'),
                  const SizedBox(height: 8),
                  if (selectedCategory == 'Watch')
                    custom_slider.TrendingSlider(
                        products: widget.productManager.products),
                  const SizedBox(height: 16),
                  SectionTitle(
                    title: selectedCategory == 'Watch'
                        ? 'All Watches'
                        : 'All Watch Straps',
                  ),
                  const SizedBox(height: 8),
                  ListItem(
                    filters: selectedFilters,
                    productManager: widget.productManager,
                    category: selectedCategory,
                    searchQuery: searchQuery,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
