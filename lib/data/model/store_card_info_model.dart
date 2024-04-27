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
  final String image1;
  final String image2;
  final String image3;

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
    required this.image1,
    required this.image2,
    required this.image3,
  });
}