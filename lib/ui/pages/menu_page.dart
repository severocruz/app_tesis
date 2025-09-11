import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_tesis/config/app_colors.dart';
import 'package:app_tesis/provider/navigation_provider.dart';
import 'package:app_tesis/ui/pages/home_page.dart';
import 'package:app_tesis/ui/pages/records_page.dart';
import 'package:app_tesis/utils/Colors.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _pageOption = [
    const HomePage(),
    const RecordsPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    var colortheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: _pageOption[navigationProvider.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors().WhiteColor,
        backgroundColor: AppColors().boxcolor,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
            fontFamily: 'Gilroy Bold', fontWeight: FontWeight.bold),
        fixedColor: Theme.of(context).colorScheme.tertiary,
        unselectedLabelStyle: const TextStyle(fontFamily: 'Gilroy Medium'),
        currentIndex: navigationProvider.selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.mic, color:  greyColor),
              activeIcon: Icon(EvaIcons.mic, size:50.0, color:  Theme.of(context).colorScheme.primary),
              label: 'Grabar'),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.file , color: greyColor),
              activeIcon: Icon(EvaIcons.file, size:50.0, color: Theme.of(context).colorScheme.primary ),
              label: 'Historial',
               
                  ),
         
        ],
        onTap: (index) {
          setState(() {});
          navigationProvider.setPage(index);
        },
      )
    );
  }
}