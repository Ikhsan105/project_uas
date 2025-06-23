import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAnalisisExpanded = true;
  bool isFotoExpanded = false;
  bool isVideoExpanded = false;
  bool isAudioExpanded = false;
  bool isNoteExpanded = false;
  bool isRecycleExpanded = false;

  final List<String> recentNotes = [
    'Catatan penting hari ini',
    'Ide fitur baru',
    'Perbaikan bug modul audio',
    'Reminder meeting jam 10',
    'Refactor kode modul video',
  ];

  Widget buildCustomTile({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Icon(isExpanded ? Icons.expand_more : Icons.chevron_right),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: child,
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        )
      ],
    );
  }

  Widget buildMediaPreviewSection(String label, List<Widget> previews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...previews,
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('xAPP')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCustomTile(
              title: 'Analisis',
              isExpanded: isAnalisisExpanded,
              onTap: () => setState(() => isAnalisisExpanded = !isAnalisisExpanded),
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(value: 30, color: Colors.blue, title: 'Foto'),
                          PieChartSectionData(value: 40, color: Colors.red, title: 'Terpakai'),
                          PieChartSectionData(value: 30, color: Colors.green, title: 'Sisa'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Chip(label: Text('Foto', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blue),
                      Chip(label: Text('Terpakai', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
                      Chip(label: Text('Sisa', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
                    ],
                  )
                ],
              ),
            ),
            buildCustomTile(
              title: 'Foto',
              isExpanded: isFotoExpanded,
              onTap: () => setState(() => isFotoExpanded = !isFotoExpanded),
              child: buildMediaPreviewSection(
                'Foto',
                List.generate(6, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 60,
                    height: 60,
                    color: Colors.grey.shade300,
                    child: Center(child: Text('Foto ${index + 1}')),
                  );
                }),
              ),
            ),
            buildCustomTile(
              title: 'Video',
              isExpanded: isVideoExpanded,
              onTap: () => setState(() => isVideoExpanded = !isVideoExpanded),
              child: buildMediaPreviewSection(
                'Video',
                List.generate(6, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 60,
                    height: 60,
                    color: Colors.orange.shade200,
                    child: Center(child: Text('Video ${index + 1}')),
                  );
                }),
              ),
            ),
            buildCustomTile(
              title: 'Audio',
              isExpanded: isAudioExpanded,
              onTap: () => setState(() => isAudioExpanded = !isAudioExpanded),
              child: buildMediaPreviewSection(
                'Audio',
                List.generate(6, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 60,
                    height: 60,
                    color: Colors.purple.shade200,
                    child: const Center(child: Icon(Icons.music_note)),
                  );
                }),
              ),
            ),
            buildCustomTile(
              title: 'Note',
              isExpanded: isNoteExpanded,
              onTap: () => setState(() => isNoteExpanded = !isNoteExpanded),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text('Terbaru', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                    color: const Color(0xFF87CEFA),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recentNotes.take(5).map((note) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('- $note', style: const TextStyle(color: Colors.black, fontSize: 18)),
                      )).toList(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Selengkapnya'),
                    ),
                  )
                ],
              ),
            ),
            buildCustomTile(
              title: 'Recycle',
              isExpanded: isRecycleExpanded,
              onTap: () => setState(() => isRecycleExpanded = !isRecycleExpanded),
              child: Row(
                children: const [
                  Icon(Icons.delete, size: 50, color: Colors.grey),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('5%'),
                      Text('20 MB'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
