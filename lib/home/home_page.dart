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
    final state = ref.watch(categoryNotifierProvider);
    final locationState = ref.watch(locationNotifierProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
        ),
        leading: SizedBox(),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => LocationSelectionSheet());
            },
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.white, size: 20),
                Gap(5),
                Container(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: Text(
                    locationState.selectedAddress ?? 'Select Location',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Gap(15),
          GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('isLoggedIn');
                await prefs.remove('currentUser');
                await GoogleSignIn().signOut();
                context.replaceRoute(LoginRoute());
              },
              child: Icon(
                Icons.logout,
                color: Colors.white,
              )),
          Gap(10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Gap(15),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: List.generate(
                    state.length,
                    (index) => GestureDetector(
                          onTap: () {
                            context.pushRoute(CategoryDetailRoute(
                                category: state[index].strCategory));
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
                                      state[index].strCategoryThumb),
                                ),
                                Gap(10),
                                Text(
                                  state[index].strCategory,
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
