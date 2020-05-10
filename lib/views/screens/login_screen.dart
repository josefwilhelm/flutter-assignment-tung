import 'package:flutter/material.dart';
import 'package:flutter_assessment/generated/l10n.dart';
import 'package:flutter_assessment/styles.dart';
import 'package:flutter_assessment/views/view_models/login_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter_assessment/views/widgets/custom_loading_indicator.dart';
import 'package:flutter_assessment/views/widgets/custom_textfield.dart';
import 'package:validators/validators.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModel: LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Image.asset("assets/ic_login.png"),
                )),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Form(
                  key: model.formKey,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(32.0),
                    shrinkWrap: true,
                    children: <Widget>[
                      CustomTextField(
                        label: S.of(context).login_email,
                        hint: S.of(context).login_email,
                        onSubmit: (_) => FocusScope.of(context)
                            .requestFocus(passwordFocusNode),
                        onChanged: model.setEmail,
                        validator: (email) => isEmail(email.trim())
                            ? null
                            : S.of(context).login_emailError,
                      ),
                      smallSpace,
                      CustomTextField(
                        label: S.of(context).login_password,
                        hint: S.of(context).login_password,
                        obscure: true,
                        focusNode: passwordFocusNode,
                        onSubmit: (_) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          model.onLoginPressed();
                        },
                        onChanged: model.setPassword,
                        validator: (password) {
                          Pattern pattern =
                              r'^(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(password))
                            return S.of(context).login_passwordError;
                          else
                            return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      smallSpace,
                      model.isLoading
                          ? CustomLoadingIndicator()
                          : FlatButton(
                              color: accentColor,
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.transparent)),
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                model.onLoginPressed();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  S.of(context).login_loginButtonTitle,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ),
                            ),
                      bigSpace,
                      Center(
                        child: InkWell(
                          onTap: model.onRegisterPressed,
                          child: Text(S.of(context).login_signUp,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: accentColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
