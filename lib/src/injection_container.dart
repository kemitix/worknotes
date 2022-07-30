import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'client/client.dart';
import 'core/platform/network_info.dart';
import 'features/accounts/accounts.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // core
  sl.registerFactory<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
  // features
  // feature: accounts
  sl.registerLazySingleton(() => AccountsBloc.load(
        addAccount: sl(),
        removeAccount: sl(),
        getAllAccounts: sl(),
        accountRepository: sl(),
      ));
  sl.registerLazySingleton(() => AddAccount(sl()));
  sl.registerLazySingleton(() => RemoveAccount(sl()));
  sl.registerLazySingleton(() => GetAllAccounts(sl()));
  sl.registerLazySingleton<AccountRepository>(
      () => LocalAccountRepository(sl()));
  sl.registerLazySingleton<AccountsLocalDataSource>(
      () => SharedPreferencesAccountsLocalDataSource(sl()));
  // externals
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerFactory(() => sharedPreferences);
  final Client client = ClientTrello();
  sl.registerFactory(() => client);
}
