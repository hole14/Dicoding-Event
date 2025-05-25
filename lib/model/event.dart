class EventModel {
  final String id;
  final String title;
  final String summary;
  final String deskripsi;
  final String logo;
  final String cover;
  final String kategori;
  final String tanggalAwal;
  final String tanggalAkhir;
  final String lokasi;
  final String organizer;
  final String link;
  final String quota;
  final String pendaftaran;

  EventModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.deskripsi,
    required this.logo,
    required this.cover,
    required this.kategori,
    required this.tanggalAwal,
    required this.tanggalAkhir,
    required this.lokasi,
    required this.organizer,
    required this.link,
    required this.quota,
    required this.pendaftaran,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['name'],
      summary: json['summary'],
      deskripsi: json['description'],
      logo: json['imageLogo'],
      cover: json['mediaCover'],
      kategori: json['category'],
      tanggalAwal: json['beginTime'],
      tanggalAkhir: json['endTime'],
      lokasi: json['cityName'],
      organizer: json['ownerName'],
      link: json['link'],
      quota: json['quota'],
      pendaftaran: json['registrants'],
    );
  }
}