import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_leckortung/core/widgets/bottom_navigation.dart';
import 'package:mobile_leckortung/features/order/screens/order_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  List<Widget> pages = [
    OrderScreen(
      orders: [],
      title: 'Aufträge',
    ),
    Placeholder(),
    Placeholder()
  ];

  void onChangePageIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: const Text('Aufträge'),
        actions: [
          if (pages.elementAt(pageIndex) is OrderScreen)
            FButton.icon(
              onPress: () {
                context.push('/create-order');
              },
              child: Text(
                'schnelle Version',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
        ],
      ),
      content: pages.elementAt(pageIndex),
      footer: BottomNavigation(index: 0, onChange: onChangePageIndex),
    );
  }
}
