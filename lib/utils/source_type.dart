enum SourceType {
  conversion,
  payout,
  deposit,
  transfer,
  refund,
  charge,
  paymentAttempt,
  fee,
  others,
}

class SourceTypeService {
  SourceTypeService._();
  static SourceTypeService instance = SourceTypeService._();

  final List<SourceType> _moneyIn = const [
    SourceType.deposit,
    SourceType.transfer,
    SourceType.refund,
  ];

  final List<SourceType> _moneyOut = const [
    SourceType.payout,
    SourceType.charge,
    SourceType.paymentAttempt,
    SourceType.fee,
  ];

  List<SourceType> get moneyOut => _moneyOut;
  List<SourceType> get moneyIn => _moneyIn;
}
