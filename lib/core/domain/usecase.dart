import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/data/generics/resource.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Resource<Type>> execute(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
