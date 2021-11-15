import 'package:dartz/dartz.dart';
import 'package:landgo_seller/core/error/failures.dart';
import 'package:landgo_seller/core/usecases/usecase.dart';
import 'package:landgo_seller/features/pending_transactions/domain/entities/transaction.dart';

abstract class PendingTransactionsRepository {
  Future<Either<Failure, Transaction>> getPendingTransactions();
}