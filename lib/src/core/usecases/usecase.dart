import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:worknotes/src/core/error/failure.dart';

abstract class UseCase<Result, Params> {
  Future<Either<Failure, Result>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
