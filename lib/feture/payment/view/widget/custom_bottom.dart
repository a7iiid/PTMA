import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customBottom extends StatefulWidget {
  customBottom(
      {super.key,
      this.formKey,
      required this.title,
      required this.onTap,
      this.isEnabled = true});

  final GlobalKey<FormState>? formKey;
  String title;
  bool isEnabled;

  final void Function()? onTap;
  @override
  State<customBottom> createState() => _customBottomState();
}

class _customBottomState extends State<customBottom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled ? widget.onTap : () {},
      child: Container(
        width: double.infinity,
        height: 73,
        decoration: ShapeDecoration(
          color: Color(0xFF34A853),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Center(child: Text(widget.title)),
      ),
    );
  }
}
