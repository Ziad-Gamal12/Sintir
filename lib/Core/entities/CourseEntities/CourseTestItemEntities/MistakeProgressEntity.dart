enum MistakeStatus {
  active,
  improving,
  mastered,
}

class MistakeProgressEntity {
  final String questionId;

  int wrongCount;
  int correctStreak;
  DateTime lastAnsweredAt;
  MistakeStatus status;

  MistakeProgressEntity({
    required this.questionId,
    this.wrongCount = 0,
    this.correctStreak = 0,
    required this.lastAnsweredAt,
    this.status = MistakeStatus.active,
  });

  static MistakeProgressEntity empty() => MistakeProgressEntity(
        questionId: 'question_${DateTime.now().millisecondsSinceEpoch}',
        lastAnsweredAt: DateTime.now(),
        wrongCount: 0,
        correctStreak: 0,
        status: MistakeStatus.active,
      );
  MistakeProgressEntity copyWith({
    String? questionId,
    int? wrongCount,
    int? correctStreak,
    DateTime? lastAnsweredAt,
    MistakeStatus? status,
  }) {
    return MistakeProgressEntity(
      questionId: questionId ?? this.questionId,
      wrongCount: wrongCount ?? this.wrongCount,
      correctStreak: correctStreak ?? this.correctStreak,
      lastAnsweredAt: lastAnsweredAt ?? this.lastAnsweredAt,
      status: status ?? this.status,
    );
  }
}
