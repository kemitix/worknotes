import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknotes/src/client/client.dart';
import 'package:worknotes/src/core/platform/network_info.dart';
import 'package:worknotes/src/features/accounts/data/datasources/accounts_local_datasource.dart';
import 'package:worknotes/src/features/accounts/data/repositories/local_account_repository.dart';
import 'package:worknotes/src/features/accounts/domain/usecases/add_account.dart';
import 'package:worknotes/src/features/accounts/domain/usecases/get_all_accounts.dart';
import 'package:worknotes/src/features/accounts/domain/usecases/remove_account.dart';
import 'package:worknotes/src/features/accounts/presentation/bloc/accounts_bloc.dart';

final GetIt sl = GetIt.instance();

Future<void> init() async {
  // core
  final NetworkInfo networkInfo = NetworkInfoImpl(Connectivity());
  sl.registerFactory(() => networkInfo);
  // features
  // feature: accounts
  sl.registerSingleton(AccountsBloc(addAccount: sl(), removeAccount: sl()));
  sl.registerLazySingleton(() => AddAccount(sl()));
  sl.registerLazySingleton(() => RemoveAccount(sl()));
  sl.registerLazySingleton(() => GetAllAccounts(sl()));
  sl.registerLazySingleton(() => LocalAccountRepository(sl()));
  sl.registerLazySingleton(
      () => SharedPreferencesAccountsLocalDataSource(sl()));
  // externals
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerFactory(() => sharedPreferences);
  final Client client = ClientTrello();
  sl.registerFactory(() => client);
}
