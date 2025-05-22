class ClassroomSetDto {
  String classroomId;
  String setId;

  ClassroomSetDto({
    required this.classroomId,
    required this.setId,
  });

  factory ClassroomSetDto.fromJson(Map<String, dynamic> json) {
    return ClassroomSetDto(
      classroomId: json['classroomId'] ?? '',
      setId: json['setId'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
    'classroomId': classroomId,
    'setId': setId,
  };
}
