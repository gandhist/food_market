part of 'services.dart';

class TransactionServices {
  static Future<ApiReturnValue<List<Transaction>>> getTransactions() async {
    await Future.delayed(Duration(seconds: 5));
    return ApiReturnValue(value: mockTransaction);
  }

  // fungsi submit transaction
  static Future<ApiReturnValue<Transaction>> submitTransaction(
      Transaction transaction) async {
    await Future.delayed(Duration(seconds: 3));
    // return ApiReturnValue(message: "Transaksi gagal cuys");
    return ApiReturnValue(
        value:
            transaction.copyWith(id: 123, status: TransactionStatus.pending));
  }
}
