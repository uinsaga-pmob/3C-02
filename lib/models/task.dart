class Task {
  int? id;
  String mataKuliah;
  String jenisTugas;
  String deskripsi;
  DateTime deadline;
  bool selesai;

  Task({
    this.id,
    required this.mataKuliah,
    required this.jenisTugas,
    required this.deskripsi,
    required this.deadline,
    this.selesai = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mataKuliah': mataKuliah,
      'jenisTugas': jenisTugas,
      'deskripsi': deskripsi,
      'deadline': deadline.toIso8601String(),
      'selesai': selesai ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      mataKuliah: map['mataKuliah'] ?? '',
      jenisTugas: map['jenisTugas'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      deadline: _parseDate(map['deadline']),
      selesai: map['selesai'] == 1,
    );
  }

  static DateTime _parseDate(dynamic value) {
    try {
      if (value is DateTime) return value;
      return DateTime.parse(value.toString());
    } catch (_) {
      return DateTime.now();
    }
  }

  bool isToday() {
    final now = DateTime.now();

    return deadline.year == now.year &&
        deadline.month == now.month &&
        deadline.day == now.day;
  }

  String get deadlineFormat {
    final d = deadline;

    final tanggal =
        "${d.day.toString().padLeft(2, '0')}-"
        "${d.month.toString().padLeft(2, '0')}-"
        "${d.year}";

    final jam =
        "${d.hour.toString().padLeft(2, '0')}:"
        "${d.minute.toString().padLeft(2, '0')}";

    return "$tanggal $jam";
  }

  String get deadlineJam {
    return "${deadline.hour.toString().padLeft(2, '0')}:"
        "${deadline.minute.toString().padLeft(2, '0')}";
  }

  bool get isOverdue {
    return DateTime.now().isAfter(deadline) && !selesai;
  }
}