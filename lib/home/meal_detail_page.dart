import 'package:auto_route/auto_route.dart';
import 'package:easebuzz_flutter/easebuzz_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:meal_task_app/home/provider/meal_provider.dart';

@RoutePage()
class MealDetailPage extends ConsumerStatefulWidget {
  const MealDetailPage({super.key, required this.mealId});
  final int mealId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends ConsumerState<MealDetailPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(mealDetailNotifierProvider.notifier)
          .getMealById(mealId: widget.mealId);
    });
    super.initState();
  }

  final _easebuzzFlutterPlugin = EasebuzzFlutter();

  Future<void> initiatePayment() async {
    String accessKey = 'ACCESS_KEY';
    String payMode = "test";
    try {
      final paymentResponse = await _easebuzzFlutterPlugin.payWithEasebuzz(
        accessKey,
        payMode,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(paymentResponse.toString())));
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Payment failed: ${e.message}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mealDetailNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Meal Detail', style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: initiatePayment,
        child: Text('Pay ₹1500'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Image.network(state.strMealThumb, fit: BoxFit.fill),
              ),
              Gap(12),
              Text(
                'Name: ${state.strMeal}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Gap(12),
              Text(
                'Category: ${state.strCategory ?? ''}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Gap(12),
              Text(
                state.strInstructions ?? '',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
