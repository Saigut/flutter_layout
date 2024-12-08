import 'package:flutter/material.dart';

// Layout pages implementation

class LayoutContainer extends StatelessWidget {
  const LayoutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Container Layout')),
      body: Container(
          color: Colors.blue,
          width: 100,
          height: 100,
      ),
    );
  }
}

class LayoutColumn extends StatelessWidget {
  const LayoutColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Column Layout')),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('First Item'),
          Text('Second Item'),
          Text('Third Item'),
        ],
      ),
    );
  }
}

class LayoutRow extends StatelessWidget {
  const LayoutRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Row Layout')),
      body: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('First Item'),
          Text('Second Item'),
          Text('Third Item'),
        ],
      ),
    );
  }
}

class LayoutStack extends StatelessWidget {
  const LayoutStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stack Layout')),
      body: Stack(
        children: [
          Container(color: Colors.red, width: 200, height: 200),
          Positioned(
            top: 50,
            left: 50,
            child: Container(color: Colors.green, width: 100, height: 100),
          ),
        ],
      ),
    );
  }
}

class LayoutGridView extends StatelessWidget {
  const LayoutGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GridView Layout')),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(4, (index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Center(child: Text('Item $index')),
          );
        }),
      ),
    );
  }
}

class LayoutListView extends StatelessWidget {
  const LayoutListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView Layout')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}

class LayoutFlex extends StatelessWidget {
  const LayoutFlex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flex Layout')),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(child: Container(color: Colors.red, height: 100)),
          Expanded(child: Container(color: Colors.green, height: 100)),
          Expanded(child: Container(color: Colors.blue, height: 100)),
        ],
      ),
    );
  }
}

class LayoutWrap extends StatelessWidget {
  const LayoutWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wrap Layout')),
      body: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: List.generate(6, (index) {
          return Chip(label: Text('Chip $index'));
        }),
      ),
    );
  }
}

class LayoutAlign extends StatelessWidget {
  const LayoutAlign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Align Layout')),
      body: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          color: Colors.purple,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}

class LayoutPageView extends StatelessWidget {
  const LayoutPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PageView Layout')),
      body: PageView(
        children: [
          Container(color: Colors.red),
          Container(color: Colors.green),
          Container(color: Colors.blue),
        ],
      ),
    );
  }
}

class LayoutTable extends StatelessWidget {
  const LayoutTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Table Layout')),
      body: Table(
        border: TableBorder.all(),
        children: const [
          TableRow(children: [
            Text('Cell 1'),
            Text('Cell 2'),
            Text('Cell 3'),
          ]),
          TableRow(children: [
            Text('Cell 4'),
            Text('Cell 5'),
            Text('Cell 6'),
          ]),
        ],
      ),
    );
  }
}

class LayoutExpanded extends StatelessWidget {
  const LayoutExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expanded Layout')),
      body: Column(
        children: [
          Expanded(child: Container(color: Colors.red)),
          Expanded(child: Container(color: Colors.green)),
          Expanded(child: Container(color: Colors.blue)),
        ],
      ),
    );
  }
}

class LayoutCenter extends StatelessWidget {
  const LayoutCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Center Layout')),
      body: const Center(
        child: Text('This is a Center widget example!'),
      ),
    );
  }
}

class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scaffold Layout')),
      body: Scaffold(
        appBar: AppBar(title: const Text('Scaffold appBar')),
        body: const Center(
          child: Text('Scaffold body'),
        ),
      ),
    );
  }
}

class ScrollableNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationRailDestination> destinations;
  final bool isExtended;

  const ScrollableNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    this.isExtended = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool extended = isExtended;

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: NavigationRail(
                extended: extended,
                selectedIndex: selectedIndex,
                onDestinationSelected: onDestinationSelected,
                destinations: destinations,
              ),
            ),
          ),
        );
      },
    );
  }
}