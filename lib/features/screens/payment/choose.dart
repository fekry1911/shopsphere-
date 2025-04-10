import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsphere/features/screens/payment/payment.dart';
import 'package:shopsphere/features/theme/colors.dart';
import '../../../core/cubit/appCubit/appCubit.dart';
import '../../../core/states/appStates/appStates.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Payment Method'),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is PaymentMethodChangedState) {
            // Optionally handle side effects here
          }
        },
        builder: (context, state) {
          final cubit = AppCubit.get(context);
          return Center(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: isWide ? 500 : double.infinity),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildPaymentOption(context, 'Visa',Icons.credit_card,maincolor),
                    const SizedBox(height: 12),
                    Divider(thickness: 1, color: Colors.grey[300],endIndent: 30,indent: 30,),
                    const SizedBox(height: 12),
                    _buildPaymentOption(context, 'Cash on Delivery',Icons.delivery_dining_rounded,Colors.green),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (cubit.selectedPaymentMethod == 'Visa') {
                          cubit
                              .initiatePayment(
                                  amount: (cubit.cartmodel1.data!.total!) * 100)
                              .then((onValue) {
                            print(
                                " asdbjhvsjgahkvjlbknlfjhajkjkdhfahjdhfajodhfjlashkfljdsffdj/////////////$onValue");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewScreen(
                                          url:
                                              "https://accept.paymob.com/api/acceptance/iframes/908273?payment_token=$onValue",
                                        )));
                          });
                        } else if (cubit.selectedPaymentMethod ==
                            'Cash on Delivery') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('thanks for choose us')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please select a payment method')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: state is initiatePaymentload
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text('Continue', style: TextStyle(fontSize: 16)),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentOption(BuildContext context, String label,icon , color) {
    final cubit = AppCubit.get(context);
    final selected = cubit.selectedPaymentMethod;

    return GestureDetector(
      onTap: () => cubit.setPaymentMethod(label),
      child: Card(
        elevation: 4,
        color: selected == label ? Colors.purple[100] : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon,color: color,),
          trailing: Radio<String>(
            value: label,
            groupValue: selected,
            onChanged: (value) => cubit.setPaymentMethod(value!),
            activeColor: maincolor,
          ),
          title: Text(label, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
