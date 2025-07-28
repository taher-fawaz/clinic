class MedicalFileModel {
  final String id;
  final String fileName;
  final String filePath;
  final String fileType; // 'pdf', 'image', 'document'
  final String mimeType;
  final int fileSize; // in bytes
  final DateTime uploadedAt;
  final String uploadedBy; // doctor ID
  final String uploaderName;
  final String? description;
  final String? thumbnailPath;

  const MedicalFileModel({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.mimeType,
    required this.fileSize,
    required this.uploadedAt,
    required this.uploadedBy,
    required this.uploaderName,
    this.description,
    this.thumbnailPath,
  });

  factory MedicalFileModel.fromJson(Map<String, dynamic> json) {
    return MedicalFileModel(
      id: json['id'] as String,
      fileName: json['fileName'] as String,
      filePath: json['filePath'] as String,
      fileType: json['fileType'] as String,
      mimeType: json['mimeType'] as String,
      fileSize: json['fileSize'] as int,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      uploadedBy: json['uploadedBy'] as String,
      uploaderName: json['uploaderName'] as String,
      description: json['description'] as String?,
      thumbnailPath: json['thumbnailPath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'filePath': filePath,
      'fileType': fileType,
      'mimeType': mimeType,
      'fileSize': fileSize,
      'uploadedAt': uploadedAt.toIso8601String(),
      'uploadedBy': uploadedBy,
      'uploaderName': uploaderName,
      'description': description,
      'thumbnailPath': thumbnailPath,
    };
  }

  String get formattedUploadedAt {
    return '${uploadedAt.day}/${uploadedAt.month}/${uploadedAt.year}';
  }

  String get formattedFileSize {
    if (fileSize < 1024) {
      return '${fileSize} B';
    } else if (fileSize < 1024 * 1024) {
      return '${(fileSize / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }

  bool get isImage {
    return fileType == 'image' || 
           mimeType.startsWith('image/') ||
           fileName.toLowerCase().endsWith('.jpg') ||
           fileName.toLowerCase().endsWith('.jpeg') ||
           fileName.toLowerCase().endsWith('.png') ||
           fileName.toLowerCase().endsWith('.gif') ||
           fileName.toLowerCase().endsWith('.bmp');
  }

  bool get isPdf {
    return fileType == 'pdf' || 
           mimeType == 'application/pdf' ||
           fileName.toLowerCase().endsWith('.pdf');
  }

  bool get isDocument {
    return fileType == 'document' ||
           fileName.toLowerCase().endsWith('.doc') ||
           fileName.toLowerCase().endsWith('.docx') ||
           fileName.toLowerCase().endsWith('.txt');
  }

  String get fileExtension {
    final parts = fileName.split('.');
    return parts.length > 1 ? parts.last.toUpperCase() : 'FILE';
  }
}