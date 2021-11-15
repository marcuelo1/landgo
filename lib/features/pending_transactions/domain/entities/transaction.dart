import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final int id;
  final String status;

  Transaction({
    required this.id, 
    required this.status
  }) : super();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}