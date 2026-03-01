import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/MistakeProgressEntity.dart';

class MistakeProgressModel {
  final String questionId;
  int wrongCount;
  int correctStreak;
  DateTime lastAnsweredAt;
  String status;

  MistakeProgressModel({
    required this.questionId,
    required this.wrongCount,
    required this.correctStreak,
    required this.lastAnsweredAt,
    required this.status,
  });
  factory MistakeProgressModel.fromJson(Map<String, dynamic> json) {
    return MistakeProgressModel(
      questionId: json['questionId'],
      wrongCount: json['wrongCount'],
      correctStreak: json['correctStreak'],
      lastAnsweredAt: (json['lastAnsweredAt'] as Timestamp).toDate(),
      status: json['status'],
    );
  }
  factory MistakeProgressModel.fromEntity(MistakeProgressEntity entity) {
    return MistakeProgressModel(
      questionId: entity.questionId,
      wrongCount: entity.wrongCount,
      correctStreak: entity.correctStreak,
      lastAnsweredAt: entity.lastAnsweredAt,
      status: entity.status.name,
    );
  }
  MistakeProgressEntity toEntity() {
    return MistakeProgressEntity(
      questionId: questionId,
      wrongCount: wrongCount,
      correctStreak: correctStreak,
      lastAnsweredAt: lastAnsweredAt,
      status: MistakeStatus.values.firstWhere((e) => e.name == status),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'wrongCount': wrongCount,
      'correctStreak': correctStreak,
      'lastAnsweredAt': lastAnsweredAt,
      'status': status,
    };
  }
}
