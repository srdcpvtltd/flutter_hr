import 'package:cnattendance/provider/aboutprovider.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about';

  final String title;

  AboutScreen(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AboutProvider(), child: About(title));
  }
}

class About extends StatefulWidget {
  final String title;

  About(this.title, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AboutScreenState();
}

class AboutScreenState extends State<About> {
  var initialState = true;
  var isLoading = false;

  @override
  void didChangeDependencies() {
    if (initialState) {
      getContent();
      initialState = false;
    }
    super.didChangeDependencies();
  }

  void getContent() async {
    try {
      setState(() {
        isLoading = true;
        EasyLoading.show(
            status: translate('loader.loading'), maskType: EasyLoadingMaskType.black);
      });
      await Provider.of<AboutProvider>(context).getContent(widget.title);
      setState(() {
        isLoading = false;
        EasyLoading.dismiss(animation: true);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        EasyLoading.dismiss(animation: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AboutProvider>(context);
    return WillPopScope(
      onWillPop: () async{
        return !isLoading;
      },
      child: Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(provider.content['title']!),
            elevation: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Visibility(
                  visible: isLoading ? false : true,
                  child: Html(
                    style: {
                      "body": Style(color: Colors.white, fontSize: FontSize.medium)
                    },
                    data: provider.content['description']!,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
