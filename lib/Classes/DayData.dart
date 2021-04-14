import 'dart:convert';

class DayData {
  DayData(
    this.day,
    this.closedCalls,
    this.notAnswered,
    this.toRecall,
    this.recallMeeting,
    this.meeting,
  );
  final String day;
  final int closedCalls;
  final int notAnswered;
  final int toRecall;
  final int recallMeeting;
  final int meeting;

  DayData copyWith({
    String? day,
    int? closedCalls,
    int? notAnswered,
    int? toRecall,
    int? recallMeeting,
    int? meeting,
  }) {
    return DayData(
      day ?? this.day,
      closedCalls ?? this.closedCalls,
      notAnswered ?? this.notAnswered,
      toRecall ?? this.toRecall,
      recallMeeting ?? this.recallMeeting,
      meeting ?? this.meeting,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'closedCalls': closedCalls,
      'notAnswered': notAnswered,
      'toRecall': toRecall,
      'recallMeeting': recallMeeting,
      'meeting': meeting,
    };
  }

  factory DayData.fromMap(Map<String, dynamic> map) {
    return DayData(
      map['day'],
      map['closedCalls'],
      map['notAnswered'],
      map['toRecall'],
      map['recallMeeting'],
      map['meeting'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DayData.fromJson(String source) =>
      DayData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DayData(day: $day, closedCalls: $closedCalls, notAnswered: $notAnswered, toRecall: $toRecall, recallMeeting: $recallMeeting, meeting: $meeting)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DayData &&
        other.day == day &&
        other.closedCalls == closedCalls &&
        other.notAnswered == notAnswered &&
        other.toRecall == toRecall &&
        other.recallMeeting == recallMeeting &&
        other.meeting == meeting;
  }

  @override
  int get hashCode {
    return day.hashCode ^
        closedCalls.hashCode ^
        notAnswered.hashCode ^
        toRecall.hashCode ^
        recallMeeting.hashCode ^
        meeting.hashCode;
  }
}
