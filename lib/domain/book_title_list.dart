class PastPaperTitle {
  final String title;
  final int? tag;
  final String sort;
  final String image;
  final int initialIndex;

  PastPaperTitle(
      {required this.title,
      required this.tag,
      required this.sort,
      required this.image,
      required this.initialIndex});
}

List<PastPaperTitle> past_paper_title_list = [
  PastPaperTitle(
      title: "104回",
      tag: 104,
      sort: "過去問",
      image: "assets/images/ピンクのエイリアン.png",
      initialIndex: 0),
  PastPaperTitle(
      title: "103回",
      tag: 103,
      sort: "過去問",
      image: "assets/images/紫のエイリアン.png",
      initialIndex: 1),
  PastPaperTitle(
      title: "102回",
      tag: 102,
      sort: "過去問",
      image: "assets/images/緑のエイリアン.png",
      initialIndex: 2),
  PastPaperTitle(
      title: "101回",
      tag: 101,
      sort: "過去問",
      image: "assets/images/黄色のエイリアン.png",
      initialIndex: 3),
  PastPaperTitle(
      title: "100回",
      tag: 100,
      sort: "過去問",
      image: "assets/images/エジプト神（イヌ型）.png",
      initialIndex: 4),
];
