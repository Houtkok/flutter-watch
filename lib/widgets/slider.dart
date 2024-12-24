import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:watches_project/models/product.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final trendingProduct =
        products.where((product) => product.onTrend).toList();
    if (trendingProduct.isEmpty) {
      return const SizedBox.shrink();
    }

    return slider.CarouselSlider(
      options: slider.CarouselOptions(
        height: 275,
        viewportFraction: 0.6,
        enableInfiniteScroll: false,
        initialPage: 0,
        enlargeCenterPage: true,
      ),
      items: trendingProduct.map((product) {
        return Builder(builder: (BuildContext context) {
          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.grey[300],
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
      }).toList(),
    );
  }
}
