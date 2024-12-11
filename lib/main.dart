import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'common.dart';
import 'excel_like_table.dart';
import 'layout.dart';


void setupWindow() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  windowManager.setMinimumSize(const Size(600, 400));

  // 配置窗口关闭时拦截行为
  windowManager.setPreventClose(true);
}

void main(List<String> args) async {
  setupWindow();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tab Layout',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    // 关闭子窗口
    for (var window in childWindows.values) {
      await window.close();
    }
    childWindows.clear();

    final bool isPreventClose = await windowManager.isPreventClose();
    if (!isPreventClose) return;
    if (!mounted) return;

    // 允许窗口关闭
    await windowManager.setPreventClose(false);
    await windowManager.close();
  }

  @override
  Widget build(BuildContext context) {
    // Update your pageArray
    final List<List<dynamic>> pageArray = [
      [const NavigationRailDestination(icon: Icon(Icons.crop_square),   label: Text('Container')),  const LayoutContainer()],
      [const NavigationRailDestination(icon: Icon(Icons.view_stream),   label: Text('Column')),     const LayoutColumn()],
      [const NavigationRailDestination(icon: Icon(Icons.view_list),     label: Text('Row')),        const LayoutRow()],
      [const NavigationRailDestination(icon: Icon(Icons.layers),        label: Text('Stack')),      const LayoutStack()],
      [const NavigationRailDestination(icon: Icon(Icons.grid_view),     label: Text('GridView')),   const LayoutGridView()],
      [const NavigationRailDestination(icon: Icon(Icons.list),          label: Text('ListView')),   const LayoutListView()],
      [const NavigationRailDestination(icon: Icon(Icons.swap_vert),     label: Text('Flex')),       const LayoutFlex()],
      [const NavigationRailDestination(icon: Icon(Icons.wrap_text),     label: Text('Wrap')),       const LayoutWrap()],
      [const NavigationRailDestination(icon: Icon(Icons.format_align_center), label: Text('Align')), const LayoutAlign()],
      [const NavigationRailDestination(icon: Icon(Icons.pages),         label: Text('PageView')),   const LayoutPageView()],
      [const NavigationRailDestination(icon: Icon(Icons.table_rows),    label: Text('Table')),      const LayoutTable()],
      [const NavigationRailDestination(icon: Icon(Icons.fit_screen),    label: Text('Expanded')),   const LayoutExpanded()],
      [const NavigationRailDestination(icon: Icon(Icons.format_align_center), label: Text('Center')), const LayoutCenter()],
      [const NavigationRailDestination(icon: Icon(Icons.dashboard),     label: Text('Scaffold')),   const LayoutScaffold()],
      [const NavigationRailDestination(icon: Icon(Icons.table_chart),     label: Text('Excel')),      const ExcelLikePage()],
      [const NavigationRailDestination(icon: Icon(Icons.widgets),       label: Text('Components')), const FlutterComponentsPage()],
    ];

    Widget page;
    page = pageArray[_selectedIndex][1];
    final List<NavigationRailDestination> destinations = pageArray.map((item) {
      return item[0] as NavigationRailDestination;
    }).toList();

    return LayoutBuilder(builder: (context, constraints) {
      BoxConstraints homePageConstraints = constraints;
      return Row(
        children: [
          ScrollableNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: destinations,
            isExtended: homePageConstraints.maxWidth >= 1300,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child: page,
            ),
          ),
        ],
      );
    });
  }
}
