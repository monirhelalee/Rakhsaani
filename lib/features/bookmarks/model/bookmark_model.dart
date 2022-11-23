class Bookmark {
  final int? id;
  final int? surahNumber;

  Bookmark({
    this.id,
    this.surahNumber,
  });

  factory Bookmark.fromMap(Map<String, dynamic> json) => Bookmark(
        id: json['id'],
        surahNumber: json['surahNumber'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'surahNumber': surahNumber,
    };
  }
}
