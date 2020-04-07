# Project Structure

I use a MVVM Approach like it is described here
[https://www.filledstacks.com/post/flutter-architecture-my-provider-implementation-guide/](https://www.filledstacks.com/post/flutter-architecture-my-provider-implementation-guide/)

## Service Locator (Dependency Injection)

- The package get_it is used for this
  - [https://pub.dev/packages/get_it](https://pub.dev/packages/get_it)
- can be found in locator.dart
  - register the Service there like this

## Services - Repositories

All data is stored in repositories and also most of the logic will be done here. View Models just call the required functions from services or repositories.

- If a new service is added it needs to be added to get_it in the locator.dart

        setupLocator() {
          getIt.registerSingleton(AuthService());
          getIt.registerSingleton(Api());
          getIt.registerSingleton(SharedPreferencesHelper());
        }

        //Calling a service in e.g. a viewModel
        getIt<AuthService>().logout();

## Views

The folder /views holds Screens and View Models

- /screens

  - The Base Widget in the build method is ViewModelProvider from the link above. This is basically just a Consumer which listens to changes notifed in the View Models
  - In 90% of the cases there is no statemanagement done within a screen.

    - Exceptions are some times dialogs or if it is really just one variable and easy to understand

    @override
    Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
    viewModel: HomeViewModel(),
    builder: (context, model, child) => Scaffold(
    body: model.isLoading
    ? CustomLoadingIndicator()
    : ListView()
    );
    })

- /viewmodels

  - The View Models extend a BaseViewmodel which extends Change Notifier and the state is held here and updated with notifyListeners()

    abstract class BaseViewModel extends ChangeNotifier {
    bool isLoading = false;

        void setLoading(bool loading) {
          isLoading = loading;
          notifyListeners();
        }

    }

    class HomeViewModel extends BaseViewModel {}

- /widgets
  - Widgets that can reused for multiple screens or widgets that are a lot of code

## Routing

Routing is done with the help of Get → [https://pub.dev/packages/get](https://pub.dev/packages/get)

- can be found in router.dart
- Is also used for showing dialogs from a view model
- With this package you can use navigation without context
- Adding a new route

  //router.dart

  //define a route
  const String HomeRoute = '/home';

  //add route to switch case
  case HomeRoute:
  return GetRoute(settings: settings, page: HomeScreen());

  //login_view_model.dart

  //navigate to screen
  Get.offAllNamed(HomeRoute);
  //or
  Get.toNamed(HomeRoute);

## Internationalisation

Flutter Intl plugin is used

- VS Code → [https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl)
- Android Studio → [https://plugins.jetbrains.com/plugin/13666-flutter-intl](https://plugins.jetbrains.com/plugin/13666-flutter-intl)

Adding a new Translation

- Go to /I10n/intl_en.arb and add desired String
- Code will be generated once the file is saved

  //intl_en.arb
  {
  "login_buttonTitle": "Login",
  }

  //Usage in UI
  Text(S.of(context).login_buttonTitle)

## Models

lib/models/

## Styles

- Colors and Textsyles can be found

→ styles.dart

## Logging

Package logger is used → [https://pub.dev/packages/logger](https://pub.dev/packages/logger)

- can be found in logger.dart

  //create logger with classname
  final logger = getLogger("Api");

  //call logger
  logger.e("error: \${error.message}");
