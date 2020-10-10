import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
