
import 'dart:convert';

import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';
import '../../design/color_styles.dart';
import '../../design/font_styles.dart';
import '../../design/svg_icon.dart';
import 'daum_postcode_screen.dart';
import 'home_viewmodel.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;


class SetLocationMapScreen extends StatefulWidget {
  const SetLocationMapScreen({super.key});
  @override
  State<SetLocationMapScreen> createState() =>
      _SetLocationMapScreen();
}

class _SetLocationMapScreen extends State<SetLocationMapScreen> {
  double lat = 0;
  double lng = 0;
  String jibunAddress = "";
  String doroAddress = "";
  Location location = new Location();
  bool _serviceEnabled = true;
  late PermissionStatus _permissionGranted;
  NaverMapController? _mapController;
  NMarker? _currentMarker;
  @override
  void initState() {
    super.initState();
    _myLocate();
  }
  Future<void>_myLocate() async {
    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if(!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied) {
      _permissionGranted != await location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((value) => {
      setState(() {
        lat = value.latitude!;
        lng = value.longitude!;
      })
    });
  }

  void _updateLocate(double latitude, double longitude) async {
    setState(() {
      lat = latitude;
      lng = longitude;
    });
    if (_mapController != null) {
      _mapController!.clearOverlays();
      _addMarker(latitude, longitude);
    }
  }

  void _addMarker(double latitude, double longitude) {
    if (_currentMarker != null) {
      _mapController?.clearOverlays();
    }
    _currentMarker = NMarker(
        id: 'unique_marker_id',
        position: NLatLng(latitude, longitude),
        icon: NOverlayImage.fromAssetImage('assets/images/ic_location.png')
    );
    _mapController!.addOverlay(_currentMarker!);
  }

  Future<void> _getAddress(double lat, double lng) async {
    await dotenv.load(fileName: '.env');
  String? apiKeyId = dotenv.env['NAVER_MAP_CLIENT_ID'];
  String? apiKeySecret = dotenv.env['NAVER_MAP_CLIENT_SECRET'];
    var response = await http.get(
      Uri.parse('https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=$lng,$lat&sourcecrs=epsg:4326&orders=admcode,legalcode,addr,roadaddr&output=json'),
      headers: {
        'X-NCP-APIGW-API-KEY-ID': apiKeyId!,
        'X-NCP-APIGW-API-KEY': apiKeySecret!
  }
    );
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    List<Map<String, dynamic>> addressList = [];
    void parseAddressData(Map<String, dynamic> jsonResponse) {
      if(jsonResponse['results'].length != null && jsonResponse['results'].length>0) {
        final addressResults = jsonResponse['results'];
        addressList.clear();
        for(var result in addressResults) {
          Map<String, dynamic> addressInfo = {};
          if(result['region'] != null || result['land'] != null) {
            final region = result['region'];
            final land = result['land'];
            String area1 = region['area1']['name'];
            String area2 = region['area2']['name'];
            String area3 = region['area3']['name'];
            addressInfo['area1'] = area1;
            addressInfo['area2'] = area2;
            addressInfo['area3'] = area3;
            if(land != null) {
              String? landName = land['name'];
              String? landNumber1 = land['number1'];
              String? landNumber2 = land['number2'];
              String? addition0 = land['addition0']['value'];
              if (landName != null) {
                addressInfo['name'] = landName;
              }
              if (landNumber1 != null) {
                addressInfo['number1'] = landNumber1;
              }
              if (landNumber2 != null) {
                addressInfo['number2'] = landNumber2;
              }
              if (addition0 != null) {
                addressInfo['addition0'] = addition0;
              }
            }

          }
          addressList.add(addressInfo);
        }
      }
    }
    parseAddressData(jsonResponse);
    if(addressList.isNotEmpty) {
      jibunAddress = '${addressList[0]['area1']} ${addressList[0]['area2']} ${addressList[0]['area3']}';
      doroAddress = '${addressList[0]['area1']} ${addressList[0]['area2']}';
      // 추가 상세 주소 정보가 있는 경우 추가
      String? landName = addressList[addressList.length - 1]['name'];
      String? landNumber1 = addressList[addressList.length - 1]['number1'];
      String? landNumber2 = addressList[addressList.length - 1]['number2'];
      String? addition0 = addressList[addressList.length - 1]['addition0'];
      if (landName != null && landName.isNotEmpty) {
        doroAddress += ' $landName';
      }
      if (landNumber1 != null && landNumber1.isNotEmpty) {
        doroAddress += ' $landNumber1';
      }
      if (landNumber2 != null && landNumber2.isNotEmpty) {
        doroAddress += '-$landNumber2';
      }
      if (addition0 != null && addition0.isNotEmpty) {
        doroAddress += ' $addition0';
      }
    }
  }

  Future<void> getGraph(String addressReceive) async {
    doroAddress = "";
    jibunAddress = "";
    await dotenv.load(fileName: '.env');
    String? apiKeyId = dotenv.env['NAVER_MAP_CLIENT_ID'];
    String? apiKeySecret = dotenv.env['NAVER_MAP_CLIENT_SECRET'];
    var response = await http.get(
      Uri.parse('https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode')
          .replace(queryParameters: {
         'query': addressReceive,
      }),
        headers: {
          'X-NCP-APIGW-API-KEY-ID': apiKeyId!,
          'X-NCP-APIGW-API-KEY': apiKeySecret!
        }
    );
    var jsonResponse = jsonDecode(response.body);
    var address = jsonResponse['addresses'];
    if(address.isNotEmpty) {
      var firstAddress = address[0];
      setState(() {
        lat = double.parse(firstAddress['x']);
        lng = double.parse(firstAddress['y']);
      });
      print('임어ㅣ$lat');
      _updateLocate(lat, lng);
    }
  }

  DataModel? _dataModel;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: IconButton(
            icon: SvgIcon.arrowLeft(color: AppColors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
              '위치 추가하기',
              style: FontStyles.Title3.copyWith(color: AppColors.black)
          ),
          centerTitle: true,
        ),
        body: Stack (
          children: [
            lat == 0 && lng == 0 ? Center(
              child: CircularProgressIndicator())
            :NaverMap(
              options: NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                  target: NLatLng(lat,lng),
                  zoom: 15,
                  bearing: 0,
                  tilt: 0,
                ),
                mapType: NMapType.basic,
                activeLayerGroups: [NLayerGroup.building, NLayerGroup.transit],
              ),
              onMapReady: (controller) {
                _mapController = controller;
                _addMarker(lat, lng);
                if(_dataModel?.address!= null) {
                  _addMarker(lat, lng);
                }
              },
              onMapTapped:(point, latLng) {
                _updateLocate(latLng.latitude, latLng.longitude);
                _getAddress(latLng.latitude, latLng.longitude);
              }
            ),
            Positioned(
                top: 22,
                left: 14,
                right: 14,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DaumPostcodeScreen();
                    })).then((value){
                      setState(() {
                        _dataModel = value;
                        getGraph(_dataModel!.address);
                      });
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.black.withOpacity(0.85),
                              blurRadius: 4,
                              offset: Offset(0,4)
                          )
                        ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: (){

                              },
                              icon: SvgIcon.search(width: 16, height: 16, color: AppColors.black)
                          ),
                          SizedBox(width: 12),
                          Text(
                            '주소를 검색하세요',
                            style: FontStyles.Body2.copyWith(color: AppColors.gray5),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ),
            if(_dataModel?.address != null && _dataModel?.jibunAddress != null)
              Positioned(
                  bottom: 0,
                  child: AddressBottomSheet(_dataModel!.address,
                      _dataModel!.jibunAddress,
                      _controller, context,
                      () async => await viewModel.addItem(_dataModel!.address, _controller.text)
                  )
              ),
            if(jibunAddress != "" && doroAddress != "")
              Positioned(
                  bottom: 0,
                  child: AddressBottomSheet(
                      doroAddress,
                      jibunAddress,
                      _controller, context,
                          () async => await viewModel.addItem(doroAddress, _controller.text)
                  )
              ),
          ],
        )
    );
  }
}



