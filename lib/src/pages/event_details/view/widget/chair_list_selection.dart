import 'package:flutter/material.dart';

class ChairListSelection extends StatefulWidget {
  final List<bool> items;
  final Future<bool?> Function(int) onTap;


  ChairListSelection({required this.items,required this.onTap});

  @override
  State<ChairListSelection> createState() => _ChairListSelectionState();
}

class _ChairListSelectionState extends State<ChairListSelection> {
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
                  (index) => IconButton(onPressed:()async{
                final result=await widget.onTap(index);;
                if(result != null){
                  widget.items[index]=result;
                  setState(() {

                  });
                }
              }, icon: Icon(
                Icons.chair,
                size: 25,
                color: widget.items[index]?Colors.blue:Colors.grey,
              ))),
        ),
      );
}
