import 'package:flutter/material.dart';
import 'package:flutter_assessment/generated/l10n.dart';
import 'package:flutter_assessment/locator.dart';
import 'package:flutter_assessment/views/view_models/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final viewModel =
      HomeViewModel(appointmentService: getIt(), workOrderService: getIt());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.onFetchingData();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
        viewModel: viewModel,
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
