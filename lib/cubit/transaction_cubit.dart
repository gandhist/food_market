import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_market/models/models.dart';
import 'package:food_market/services/services.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  // fungsi koneksi ke api service untuk get transaction
  Future<void> getTransaction() async {
    ApiReturnValue<List<Transaction>> result =
        await TransactionServices.getTransactions();
    if (result.value != null) {
      emit(TransactionLoaded(result.value));
    } else {
      emit(TransactionLoadedFailed(result.message));
    }
  }

  // fungsi handle submit, bernilai boolean
  Future<bool> submitTransaction(Transaction transaction) async {
    ApiReturnValue<Transaction> result =
        await TransactionServices.submitTransaction(transaction);
    if (result.value != null) {
      // jika berhasil maka akan meng emit state saat ini dan hasil result value
      emit(TransactionLoaded(
          (state as TransactionLoaded).transaction + [result.value]));
      return true;
    } else {
      return false;
    }
  }
}
