class QuestionDataList {
  QuestionDataList(this.pastTitle, this.questionId, this.answeredTimes, this.correctTimes,
      this.wrongTimes, this.continuousCorrectTimes, this.latestCorrect);

  int? pastTitle;
  int questionId;
  int answeredTimes;
  int correctTimes;
  int wrongTimes;
  int continuousCorrectTimes;
  int latestCorrect;
}
