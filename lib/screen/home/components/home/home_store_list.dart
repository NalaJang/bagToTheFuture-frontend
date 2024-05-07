import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';


class HomeStoreList extends StatelessWidget {
  final String title;
  final double score;
  final int reviewer;
  final int restCnt;
  final String startTime;
  final String endTime;
  final int walkingTime;
  final int discount;
  final int originalPrice;
  final int realPrice;
  final String imageUrl1;
  final String imageUrl2;
  final String imageUrl3;

  const HomeStoreList({
    Key? key,
    required this.title,
    required this.score,
  required this.reviewer,
  required this.restCnt,
  required this.startTime,
  required this.endTime,
  required this.walkingTime,
  required this.discount,
  required this.originalPrice,
  required this.realPrice,
    required this.imageUrl1,
    required this.imageUrl2,
    required this.imageUrl3
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0,2)
          )
        ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl1,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover
              ),
              SizedBox(width: 4,),
              Column(
                children: [
                  CachedNetworkImage(
                      imageUrl: imageUrl2,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover
                  ),
                  SizedBox(width: 4,),
                  CachedNetworkImage(
                      imageUrl: imageUrl3,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: Text(
                      title,
                      style: FontStyles.Price1.copyWith(color: AppColors.black),
                    ),
                  ),
                  SizedBox(width: 4,),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          color: AppColors.lightPurple
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(3.5, 3.5, 3, 3.5),
                            child: SvgIcon.bagIcon(width: 10, height: 10, color: AppColors.purple),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0,2,2,3.5),
                            child: Text(
                              '$restCnt개 남음',
                              style: FontStyles.Caption5.copyWith(color: AppColors.purple),
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                    child: Text(
                      '$discount%',
                      style: FontStyles.Body8.copyWith(color: AppColors.red),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: Text(
                      '$originalPrice원',
                      style: FontStyles.Body8.copyWith(
                          color: AppColors.gray4,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 4,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Row(
               children: [
                 SizedBox(width: 14,),
                 SvgIcon.tagStar(width: 12, height: 12, color: AppColors.yellow),
                 SizedBox(width: 2,),
                 Text(
                   '$score ($reviewer)',
                   style: FontStyles.Caption5.copyWith(color: AppColors.gray6),
                 ),
                 SizedBox(width: 11),
                 Text(
                   '픽업 $startTime ~ $endTime · 도보 $walkingTime분',
                   style: FontStyles.Caption5.copyWith(color: AppColors.gray6),
                 )
               ],
             ),
             Row(
               children: [
                 Padding(
                     padding: EdgeInsets.only(right: 13),
                   child: Text(
                     '$realPrice원~',
                     style: FontStyles.Title5.copyWith(color: AppColors.black),
                   ),
                 )
               ],
             )
           ],
         ),
          SizedBox(height: 13,),
        ],
      ),
    );
  }
}