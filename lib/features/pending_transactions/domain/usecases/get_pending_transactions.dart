import 'package:dartz/dartz.dart';
import 'package:landgo_seller/core/error/failures.dart';
import 'package:landgo_seller/core/usecases/usecase.dart';
import 'package:landgo_seller/features/pending_transactions/domain/entities/transaction.dart';
import 'package:landgo_seller/features/pending_transactions/domain/repositories/pending_transactions_repository.dart';

class GetPendingTransactions implements UseCase<Transaction, NoParams>{
  final PendingTransactionsRepository repository;

  GetPendingTransactions(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(NoParams) async {
    return await repository.getPendingTransactions();
  }
}