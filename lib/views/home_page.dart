import 'package:flutter/material.dart';
import 'package:flutter_web_browser/controllers/home_controller.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  MyHomePage({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return WebviewScaffold(
          appBar: AppBar(
            title: Row(
              children: [
                IconButton(
                    onPressed: () {
                      flutterWebViewPlugin.goBack();
                    },
                    icon: Icon(Icons.arrow_back)),
                IconButton(
                    onPressed: () {
                      flutterWebViewPlugin.goForward();
                    },
                    icon: Icon(Icons.arrow_forward)),
                IconButton(
                    onPressed: () {
                      // flutterWebViewPlugin.reload();
                      Fluttertoast.showToast(msg: "Reloading");
                    },
                    icon: Icon(Icons.refresh)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        onSaved: (newValue) {
                          controller.url.value = newValue!;
                        },
                        decoration: InputDecoration(hintText: "Enter an URL"),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        flutterWebViewPlugin
                            .reloadUrl("https://${controller.url.value}");
                      }
                    },
                    icon: Icon(Icons.threesixty_rounded))
              ],
            ),
          ),
          url: "https://${controller.url.value}",
        );
      },
    );
  }
}
