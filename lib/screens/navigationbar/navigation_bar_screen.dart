import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_hack/bloc/bloc_navigationbar/navigationbar_bloc.dart';
import 'package:team_hack/bloc/bloc_navigationbar/navigationbar_event.dart';
import 'package:team_hack/bloc/bloc_navigationbar/navigationbar_state.dart';
import 'package:team_hack/screens/home/home_screen.dart';
import 'package:team_hack/screens/search/search_screen.dart';

class NavigationBarScreen extends StatelessWidget {
  const NavigationBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final pages = [
          const HomeScreen(),
          const SearchScreen(),
          const HomeScreen(), //change it to Notification screen
          const HomeScreen() // change it to Profile screen
        ];
        int currentIndex =
            state is NavigationInitialState ? state.indexPage : 0;
        return Scaffold(
          extendBody: true,
          body: pages[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: const Color.fromRGBO(211, 84, 0, 1),
              elevation: 0,
              backgroundColor: Colors.orange[200],
              currentIndex: currentIndex,
              onTap: (index) {
                context
                    .read<NavigationBloc>()
                    .add(ClickNavigationEvent(clickIndex: index));
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.house,
                      size: 20,
                      color: currentIndex == 0
                          ? const Color.fromRGBO(211, 84, 0, 1)
                          : const Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search_rounded,
                      size: 20,
                      color: currentIndex == 1
                          ? const Color.fromRGBO(211, 84, 0, 1)
                          : const Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                    label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      size: 20,
                      color: currentIndex == 2
                          ? const Color.fromRGBO(211, 84, 0, 1)
                          : const Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                    label: 'Notification'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_outline_rounded,
                      size: 20,
                      color: currentIndex == 3
                          ? const Color.fromRGBO(211, 84, 0, 1)
                          : const Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                    label: 'Profile'),
              ]),
        );
      },
    );
  }
}
