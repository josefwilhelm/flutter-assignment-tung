import 'package:flutter/material.dart';
import 'package:flutter_assessment/generated/l10n.dart';
import 'package:flutter_assessment/views/view_models/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
        viewModel: HomeViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(S.of(context).home_appTitle),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: model.onLogoutPressed,
                )
              ],
            ),
            body: Center(
              child: Text("Home"),
            )));
  }
}
