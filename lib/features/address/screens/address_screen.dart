// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazone_clone/common/widgets/custom_button.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/features/address/services/address_services.dart';
import 'package:amazone_clone/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/provider/user_provider.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../auth/screens/auth_screen.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/AddressScreen";
  final String totalAmount;

  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController houseNo = TextEditingController();
  final TextEditingController area = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController city = TextEditingController();

  final _addressFromKey = GlobalKey<FormState>();

  String addressToBeUsed = '';

  @override
  void dispose() {
    houseNo.dispose();
    area.dispose();
    pincode.dispose();
    city.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total amt',
        status: PaymentItemStatus.final_price));
  }

  List<PaymentItem> paymentItems = [];

  void gPay(res) {
    final AddressServices addressServices = AddressServices();
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalsum: double.parse(widget.totalAmount));
  }

  // void payPressed(String addressFromProvider) {
  //   addressToBeUsed = "";
  //   bool isForm = houseNo.text.isNotEmpty ||
  //       area.text.isNotEmpty ||
  //       pincode.text.isNotEmpty ||
  //       city.text.isNotEmpty;

  //   if (isForm) {
  //     if (_addressFromKey.currentState!.validate()) {
  //       addressToBeUsed =
  //           "${houseNo.text}, ${area.text}, ${city.text}, -${pincode.text}";
  //     } else {
  //       throw Exception("Please enter all the field correctly");
  //     }
  //   } else if (addressFromProvider.isNotEmpty) {
  //     addressToBeUsed = addressFromProvider;
  //   } else {
  //     showSnackBar(context, "ERROR");
  //   }
  // }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";
    bool isForm = houseNo.text.isNotEmpty ||
        area.text.isNotEmpty ||
        pincode.text.isNotEmpty ||
        city.text.isNotEmpty;

    if (isForm) {
      if (_addressFromKey.currentState!.validate()) {
        addressToBeUsed =
            "${houseNo.text}, ${area.text}, ${city.text}, -${pincode.text}";
      } else {
        throw Exception("Please enter all the field correctly");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, "ERROR");
    }
  }

  void placeOrder(String address)  {
    payPressed(address);

    final AddressServices addressServices = AddressServices();
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
    addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    
  addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalsum: double.parse(widget.totalAmount));
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                key: _addressFromKey,
                child: Column(
                  children: [
                    if (address.isNotEmpty)
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                address,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          GlobalVariables.kSizedBoxOfHeight15,
                          const Text(
                            'OR',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    CustomTextField(
                        hintLabel: "Flat, House no, Building",
                        controller: houseNo),
                    kSizedBoxAuthFormField,
                    CustomTextField(
                        hintLabel: "Area, Street", controller: area),
                    kSizedBoxAuthFormField,
                    CustomTextField(hintLabel: "Town, City", controller: city),
                    kSizedBoxAuthFormField,
                    CustomTextField(hintLabel: "Pincode", controller: pincode),
                    kSizedBoxAuthFormField,
                  ],
                ),
              ),
              GlobalVariables.kSizedBoxOfHeight10,
              CustomButton(
                  onPressed: () => placeOrder(address), text: "Pay off"),
              // GooglePayButton(
              //   height: 50,
              //   paymentConfigurationAsset: "gpay.json",
              //   onPaymentResult: gPay,
              //   paymentItems: paymentItems,
              //   type: GooglePayButtonType.buy,
              //   onPressed: () => payPressed(address),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
