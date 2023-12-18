// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:arche/arche.dart';
import 'package:arche/extensions/iter.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:onenavigation/impl/data.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _StateHomePage();
}

class _StateHomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    window.onResize.listen((event) {
      setState(() {});
    });
  }

  List<Row> generateContent() {
    var con = <Row>[];
    List data = ArcheBus.config.getOr("links", []).toList();
    while (data.isNotEmpty) {
      var tmp = <Widget>[];
      for (var _ = 0; _ < 3; _++) {
        if (data.isEmpty) {
          break;
        }
        var v = data[0];
        data.removeAt(0);
        tmp.add(FilledButton(
            onPressed: () => launchUrlString(v["link"] ?? ""),
            child: Text(v["name"] ?? "Unknown")));
      }
      con.add(Row(children: tmp));
    }
    return con;
  }

  BlurImage getBlurImage() {
    Map data = ArcheBus.config.getOr("image", {});
    var type = data["type"] ?? "local";
    switch (type) {
      case "network":
        return BlurImage(NetworkImage(data["text"] ?? ""),
            coloropacity: data["coloropactiy"] ?? 0.3, blur: data["blur"] ?? 0);
      default:
        return BlurImage(const AssetImage("resource/card.png"),
            coloropacity: data["coloropactiy"] ?? 0.3, blur: data["blur"] ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var config = ArcheBus.config;
    var width = window.innerWidth?.toDouble() ?? 3000;
    var height = window.innerHeight?.toDouble() ?? 1200;
    if (height > width) {
      width = width / 3 * 1.8;
      height = height / 5;
    } else {
      width = width / 3 * 1.6;
      height = height / 4 * 1.8;
    }
    var widthfac = width / 750;
    var heightfac = height / 500;
    var averagefac = (widthfac + heightfac) / 2;
    var image = getBlurImage();
    return Scaffold(
      body: Center(
        child: Card(
            elevation: 20,
            child: SizedBox(
                width: width,
                height: height,
                child: Row(children: [
                  Blur(
                      blur: image.blur,
                      colorOpacity: image.coloropacity,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: image.provider)),
                          child: SizedBox(
                            height: height,
                            width: width / 3,
                          ))),
                  SizedBox(
                    height: height,
                    width: width / 3 * 2,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              config.getOr(
                                "title",
                                "One Navigation",
                              ),
                              style: TextStyle(fontSize: 36 * averagefac),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: FittedBox(
                              child: Column(
                                children: generateContent()
                                    .cast<Widget>()
                                    .joinElement(const SizedBox(
                                      height: 5,
                                    )),
                              ),
                            ))
                      ],
                    ),
                  )
                ]))),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.transparent,
        child: Center(
          child: Text(config.getOr("footer", "")),
        ),
      ),
    );
  }
}
