import 'package:flutter/material.dart';

enum OrderStatus { delivered, processing, cancelled, shipped }

class OrderModel {
  final String id;
  final String date;
  final double totalPrice;
  final int itemsCount;
  final OrderStatus status;

  OrderModel({
    required this.id,
    required this.date,
    required this.totalPrice,
    required this.itemsCount,
    required this.status,
  });

  String get statusText {
    switch (status) {
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.shipped:
        return 'Shipped';
    }
  }

  Color get statusColor {
    switch (status) {
      case OrderStatus.delivered:
        return const Color(0xFF4CAF50);
      case OrderStatus.processing:
        return const Color(0xFF2196F3);
      case OrderStatus.cancelled:
        return const Color(0xFFE53935);
      case OrderStatus.shipped:
        return const Color(0xFFFF9800);
    }
  }

  Color get statusBg {
    switch (status) {
      case OrderStatus.delivered:
        return const Color(0xFFE8F5E9);
      case OrderStatus.processing:
        return const Color(0xFFE3F2FD);
      case OrderStatus.cancelled:
        return const Color(0xFFFEEBEE);
      case OrderStatus.shipped:
        return const Color(0xFFFFF3E0);
    }
  }
}
