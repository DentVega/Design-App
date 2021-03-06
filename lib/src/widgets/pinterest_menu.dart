import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final Function onPressed;
  final IconData icon;

  PinterestButton({@required this.onPressed, @required this.icon});
}

class PinterestMenu extends StatelessWidget {
  final bool mostrar;

  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<PinterestButton> items;

  PinterestMenu(
      {this.mostrar = true,
      this.backgroundColor = Colors.white,
      this.activeColor = Colors.black,
      this.inactiveColor = Colors.blueGrey,
      @required this.items});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: Builder(
        builder: (BuildContext context) {
          Provider.of<_MenuModel>(context, listen: false).backgroundColor =
              backgroundColor;
          Provider.of<_MenuModel>(context, listen: false).activeColor =
              activeColor;
          Provider.of<_MenuModel>(context, listen: false).inactiveColor =
              inactiveColor;

          return AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: (mostrar) ? 1 : 0,
            child: _PinterestMenuBackground(
              child: _MenuItems(
                menuItems: items,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;

  const _PinterestMenuBackground({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
          color:
              Provider.of<_MenuModel>(context, listen: false).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: [
            BoxShadow(color: Colors.black38, blurRadius: 10, spreadRadius: -5)
          ]),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;

  const _MenuItems({this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length,
          (index) => _PinterestMenuButton(index, menuItems[index])),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  int index;
  final PinterestButton item;

  _PinterestMenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final itemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;

    return GestureDetector(
      onTap: () {
        item.onPressed();
        Provider.of<_MenuModel>(context, listen: false).itemSeleccionado =
            index;
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icon,
          size: (itemSeleccionado == index) ? 35 : 25,
          color: (itemSeleccionado == index)
              ? Provider.of<_MenuModel>(context, listen: false).activeColor
              : Provider.of<_MenuModel>(context, listen: false).inactiveColor,
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _itemSeleccionado = 0;
  Color _backgroundColor = Colors.white;
  Color _activeColor = Colors.black;
  Color _inactiveColor = Colors.blueGrey;

  get itemSeleccionado => this._itemSeleccionado;

  set itemSeleccionado(int itemSeleccionado) {
    this._itemSeleccionado = itemSeleccionado;
    notifyListeners();
  }

  get backgroundColor => _backgroundColor;

  set backgroundColor(Color color) {
    this._backgroundColor = color;
  }

  get activeColor => _activeColor;

  set activeColor(Color color) {
    this._activeColor = color;
  }

  get inactiveColor => _inactiveColor;

  set inactiveColor(Color color) {
    this._inactiveColor = color;
  }
}
