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
    String accessKey = 'EASEBUZZ_ACCESS_KEY';
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
    final detailState = ref.watch(mealDetailNotifierProvider);
    final meal = detailState.meal;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: GestureDetector(
          onTap: () => context.router.back(),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text('Meal Detail', style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: detailState.isLoading ? null : initiatePayment,
          child: const Text(
            'Pay ₹1500',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: detailState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : detailState.error != null
              ? Center(child: Text(detailState.error!))
              : meal == null
                  ? const Center(child: Text('Meal not found'))
                  : Padding(
                      padding: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(meal.strMealThumb,
                                  fit: BoxFit.fill),
                            ),
                            const Gap(12),
                            Text(
                              'Name: ${meal.strMeal}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            const Gap(12),
                            Text(
                              'Category: ${meal.strCategory ?? ''}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const Gap(12),
                            Text(
                              meal.strInstructions ?? '',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
    );
  }
}
