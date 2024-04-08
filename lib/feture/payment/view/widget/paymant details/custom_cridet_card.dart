import 'package:flutter/cupertino.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CustomCridetCard extends StatefulWidget {
  const CustomCridetCard({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<CustomCridetCard> createState() => _CustomCridetCardState();
}

class _CustomCridetCardState extends State<CustomCridetCard> {
  String cardNumber = '', expiryDate = '', cvvCode = '', cardHolderName = '';
  bool showBackView = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardWidget(
            isHolderNameVisible: true,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: showBackView,
            onCreditCardWidgetChange: (value) {}),
        CreditCardForm(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: (creditCardModel) {
              cardHolderName = creditCardModel.cardHolderName;
              cvvCode = creditCardModel.cvvCode;
              expiryDate = creditCardModel.expiryDate;
              cardNumber = creditCardModel.cardNumber;
              showBackView = creditCardModel.isCvvFocused;
              setState(() {});
            },
            formKey: widget.formKey),
      ],
    );
  }
}
