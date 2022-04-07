class PastProblem {
  final int id;
  final String question;
  final List<String> options;
  final List<int> answerIndex;
  final int score;
  final bool image;

  PastProblem({
    required this.id,
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.score,
    required this.image,
  });
}
