import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme AppTypographis = TextTheme(
  // Dành cho các tiêu đề trang lớn (ví dụ: Trang chủ hoặc Dashboard lớn)
  displayLarge: GoogleFonts.openSans(
    fontWeight: FontWeight.w800, // ExtraBold
    fontSize: 57,
  ),

  // Dành cho tiêu đề trung bình (ví dụ: tiêu đề section “Thẻ của tôi”)
  displayMedium: GoogleFonts.openSans(
    fontWeight: FontWeight.w800, // ExtraBold
    fontSize: 45,
  ),

  // Dành cho tiêu đề nhỏ (ví dụ: tiêu đề danh sách thẻ hoặc học phần)
  displaySmall: GoogleFonts.openSans(
    fontWeight: FontWeight.w700, // Bold
    fontSize: 36,
  ),

  // Dành cho tiêu đề nổi bật trong flashcard (ví dụ: từ cần học)
  headlineLarge: GoogleFonts.museoModerno(
    fontWeight: FontWeight.w700, // Bold
    fontSize: 32,
  ),

  // Dành cho tiêu đề phần thi/quiz (ví dụ: tiêu đề bài kiểm tra)
  headlineMedium: GoogleFonts.museoModerno(
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 28,
  ),

  // Dành cho sub-header (ví dụ: tên tác giả hoặc mô tả học phần)
  headlineSmall: GoogleFonts.museoModerno(
    fontWeight: FontWeight.w500, // Medium
    fontSize: 24,
  ),

  // Dành cho tiêu đề của các thẻ dạng ListTile, Card
  titleLarge: GoogleFonts.openSans(
    fontWeight: FontWeight.w700, // Bold
    fontSize: 22,
  ),

  // Dành cho các tab, filter, sort dropdown…
  titleMedium: GoogleFonts.openSans(
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 20,
  ),

  // Dành cho nội dung chính hoặc tiêu đề phụ trong flashcard
  titleSmall: GoogleFonts.openSans(
    fontWeight: FontWeight.w400, // Regular
    fontSize: 18,
  ),

  // Dành cho văn bản dài trong phần chi tiết (ví dụ: mô tả học phần, hướng dẫn)
  bodyLarge: GoogleFonts.museoModerno(
    fontWeight: FontWeight.w400, // Regular
    fontSize: 16,
  ),

  // Dành cho nội dung phụ hoặc trích dẫn (ví dụ: định nghĩa, ví dụ minh họa)
  bodyMedium: GoogleFonts.museoModerno(
    fontWeight: FontWeight.w300, // Light
    fontSize: 14,
  ),

  // Dành cho nội dung cực nhỏ, thông tin phụ (ví dụ: thời gian tạo, trạng thái học phần)
  bodySmall: GoogleFonts.museoModerno(
    fontWeight: FontWeight.w300, // Light
    fontSize: 12,
  ),

  // Dành cho nút bấm chính, CTA (Call-to-Action) như “Bắt đầu học”, “Tạo thẻ”
  labelLarge: GoogleFonts.openSans(
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 14,
  ),

  // Dành cho label phụ trong form, nút phụ, hoặc thẻ nhỏ
  labelMedium: GoogleFonts.openSans(
    fontWeight: FontWeight.w400, // Regular
    fontSize: 12,
  ),

  // Dành cho tooltip, tag nhỏ hoặc trạng thái (ví dụ: “Đã học”, “Mới tạo”)
  labelSmall: GoogleFonts.openSans(
    fontWeight: FontWeight.w300, // Light
    fontSize: 10,
  ),
);
