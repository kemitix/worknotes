import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'error/failure.dart';

abstract class Repository<T> extends ChangeNotifier {
  Future<Either<Failure, T>> add(T item);

  Future<Either<Failure, T>> remove(T item);

  Future<Either<Failure, T>> update(int index, T item);

  Future<Either<Failure, List<T>>> getAll();
}
