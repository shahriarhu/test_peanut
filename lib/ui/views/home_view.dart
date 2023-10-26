import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_peanut/core/enums/view_state.dart';
import 'package:test_peanut/core/view_models/home_view_model.dart';
import 'package:test_peanut/ui/route_navigation.dart';
import 'package:test_peanut/ui/shared/app_colors.dart';
import 'package:test_peanut/ui/views/base_view.dart';
import 'package:test_peanut/ui/widgets/loading_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                model.currentPage == 0 ? 'User Profile' : 'Trades',
                style: const TextStyle(
                  color: kScaffoldBackgroundColor,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible:
                        model.state == ViewState.busy ? false : true,
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text(
                        'Log out!',
                        style: TextStyle(color: kTextMainColor),
                      ),
                      content: model.state == ViewState.busy
                          ? const SizedBox(
                              height: 40.0,
                              child: LoadingWidget(
                                size: 32.0,
                              ),
                            )
                          : const Text(
                              'Are you sure, want to log out?',
                              style: TextStyle(
                                color: kTextSecondaryColor,
                              ),
                            ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(color: kMainColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final SharedPreferences preferences =
                                await SharedPreferences.getInstance();

                            preferences.remove('token');
                            preferences.remove('userId');

                            if (context.mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteNavigation.signIn,
                                (Route route) => route.isCurrent,
                              );
                            }
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(color: kMainColor),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.logout),
                splashRadius: 24,
                color: kScaffoldBackgroundColor,
              )
            ],
          ),
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: model.currentPage,
          onTap: (index) {
            model.changePage = index;
          },
          items: [
            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.person_rounded),
              title: const Text(
                'Profile',
                style: TextStyle(fontFamily: 'Quicksand'),
              ),
              selectedColor: kMainColor,
              unselectedColor: kLightMainColor,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.handshake_rounded),
              title: const Text(
                'Trades',
                style: TextStyle(fontFamily: 'Quicksand'),
              ),
              selectedColor: kMainColor,
              unselectedColor: kLightMainColor,
            ),
          ],
        ),
        body: model.getPage(),
      ),
    );
  }
}
