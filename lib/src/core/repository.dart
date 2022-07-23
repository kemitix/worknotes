import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';

import 'error/failure.dart';
import 'has_id_name.dart';

abstract class Repository<T extends HasIdName> extends ChangeNotifier {
  Future<Either<Failure, T>> add(T item);

  Future<void> remove(T item);

  Future<void> update(int index, T item);

  Future<List<T>> getAll();

  Future<T> findById(ObjectId objectId);

  Future<T> findByName(String name);
}
