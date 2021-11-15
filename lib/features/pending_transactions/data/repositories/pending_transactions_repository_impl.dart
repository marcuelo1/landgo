import 'package:landgo_seller/features/pending_transactions/domain/entities/transaction.dart';
import 'package:landgo_seller/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:landgo_seller/features/pending_transactions/domain/repositories/pending_transactions_repository.dart';

class PendingTransactionsRepositoryImpl implements PendingTransactionsRepository {
  @override
  Future<Either<Failure, Transaction>> getPendingTransactions() {
    // TODO: implement getPendingTransactions
    throw UnimplementedError();
  }
  
}