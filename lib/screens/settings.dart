import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neptune/router/router.dart';
import 'package:neptune/widgets/custom_text_button.dart';
import 'package:neptune/widgets/icon_button.dart';
import 'package:neptune/widgets/svg_title.dart';
import 'package:neptune/widgets/widget_padding.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg/lod.png'), fit: BoxFit.cover)),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color.fromRGBO(0, 0, 0, 0.5),
              ],
            ),
            backgroundBlendMode: BlendMode.darken,
          ),
          child: SafeArea(
            child: WidgetPadding(
              child: Stack(
                children: [
                  CustomIconButton(
                    path: 'assets/icons/back.svg',
                    callback: context.router.pop,
                  ),
                  const SvgTitle(path: 'assets/titles/settings.svg'),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Builder(builder: (_) {
                            return CustomTextButton(
                                callback: (p0) {
                                  final box =
                                      _.findRenderObject() as RenderBox?;
                                  Share.share(
                                      'Check out this Wild Fortune game!',
                                      sharePositionOrigin:
                                          box!.localToGlobal(Offset.zero) &
                                              box.size);
                                },
                                children: [
                                  Text('Share with friends',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge)
                                ]);
                          }),
                        ),
                        CustomTextButton(
                            callback: (_) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WildPriv(
                                    wildsa:
                                        'https://docs.google.com/document/d/1K-Nnv_I1Q4qKoCkJtHoO8qIz1cGB7YKsOhErOgsV994/edit?usp=sharing'),
                              ));
                            },
                            children: [
                              Text('Privacy Policy',
                                  style:
                                      Theme.of(context).textTheme.displayLarge)
                            ]),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CustomTextButton(
                              callback: (_) {
                                 Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WildPriv(
                                    wildsa:
                                        'https://docs.google.com/document/d/1uxHHIBp4E5zTjevNxYQxj_hdj1hslqxJoPSttgqkDx4/edit?usp=sharing'),
                              ));
                              },
                              children: [
                                Text('Terms of use',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge)
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WildPriv extends StatefulWidget {
  const WildPriv({super.key, required this.wildsa});
  final String wildsa;

  @override
  State<WildPriv> createState() => _WildPrivState();
}

class _WildPrivState extends State<WildPriv> {
  var _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            InAppWebView(
              onLoadStop: (controller, url) {
                controller.evaluateJavascript(
                    source:
                        "javascript:(function() { var ele=document.getElementsByClassName('docs-ml-header-item docs-ml-header-drive-link');ele[0].parentNode.removeChild(ele[0]);var footer = document.getelementsbytagname('footer')[0];footer.parentnode.removechild(footer);})()");
              },
              onProgressChanged: (controller, progress) => setState(() {
                _progress = progress;
              }),
              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.wildsa),
              ),
            ),
            if (_progress != 100)
              Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}