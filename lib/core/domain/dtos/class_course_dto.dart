// DTO
class ClassroomSetDto {
  final String classroomId;
  final String setId;

  ClassroomSetDto({
    required this.classroomId,
    required this.setId,
  });

  Map<String, dynamic> toJson() {
    return {
      'classroomId': classroomId,
      'setId': setId,
    };
  }
}