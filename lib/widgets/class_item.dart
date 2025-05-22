import 'package:flutter/material.dart';

import '../core/domain/dtos/classroom/classroom_dto.dart';
import '../core/navigation/routers.dart';

class ClassItem extends StatelessWidget {
  final ClassRoomDto item;
  final bool hasIcon;

  const ClassItem({super.key, required this.item, required this.hasIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          AppRouter.router.navigateTo(context, "/classpage");
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasIcon)
                Icon(
                  Icons.people_outline,
                  size: 32,
                  color: Colors.grey[600],
                ),
              SizedBox(width: 16),
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 4),
              if(!hasIcon)
              Text(
                '.',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.book_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'học phần',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.people_outline,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  if(!hasIcon)
                  Text(
                    'thành viên',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
