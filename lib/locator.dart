import 'package:get_it/get_it.dart';

import 'bloc/bloc.dart';
// import 'model/model.dart';
import 'service/service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  // Waiting for first launch
  locator.registerLazySingleton(() => CoreService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => PemantauService());
  // locator.registerLazySingleton(() => MovieService(), instanceName: 'Movie Service');
  // locator.registerLazySingleton(() => LocalService(), instanceName: 'Local Service');
  // locator.registerLazySingleton(() => TicketService(), instanceName: 'Ticket Service');
  // locator.registerLazySingleton(() => TransactionService(), instanceName: 'Transaction Service');
  
  locator.registerFactory(() => TypeSelectionBloc());
  locator.registerFactory(() => LogInAdminBloc());
  locator.registerFactory(() => LogInPemantauBloc());
  locator.registerFactory(() => DataViewerBloc());
  locator.registerFactory(() => PemilihanTempatBloc());
  locator.registerFactory(() => InputDataBloc());
  // locator.registerFactory(() => SignInBloc());
  // locator.registerFactory(() => SignUpBloc());
  // locator.registerFactory(() => PreferenceBloc());
  // locator.registerFactory(() => ProfileBloc());
  // locator.registerFactory(() => EditProfileBloc());
  // locator.registerFactory(() => MyTicketsBloc());
  // locator.registerFactory(() => MyTransactionBloc());
  // locator.registerFactory(() => SearchBloc());

  // locator.registerSingleton<Ticket>(Ticket.initial(), instanceName: 'Ticket');
  // locator.registerSingleton<User>(User.initial(), instanceName: 'User Active');
}

Future<void> awaitSetupLocator() async {
  
  await locator.allReady();

  // Setup service
  await locator.get<CoreService>(instanceName: 'Core Service').init();
  await locator.get<AuthService>(instanceName: 'Auth Service').init();
  // await locator.get<LocalService>(instanceName: 'Local Service').init();

  // Setup first bloc
  // await locator.get<HomeBloc>().init();

  // print("setup locator success");
}