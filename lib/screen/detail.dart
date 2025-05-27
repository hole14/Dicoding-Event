import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';
import '../component/constrains.dart';
import '../model/event.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {

  final EventModel event;
  DetailPage({required this.event});

  String removeImgTags(String html) {
    final imgTagRegExp = RegExp(r'<img[^>]*>', multiLine: true, caseSensitive: false);
    return html.replaceAll(imgTagRegExp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Event'),
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context), 
          icon: Icon(Icons.arrow_back_outlined),
        ),
        backgroundColor: primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondColor,
        elevation: 6.0,
        child: Icon(Icons.favorite_border),
        onPressed: (){}
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(event.cover),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 6),
            Text(
              event.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                event.summary,
                style: TextStyle(
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: kDetailEvent(
                title: '🙍🏻‍♂️ ${event.organizer}', 
                textAlign: TextAlign.start)
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: kDetailEvent(
                title: '📜 ${event.kategori}',
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: kDetailEvent(
                title: '📍 ${event.lokasi}',
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: kDetailEvent(
                title: '📆 ${formatDate(event.tanggalAwal)}',
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: kDetailEvent(
                title: '⏰ ${formatTime(event.tanggalAwal)} - ${formatTime(event.tanggalAkhir)}',
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: kDetailEvent(
                title: '👥 ${event.pendaftaran} - ${event.quota} Orang',
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Deskripsi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Html(
                data: removeImgTags(event.deskripsi),
                style: {
                  'body': Style(
                    fontSize: FontSize.medium,
                    color: Colors.black,
                  ),
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: TextButton(
                  onPressed: () async {
                    final uri = Uri.parse(event.link);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tidak dapat membuka link')),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

String formatDate(String dateString) {
  final date = DateTime.parse(dateString);
  final formatter = DateFormat('dd MMMM yyyy');
  return formatter.format(date);
}

String formatTime(String timeString) {
  final time = DateTime.parse(timeString);
  final formatter = DateFormat('HH:mm');
  return formatter.format(time);
}
