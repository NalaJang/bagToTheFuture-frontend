import 'package:rest_api_ex/data/model/store_card_info_model.dart';

class StoreCardInfoData {
  static const List<StoreCardInfoModel> cardInfoList = [
    StoreCardInfoModel(
      name: '참바른빵',
      stock: '3',
      averageStars: '4.8',
      reviews: '21',
      pickUpTime: '오후 6:00~10:00',
      distance: '800',
      discount: '61%',
      originalPrice: '9,900',
      salePrice: '3,900',
      image1: 'assets/images/sample.png',
      image2: 'assets/images/sample.png',
      image3: 'assets/images/sample.png',
    ),

    StoreCardInfoModel(
      name: '명분',
      stock: '5',
      averageStars: '4.5',
      reviews: '18',
      pickUpTime: '오후 6:00~8:00',
      distance: '800',
      discount: '61%',
      originalPrice: '9,900',
      salePrice: '3,900',
      image1: 'assets/images/sample.png',
      image2: 'assets/images/sample.png',
      image3: 'assets/images/sample.png',
    ),

    StoreCardInfoModel(
      name: '참바른명분',
      stock: '13',
      averageStars: '4.8',
      reviews: '8',
      pickUpTime: '오후 5:00~8:00',
      distance: '1.5',
      discount: '61%',
      originalPrice: '9,900',
      salePrice: '3,900',
      image1: 'assets/images/sample.png',
      image2: 'assets/images/sample.png',
      image3: 'assets/images/sample.png',
    ),

    StoreCardInfoModel(
      name: '명분의 빵',
      stock: '8',
      averageStars: '4.7',
      reviews: '6',
      pickUpTime: '오후 6:00~10:00',
      distance: '2',
      discount: '61%',
      originalPrice: '9,900',
      salePrice: '3,900',
      image1: 'assets/images/sample.png',
      image2: 'assets/images/sample.png',
      image3: 'assets/images/sample.png',
    ),
  ];
}
