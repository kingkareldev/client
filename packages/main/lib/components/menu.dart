import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:main/extensions/string.dart';

import '../router/router_bloc.dart';
import 'inline_hover_button.dart';
import 'overlay_button.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return BlocBuilder<RouterBloc, RouterState>(
      bloc: routerBloc,
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => routerBloc.add(ToHomeRoute()),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        localization.appTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // TODO: if signed in
                    if (true) ...[
                      OverlayButton(
                        onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToStoriesRoute()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(TablerIcons.book),
                            const SizedBox(width: 4),
                            Text(localization.storiesButton.toTitleCase())
                          ],
                        ),
                      ),
                      OverlayButton(
                        onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToStatsRoute()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(TablerIcons.crown),
                            SizedBox(width: 4),
                            Text('42'),
                          ],
                        ),
                      ),
                      OverlayButton(
                        overlayWidth: 110,
                        onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToProfileRoute()),
                        child: const Icon(TablerIcons.face_id),
                        overlay: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InlineHoverButton(
                                onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToProfileRoute()),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Text(localization.profileButton.toTitleCase()),
                                ),
                              ),
                              InlineHoverButton(
                                onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToSettingsRoute()),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Text(localization.settingsButton.toTitleCase()),
                                ),
                              ),
                              InlineHoverButton(
                                onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToInfoRoute()),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Text(localization.aboutUsButton.toTitleCase()),
                                ),
                              ),
                              InlineHoverButton(
                                onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToSignOutRoute()),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Text(localization.signOutButton.toTitleCase()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    // TODO: if not signed in
                    if (true) ...[
                      OverlayButton(
                        onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToSignInRoute()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(TablerIcons.login),
                            const SizedBox(width: 4),
                            Text(localization.signInButton.toTitleCase()),
                          ],
                        ),
                      ),
                      OverlayButton(
                        onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToSignUpRoute()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(TablerIcons.user_plus),
                            const SizedBox(width: 4),
                            Text(localization.signUpButton.toTitleCase())
                          ],
                        ),
                      ),
                    ],
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CountriesField extends StatefulWidget {
  @override
  _CountriesFieldState createState() => _CountriesFieldState();
}

class _CountriesFieldState extends State<CountriesField> {
  final FocusNode _focusNode = FocusNode();

  OverlayEntry? _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry!);
      } else {
        _overlayEntry?.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              //left: _layerLink.leaderSize?.topLeft(renderBox.localToGlobal(Offset.zero)).dx,
              child: Container(
                color: Colors.red,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(0.0, size.height + 5.0),
                  child: Material(
                    elevation: 4.0,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: <Widget>[
                        ListTile(
                          title: const Text('Syria'),
                          onTap: () {
                            print('Syria Tapped');
                          },
                        ),
                        ListTile(
                          title: const Text('Lebanon'),
                          onTap: () {
                            print('Lebanon Tapped');
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        focusNode: _focusNode,
        decoration: const InputDecoration(labelText: 'Country'),
      ),
    );
  }
}
