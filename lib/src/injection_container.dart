import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'client/client.dart';
import 'core/platform/network_info.dart';
import 'features/accounts/accounts.dart';

Future<GetIt> init({required SharedPreferences sharedPreferences}) async {
  final GetIt sl = GetIt.instance;
  // core
  sl.registerFactory<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
  // features
  // feature: accounts
  sl.registerLazySingleton(() => AccountsBloc(
        addAccount: sl(),
        removeAccount: sl(),
        getAllAccounts: sl(),
        accountRepository: sl(),
      )..add(LoadAccounts()));
  sl.registerLazySingleton(() => AddAccount(sl()));
  sl.registerLazySingleton(() => RemoveAccount(sl()));
  sl.registerLazySingleton(() => GetAllAccounts(sl()));
  sl.registerLazySingleton<AccountRepository>(
      () => LocalAccountRepository(sl())..load());
  sl.registerLazySingleton<AccountsLocalDataSource>(
      () => SharedPreferencesAccountsLocalDataSource(sl()));
  // externals
  sl.registerFactory(() => sharedPreferences);
  final Client client = ClientTrello();
  sl.registerFactory(() => client);
  return sl;
}
