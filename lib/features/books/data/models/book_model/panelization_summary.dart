import 'package:hive/hive.dart';

part 'panelization_summary.g.dart';

@HiveType(typeId: 4)
class PanelizationSummary {
  @HiveField(0)
  bool? containsEpubBubbles;
  @HiveField(1)
  bool? containsImageBubbles;

  PanelizationSummary({
    this.containsEpubBubbles,
    this.containsImageBubbles,
  });

  factory PanelizationSummary.fromJson(Map<String, dynamic> json) {
    return PanelizationSummary(
      containsEpubBubbles: json['containsEpubBubbles'] as bool?,
      containsImageBubbles: json['containsImageBubbles'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'containsEpubBubbles': containsEpubBubbles,
        'containsImageBubbles': containsImageBubbles,
      };
}
