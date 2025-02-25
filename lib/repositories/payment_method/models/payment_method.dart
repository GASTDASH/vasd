import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  const PaymentMethod({
    required this.paymentMethodId,
    required this.name,
    required this.text,
    this.description,
    this.image,
  });

  final int paymentMethodId;
  final String name;
  final String text;
  final String? description;
  final String? image;

  @override
  List<Object?> get props => [paymentMethodId, name, text];
}
