import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';

import 'error/failure.dart';
import 'has_id_name.dart';

abstract class Repository<T extends HasIdName> extends ChangeNotifier {
  Future<Either<Failure, T>> add(T item);

  Future<Either<Failure, T>> remove(T item);

  Future<Either<Failure, T>> update(int index, T item);

  Future<Either<Failure, List<T>>> getAll();

  Future<Either<Failure, T>> findById(ObjectId objectId);

  Future<Either<Failure, T>> findByName(String name);
}
