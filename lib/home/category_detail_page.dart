import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:meal_task_app/home/provider/meal_provider.dart';
import 'package:meal_task_app/routes/app_route.gr.dart';

final randomProvider = StateProvider<bool>((ref) {
  return false;
});

class Debounce {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debounce({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

@RoutePage()
class CategoryDetailPage extends ConsumerStatefulWidget {
  const CategoryDetailPage({super.key, required this.category});
  final String category;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoryDetailPageState();
}

class _CategoryDetailPageState extends ConsumerState<CategoryDetailPage> {
  final TextEditingController searchCtrl = TextEditingController();
  final debounce = Debounce(milliseconds: 400);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(mealNotifierProvider.notifier)
          .getMealList(category: widget.category);
      ref.read(randomProvider.notifier).update((state) => false);
    });
    super.initState();
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mealNotifierProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Category Page',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              ref.read(randomProvider.notifier).update((state) => !state);
              if (ref.watch(randomProvider) == true) {
                await ref
                    .read(mealNotifierProvider.notifier)
                    .getMealList(category: widget.category);
              } else {
                await ref.read(mealNotifierProvider.notifier).getRandomMeal();
              }
            },
            child: Text(
              ref.watch(randomProvider) ? 'Random' : 'Clear',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Gap(15)
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Gap(15),
              TextFormField(
                controller: searchCtrl,
                onChanged: (v) {
                  debounce.run(() async {
                    if (v.isEmpty) {
                      await ref
                          .read(mealNotifierProvider.notifier)
                          .getMealList(category: widget.category);
                    } else {
                      await ref
                          .read(mealNotifierProvider.notifier)
                          .searchMeal(meal: v);
                    }
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Search'),
              ),
              Gap(15),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: List.generate(
                    state.length,
                    (index) => GestureDetector(
                          onTap: () {
                            context.pushRoute(MealDetailRoute(
                                mealId:
                                    int.tryParse(state[index].idMeal) ?? 0));
                          },
                          child: Container(
                            height: 210,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(13)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 160,
                                  width: 130,
                                  child: Image.network(
                                      fit: BoxFit.fill,
                                      state[index].strMealThumb),
                                ),
                                Gap(10),
                                Text(
                                  state[index].strMeal,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