Widget AddressBottomSheet(String address, String detail, TextEditingController controller, BuildContext context, Future<void> Function() onAction) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        )
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 37,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: Text(
            address,
            style: FontStyles.Title3.copyWith(color: AppColors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: Text(
            '[지번] ${detail}',
            style: FontStyles.Caption1.copyWith(color: AppColors.gray5),
          ),
        ),
        SizedBox(height: 19),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 13 ),
              filled: true,
              fillColor: AppColors.gray0,
              hintText: '별칭을 정해주세요 (ex. 우리집, 최대 5자)',
              hintStyle: FontStyles.Body3.copyWith(color: AppColors.gray5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color:  AppColors.gray0,)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color:  AppColors.gray0,)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color:  AppColors.gray0,)
              ),
            ),
          ),
        ),
        SizedBox(height: 23),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 23),
          child: TextButton(
            onPressed: () async {
              if(controller.text.isNotEmpty) {
                await onAction();
                Navigator.pop(context);
              } else {

              }
            },
            style: TextButton.styleFrom(
              backgroundColor: controller.text.isEmpty ? AppColors.gray4 : AppColors.main,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4)
                )
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
              minimumSize: const Size.fromHeight(50)
            ),
            child: Text('설정하기',
              style: FontStyles.Body2.copyWith(color: AppColors.white),
            ),
          )

        )
      ],
    ),
  );
}