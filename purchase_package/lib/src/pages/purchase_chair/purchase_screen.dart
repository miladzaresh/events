import 'package:flutter/material.dart';

import 'widget/chair_item.dart';

class PurchaseScreen extends StatefulWidget {
  final List<bool> items;
  final Future<bool?> Function(int) onTap;


  PurchaseScreen({required this.items,required this.onTap});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreen();
}

class _PurchaseScreen extends State<PurchaseScreen> {
  @override
  Widget build(BuildContext context) =>
      Container(
        width: MediaQuery.of(context).size.width * .7,
        child: new GridView.count(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: List.generate(
              widget.items.length,
                  (index) => ChairItem(onTap: (index)async{
                    print('innnerr -----');
                    final result=await widget.onTap(index);;
                    print('resads ${result}');
                    if(result != null){
                      widget.items[index]=result;
                      setState(() {
                      });
                    }
                  }, index: index, value: widget.items[index])),
        ),
      );
}
