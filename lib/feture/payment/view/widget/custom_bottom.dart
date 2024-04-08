import 'package:flutter/cupertino.dart';

class customBottom extends StatefulWidget {
  customBottom(
      {super.key, this.formKey, required this.title, required this.onTap});

  final GlobalKey<FormState>? formKey;
  String title;
  final void Function()? onTap;
  @override
  State<customBottom> createState() => _customBottomState();
}

class _customBottomState extends State<customBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 73,
      decoration: ShapeDecoration(
        color: Color(0xFF34A853),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: GestureDetector(
          onTap: widget.onTap, child: const Center(child: Text("Submit"))),
    );
  }
}
