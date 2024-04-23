import 'package:flutter/cupertino.dart';

class ExampleCandidateModel {
  String? name;
  String? job;
  String? city;
  LinearGradient? color;

  ExampleCandidateModel({
    this.name,
    this.job,
    this.city,
    this.color,
  });
}

const List<LinearGradient> gradientsList = [
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFF3868),
      Color(0xFFFFB49A),
    ],
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF736EFE),
      Color(0xFF62E4EC),
    ],
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0BA4E0),
      Color(0xFFA9E4BD),
    ],
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFF6864),
      Color(0xFFFFB92F),
    ],
  )
];

const LinearGradient kNewFeedCardColorsIdentityGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF7960F1),
    Color(0xFFE1A5C9),
  ],
);
