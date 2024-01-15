import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FloatingActionMenuButton extends StatefulWidget {
  const FloatingActionMenuButton({Key? key}) : super(key: key);

  @override
  State<FloatingActionMenuButton> createState() =>
      _FloatingActionMenuButtonState();
}

class _FloatingActionMenuButtonState extends State<FloatingActionMenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  OverlayEntry? _overlayEntry;
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  void _toggleMenu() {
    if (isMenuOpen) {
      _overlayEntry?.remove();
      _animationController.reverse();
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      _animationController.forward();
    }
    isMenuOpen = !isMenuOpen;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx - (size.width * 3.75),
        top: offset.dy - size.height * 1,
        width: size.width * 4,
        height: size.height * 3,
        child: Material(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildFloatingButton(FontAwesomeIcons.facebookF, Colors.blue),
              _buildFloatingButton(
                  FontAwesomeIcons.linkedinIn, Colors.blue[700]!),
              _buildFloatingButton(FontAwesomeIcons.instagram, Colors.pink),
              _buildFloatingButton(
                  FontAwesomeIcons.whatsapp, Colors.green[500]!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingButton(IconData icon, Color color) {
    var theme = Theme.of(context);
    return FloatingActionButton(
      mini: true,
      backgroundColor: theme.brightness == Brightness.dark
          ? Theme.of(context).iconTheme.color
          : Theme.of(context).colorScheme.background,
      child: Icon(icon, color: color),
      onPressed: () {
        _toggleMenu();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FloatingActionButton(
      backgroundColor: theme.brightness == Brightness.dark
          ? Theme.of(context).iconTheme.color
          : Theme.of(context).colorScheme.background,
      onPressed: _toggleMenu,
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animationController,
        color: theme.brightness == Brightness.dark
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).iconTheme.color,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
