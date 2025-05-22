import 'get_all_set_by_classroom_id_respone.dart';

class GetAllInforClassJoinedByUserIdRespone {
  String classId;
  String className;
  List<GetAllSetByClassroomIdRespone> listSet;

  GetAllInforClassJoinedByUserIdRespone({
    required this.classId,
    required this.className,
    required this.listSet,
  });

  factory GetAllInforClassJoinedByUserIdRespone.fromJson(Map<String, dynamic> json) {
    var list = json['listSet'] as List<dynamic>? ?? [];
    List<GetAllSetByClassroomIdRespone> sets = list
        .map((e) => GetAllSetByClassroomIdRespone.fromJson(e as Map<String, dynamic>))
        .toList();

    return GetAllInforClassJoinedByUserIdRespone(
      classId: json['classId'] ?? '',
      className: json['className'] ?? '',
      listSet: sets,
    );
  }

  Map<String, dynamic> toJson() => {
    'classId': classId,
    'className': className,
    'listSet': listSet.map((e) => e.toJson()).toList(),
  };
}
