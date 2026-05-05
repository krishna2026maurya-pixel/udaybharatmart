class UserTrModel {
  bool? success;
  String? walletBalance;
  List<UserTransactionList>? userTransactionList;

  UserTrModel({this.success, this.walletBalance, this.userTransactionList});

  UserTrModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    walletBalance = json['wallet_balance'];
    if (json['user_transaction_list'] != null) {
      userTransactionList = <UserTransactionList>[];
      json['user_transaction_list'].forEach((v) {
        userTransactionList!.add(new UserTransactionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['wallet_balance'] = this.walletBalance;
    if (this.userTransactionList != null) {
      data['user_transaction_list'] =
          this.userTransactionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserTransactionList {
  int? id;
  int? userId;
  String? amt;
  String? operationType;
  String? remark;
  int? status;
  int? isSendToAdmin;
  int? isSendToVendor;
  String? addedDateTime;
  int? bookingId;
  String? createdAt;
  String? updatedAt;
  int? isRecharge;
  String? paymentId;

  UserTransactionList(
      {this.id,
        this.userId,
        this.amt,
        this.operationType,
        this.remark,
        this.status,
        this.isSendToAdmin,
        this.isSendToVendor,
        this.addedDateTime,
        this.bookingId,
        this.createdAt,
        this.updatedAt,
        this.isRecharge,
        this.paymentId});

  UserTransactionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amt = json['amt'];
    operationType = json['operation_type'];
    remark = json['remark'];
    status = json['status'];
    isSendToAdmin = json['is_send_to_admin'];
    isSendToVendor = json['is_send_to_vendor'];
    addedDateTime = json['added_date_time'];
    bookingId = json['booking_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isRecharge = json['is_recharge'];
    paymentId = json['payment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amt'] = this.amt;
    data['operation_type'] = this.operationType;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['is_send_to_admin'] = this.isSendToAdmin;
    data['is_send_to_vendor'] = this.isSendToVendor;
    data['added_date_time'] = this.addedDateTime;
    data['booking_id'] = this.bookingId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_recharge'] = this.isRecharge;
    data['payment_id'] = this.paymentId;
    return data;
  }
}
