import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import 'loading_app.dart';

class FilterView extends StatelessWidget {
  final bool  isExpired, isSorted, haveCapacity,isClear;
  final int minPrice, maxPrice, valuePrice;
  final void Function(bool?) onChangeHaveCapacity,
      onChangeIsExpired,
      onChangeIsSorted;
  final void Function(double?) onChangePrice;
  final void Function() onClose;
  final void Function() onSubmit;
  final void Function() onFilterClear;

  FilterView({
    required this.isExpired,
    required this.isSorted,
    required this.haveCapacity,
    required this.minPrice,
    required this.maxPrice,
    required this.valuePrice,
    required this.onChangeHaveCapacity,
    required this.onChangeIsExpired,
    required this.onChangeIsSorted,
    required this.onChangePrice,
    required this.onFilterClear,
    required this.onClose,
    required this.onSubmit,
    required this.isClear,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Text(
                LocaleKeys.filter_page_title.tr,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                LocaleKeys.filter_page_limited_price.tr,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    minPrice.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                    maxPrice.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Slider(
                value: valuePrice.toDouble(),
                onChanged: onChangePrice,
                max: maxPrice.toDouble(),
                label: valuePrice.toString(),
                divisions: 5,
                min: minPrice.toDouble(),
              ),
              SizedBox(
                height: 12,
              ),
              _buildCheckBoxValue(
                LocaleKeys.filter_page_have_capacity.tr,
                haveCapacity,
                onChangeHaveCapacity,
              ),
              SizedBox(
                height: 12,
              ),
              _buildCheckBoxValue(
                LocaleKeys.filter_page_sort_by_date.tr,
                isSorted,
                onChangeIsSorted,
              ),
              SizedBox(
                height: 12,
              ),
              _buildCheckBoxValue(
                LocaleKeys.filter_page_not_expired.tr,
                isExpired,
                onChangeIsExpired,
              ),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RawMaterialButton(
                onPressed: onClose,
                child: Text(
                  LocaleKeys.shared_text_cancel.tr,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.red
                  ),
                ),
              ),
              if(isExpired || isSorted || haveCapacity || !isClear)
                RawMaterialButton(
                  onPressed: onFilterClear,
                  child: Text(
                    LocaleKeys.filter_page_clear_filters.tr,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.red
                    ),
                  ),
                ),
              RawMaterialButton(
                onPressed: onSubmit,
                child: Text(
                  LocaleKeys.shared_text_submit.tr,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );

  Widget _buildCheckBoxValue(
          String title, bool value, void Function(bool?) onChange) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(value: value, onChanged: onChange),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          )
        ],
      );
}
