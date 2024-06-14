import 'package:flutter/material.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';

class BaseBottomNavigationBar extends StatefulWidget {
  const BaseBottomNavigationBar({
    this.initialIndex = 0,
    required this.items,
    this.backgroundColor = Colors.white,
    Key? key,
  }) : super(key: key);

  final int initialIndex;
  final List<BaseBottomNavigationBarItem> items;
  final Color backgroundColor;

  @override
  State<BaseBottomNavigationBar> createState() => _BaseBottomNavigationBarState();
}

class _BaseBottomNavigationBarState extends State<BaseBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 90,
        minHeight: 80,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      color: widget.backgroundColor,
      child: SafeArea(
        top: false,
        child: Row(
          children: _buildItems(),
        ),
      ),
    );
  }

  List<Widget> _buildItems() {
    final List<Widget> normalizedItems = <Widget>[];

    for (int i = 0; i < widget.items.length; i++) {
      if (i == _currentIndex) {
        normalizedItems.add(_buildActiveItem(i, widget.items[i]));
        continue;
      }
      normalizedItems.add(_buildInactiveItem(i, widget.items[i]));
    }
    return normalizedItems;
  }

  Widget _buildActiveItem(int index, BaseBottomNavigationBarItem baseItem) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() {
          _currentIndex = index;
        }),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 18,
          ),
          child: Column(
            children: <Widget>[
              baseItem.activeIcon,
              Spacings.verSpace(10),
              Text(
                baseItem.activeLabel,
                style: baseItem.activeTextStyleLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInactiveItem(int index, BaseBottomNavigationBarItem baseItem) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() {
          _currentIndex = index;
        }),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 18,
          ),
          child: Column(
            children: <Widget>[
              baseItem.inactiveIcon,
              Spacings.verSpace(10),
              Text(
                baseItem.inactiveLabel,
                style: baseItem.inactiveTextStyleLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BaseBottomNavigationBarItem {
  const BaseBottomNavigationBarItem({
    required this.activeIcon,
    required this.activeLabel,
    required this.activeTextStyleLabel,
    required this.inactiveIcon,
    required this.inactiveLabel,
    required this.inactiveTextStyleLabel,
  });

  final Widget activeIcon;
  final String activeLabel;
  final TextStyle activeTextStyleLabel;
  final Widget inactiveIcon;
  final String inactiveLabel;
  final TextStyle inactiveTextStyleLabel;
}
