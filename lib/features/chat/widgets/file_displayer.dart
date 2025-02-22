import 'dart:io';

import 'package:flutter/material.dart';

class FileDisplayer extends StatelessWidget {
  const FileDisplayer({super.key, required this.file});

  final File file;

  String _getFileName(){
    final fileName = file.path.split('/').last;
    return fileName;
  }

  String _setFileType() {
    final fileExtension = file.path.split('.').last;

    if ([
      'jpg',
      'jpeg',
      'png',
      'gif',
    ].contains(fileExtension)) {
      return 'Image';
    }
    if ([
      'mp4',
      'mkv',
      'mov',
    ].contains(fileExtension)) {
      return 'video';
    }
    if ([
      'mp3',
      'wav',
      'aac',
    ].contains(fileExtension)) {
      return 'audio';
    }
    return 'document';
  }

  @override
  Widget build(BuildContext context) {
    final fileType = _setFileType();
    final fileName = _getFileName();

    switch (fileType) {
      case 'Image':
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            file,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        );
      case 'video':
        return Column(
          children: [
            Card(
              child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.videocam)),
            ),
            Text(fileName)
          ],
        );
      case 'audio':
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.audiotrack),
              ),
            )
        );
      case 'document':
        return Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.insert_drive_file));
      default:
        return Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.error,
              color: Colors.red,
            ));
    }
  }
}
