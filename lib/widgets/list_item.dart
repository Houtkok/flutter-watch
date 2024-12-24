import 'package:flutter/material.dart';
import 'package:watches_project/models/product.dart';
import 'package:watches_project/models/product_manager.dart';
import 'package:watches_project/models/watch.dart';
import 'package:watches_project/models/watch_strap.dart';
import 'package:watches_project/screens/user/product_details_screen.dart';
import 'package:watches_project/widgets/product_card.dart';

class ListItem extends StatefulWidget {
  const ListItem(
      {super.key,
      required this.filters,
      required this.productManager,
      required this.category,
      required this.searchQuery});
  final Map<String, List<String>> filters;
  final ProductManager productManager;
  final String category;
  final String searchQuery;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filterProducts();
  }

  void _filterProducts() {
  List<Product> allProducts = [];

  if (widget.category == 'Watch') {
    allProducts = widget.productManager.products.whereType<Watch>().toList();
  } else if (widget.category == 'Watch Strap') {
    allProducts = widget.productManager.products.whereType<WatchStrap>().toList();
  }

  setState(() {
    List<Product> filteredByFilters = allProducts.where((product) {
      bool matchesFilters = true;
      if (product is WatchStrap) {
        if (widget.filters['Material']!.isNotEmpty) {
          matchesFilters &= widget.filters['Material']!.contains(product.material.displayName);
        }
        if (widget.filters['Diameter']!.isNotEmpty) {
          matchesFilters &= widget.filters['Diameter']!.contains(product.diameter.displayName);
        }
      } else if (product is Watch) {
        if (widget.filters['Movement']!.isNotEmpty) {
          matchesFilters &= widget.filters['Movement']!.contains(product.movement.displayName);
        }
      }

      if (widget.filters['Brand']!.isNotEmpty) {
        matchesFilters &= widget.filters['Brand']!.contains(
          product is Watch ? product.brand.displayNames : (product as WatchStrap).brand
        );
      }

      return matchesFilters;
    }).toList();

    _filteredProducts = filteredByFilters.where((product) {
      String query = widget.searchQuery.toLowerCase();
      return product.name.toLowerCase().contains(query) ||
          (product is Watch && product.brand.displayNames.toLowerCase().contains(query)) ||
          (product is WatchStrap && product.brand.toLowerCase().contains(query)) ||
          (product is Watch && product.model.toLowerCase().contains(query)) ||
          (product is WatchStrap && product.model.toLowerCase().contains(query));
    }).toList();
  });
}

  @override
  Widget build(BuildContext context) {
    _filterProducts();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2 / 3,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        String brand = 'Unknown';
        String model = 'Unknown';

        if (product is Watch) {
          brand = product.brand.displayNames;
          model = product.model;
        } else if (product is WatchStrap) {
          brand = product.brand;
          model = product.model;
        }
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product)),
            );
          },
          child: ProductCard(
            brand: brand,
            model: model,
            price: '${product.price}', 
            imageUrl: product.imageUrl,
          ),
        );
      },
    );
  }
}
