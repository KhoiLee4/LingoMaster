class MultipleChoiceQuestion {
  String question;
  List<String> choices;
  String answer;

  MultipleChoiceQuestion({
    required this.question,
    required this.choices,
    required this.answer,
  });

  factory MultipleChoiceQuestion.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceQuestion(
      question: json['question'] ?? '',
      choices: List<String>.from(json['choices'] ?? []),
      answer: json['answer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'question': question,
    'choices': choices,
    'answer': answer,
  };
}