import 'product.dart';

enum WatchBrand{
  rolex('Rolex'),
  omega('Omega'),
  patekPhillipe('Patek Phillipe'),
  cartier('Cartier'),
  iwc('IWC'),
  tissot('Tissot'),
  tudor('tudor'),
  grandSeiko('Grand Seiko'),
  seiko('Seiko'),
  longines('Longines'),
  panerai('Panerai'),
  hublot('Hublot'),
  tagHeuer('Tag Heuer'),
  breitling('Breitling'),
  audemarsPiguet('Audemars Piguet');

  final String displayNames;
  const WatchBrand(this.displayNames);
  static List<String> get displayWatchBrand =>
      WatchBrand.values.map((e) => e.displayNames).toList();
}

enum WatchMovement{
automatic('Automatic'),
manual('Manual'),
quartz('Quartz'),
solar('Solar'),
kinetic('Kinetic');

final String displayName;
const WatchMovement(this.displayName);

static List<String> get displayWatchMovement =>
      WatchMovement.values.map((e) => e.displayName).toList();
}

class Watch extends Product {
  WatchBrand brand;
  String model;
  int year;
  WatchMovement movement;

  Watch(
      {required super.name,
      required super.description,
      required super.price,
      required super.status,
      required this.brand,
      required this.model,
      required this.year,
      required this.movement,
      required super.onTrend});
}
