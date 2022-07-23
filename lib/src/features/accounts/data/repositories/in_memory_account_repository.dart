import '../../../../core/in_memory_repository_mixin.dart';
import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';

class InMemoryAccountRepository extends AccountRepository
    with InMemoryRepository<Account> {}
