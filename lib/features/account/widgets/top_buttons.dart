import 'package:amazone_clone/features/account/services/account_servicecs.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AccountServices accountServices = AccountServices();
    return Column(
      children: [
        Row(
          children: [
            customOutlinedButton('Your Orders', () {}),
            customOutlinedButton('Turn Seller', () {}),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            customOutlinedButton(
              'Log Out',
              () => accountServices.logOut(context),
            ),
            customOutlinedButton('Your WishList', () {}),
          ],
        ),
      ],
    );
  }

  Expanded customOutlinedButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0),
              borderRadius: BorderRadius.circular(50),
              color: Colors.white),
          child: OutlinedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.black12.withOpacity(0.03),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
            ),
          )),
    );
  }
}
