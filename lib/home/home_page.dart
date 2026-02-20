import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_task_app/home/location_selection_sheet.dart';
import 'package:meal_task_app/home/provider/categories_provider.dart';
import 'package:meal_task_app/home/provider/location_provider.dart';
import 'package:meal_task_app/routes/app_route.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(categoryNotifierProvider.notifier).getCategoryList();
      await ref.read(locationNotifierProvider.notifier).getCurrentLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryNotifierProvider);
    final locationState = ref.watch(locationNotifierProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        leadingWidth: MediaQuery.of(context).size.width * 0.40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const LocationSelectionSheet());
            },
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 20),
                const Gap(5),
                Container(
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: locationState.isLoading
                      ? const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: Colors.red,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          locationState.selectedAddress ?? 'Select Location',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('isLoggedIn');
                await prefs.remove('currentUser');
                await GoogleSignIn().signOut();
                if (context.mounted) {
                  context.replaceRoute(const LoginRoute());
                }
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              )),
          const Gap(10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const Gap(15),
              if (categoryState.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (categoryState.error != null)
                Center(child: Text(categoryState.error!))
              else
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: List.generate(
                      categoryState.categories.length,
                      (index) => GestureDetector(
                            onTap: () {
                              context.pushRoute(CategoryDetailRoute(
                                  category: categoryState
                                      .categories[index].strCategory));
                            },
                            child: Container(
                              height: 170,
                              width: 170,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(13)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Image.network(
                                        fit: BoxFit.fill,
                                        categoryState.categories[index]
                                            .strCategoryThumb),
                                  ),
                                  const Gap(10),
                                  Text(
                                    categoryState.categories[index].strCategory,
                                    style: const TextStyle(fontSize: 16),
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
