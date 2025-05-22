class MultipleChoiceQuestionDto {
  final String question;
  final List<String> choices;
  final String answer;

  MultipleChoiceQuestionDto({
    required this.question,
    required this.choices,
    required this.answer,
  });

  factory MultipleChoiceQuestionDto.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceQuestionDto(
      question: json['question'] ?? '',
      choices: json['choices'] != null
          ? List<String>.from(json['choices'])
          : [],
      answer: json['answer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'question': question,
    'choices': choices,
    'answer': answer,
  };
}