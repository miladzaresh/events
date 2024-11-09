import 'package:flutter/material.dart';

class CustomDateWidget extends StatefulWidget {
  final void Function(String) onChoose;

  CustomDateWidget({required this.onChoose});

  @override
  State<CustomDateWidget> createState() => _CustomDateWidgetState();
}

class _CustomDateWidgetState extends State<CustomDateWidget> {
  String yearSelect = '', mountSelect = '', daySelect = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    yearSelect = DateTime.now().year.toString();
    mountSelect = DateTime.now().month.toString();
    daySelect = DateTime.now().day.toString();
  }

  List<String> years = [
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
    '2031',
  ];

  List<String> months = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];

  List<String> days() {
   return List.generate(31, (index) => (index+1).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopupMenuButton<String>(
          itemBuilder: (context) => years
              .map(
                (e) => PopupMenuItem<String>(
                  child: Text(
                    e,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  value: e,
                ),
              )
              .toList(),
          icon: Text(
            yearSelect,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onSelected: (val) {
            widget.onChoose('$val-$mountSelect-$daySelect');
            setState(() {
              yearSelect = val;
            });
          },
        ),
        SizedBox(width: 8,),
        PopupMenuButton<String>(
          itemBuilder: (context) => months
              .map(
                (e) => PopupMenuItem<String>(
              child: Text(
                e,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              value: e,
            ),
          )
              .toList(),
          icon: Text(
            mountSelect,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onSelected: (val) {
            widget.onChoose('$yearSelect-$val-$daySelect');
            setState(() {
              mountSelect = val;
            });
          },
        ),
        SizedBox(width: 8,),
        PopupMenuButton<String>(
          itemBuilder: (context) => days()
              .map(
                (e) => PopupMenuItem<String>(
              child: Text(
                e,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              value: e,
            ),
          )
              .toList(),
          icon: Text(
            daySelect,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onSelected: (val) {
            widget.onChoose('$yearSelect-$mountSelect-$val');
            setState(() {
              daySelect = val;
            });
          },
        ),

      ],
    );
  }
}
