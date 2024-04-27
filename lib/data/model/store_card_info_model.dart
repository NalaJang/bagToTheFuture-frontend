class StoreCardInfoModel {
  final String name;
  final String stock;
  final String averageStars;
  final String reviews;
  final String pickUpTime;
  final String distance;
  final String discount;
  final String originalPrice;
  final String salePrice;

  const StoreCardInfoModel({
    required this.name,
    required this.stock,
    required this.averageStars,
    required this.reviews,
    required this.pickUpTime,
    required this.distance,
    required this.discount,
    required this.originalPrice,
    required this.salePrice,
  });
}