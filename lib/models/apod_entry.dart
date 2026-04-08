class ApodEntry {
  final String title;
  final String date;
  final String explanation;
  final String imageURL;
  final String copyright;

  ApodEntry({
    required this.title, 
    required this.date, 
    required this.explanation, 
    required this.imageURL, 
    required this.copyright
  });

  factory ApodEntry.fromJson(Map<String, dynamic> json){
    return ApodEntry(
      title: json['title'] ?? 'No Title', 
      date: json['date'] ?? '', 
      explanation: json['explanation'] ?? 'No Description', 
      imageURL: json['imageURL'] ?? '', 
      copyright: json['copyright'] ?? '');
  }
}
