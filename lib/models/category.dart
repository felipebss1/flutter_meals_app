// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });
}
