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
  WatchBrand _brand;
  String _model;
  int _year;
  WatchMovement _movement;
  bool _onTrend;
  String _watchImageUrl;


  Watch(
      {
      required WatchBrand brand,
      required String model,
      required int year,
      required WatchMovement movement,
      required bool onTrend,
      required String watchImageUrl,
      required super.name,
      required super.description,
      required super.price,
      required super.status,
      })  : _brand = brand,
            _model = model,
            _year = year,
            _movement = movement,
            _onTrend = onTrend == false,
            _watchImageUrl = watchImageUrl;

  WatchBrand get brand => _brand;
  String get model => _model;
  int get year => _year;
  WatchMovement get movement => _movement;
  bool get onTrend => _onTrend;
  String get watchImageUrl => _watchImageUrl;

  set brand(WatchBrand value) => _brand = value;
  set model(String value) => _model = value;
  set year(int value) => _year = value;
  set movement(WatchMovement value) => _movement = value;
  set onTrend(bool value) => _onTrend = value;
  set watchImageUrl(String value) => _watchImageUrl = value;
}
