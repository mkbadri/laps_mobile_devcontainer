import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';
import '../packages/popup.dart';
import '../packages/popup_content.dart';

class Test2 {
  showPopup(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 30,
        left: 30,
        right: 30,
        bottom: 50,
        child: PopupContent(
          content: Scaffold(
            appBar: AppBar(
              title: Text(title),
              leading: new Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    try {
                      Navigator.pop(context); //close the popup
                    } catch (e) {}
                  },
                );
              }),
              brightness: Brightness.light,
            ),
            resizeToAvoidBottomInset: false,
            body: widget,
          ),
        ),
      ),
    );
  }

  Widget _popupBody() {
    return Container(
      child: Zoom(
          width: 180,
          height: 180,
          child: Center(
            child: Image(
              image: AssetImage('assets/Ember_logo.png'),
            ),
          )),
    );
  }
}
