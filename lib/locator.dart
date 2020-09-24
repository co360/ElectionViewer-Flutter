import 'package:get_it/get_it.dart';

import 'bloc/bloc.dart';
// import 'model/model.dart';
import 'service/service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  // Waiting for first launch
  locator.registerLazySingleton(() => CoreService(), instanceName: 'Service Core');
  locator.registerLazySingleton(() => AuthService(), instanceName: 'Service Auth');
  locator.registerLazySingleton(() => UserService.admin(), instanceName: 'Service Admin');
  locator.registerLazySingleton(() => UserService.pemantau(), instanceName: 'Service Pemantau');
  locator.registerLazySingleton(() => KecamatanService(), instanceName: 'Service Kecamatan');
  locator.registerLazySingleton(() => KelurahanService(), instanceName: 'Service Kelurahan');
  locator.registerLazySingleton(() => CalonService(), instanceName: 'Service Calon');
  locator.registerLazySingleton(() => SuaraService(), instanceName: 'Service Suara');
  
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
  await locator<CoreService>(instanceName: 'Service Core').init();
  await locator<AuthService>(instanceName: 'Service Auth').init();

  // print("setup locator success");
}