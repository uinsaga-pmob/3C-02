class Task {
  int? id;
  String mataKuliah;
  String jenisTugas;
  String deskripsi;
  String deadline;
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
      'deadline': deadline,
      'selesai': selesai ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      mataKuliah: map['mataKuliah'],
      jenisTugas: map['jenisTugas'],
      deskripsi: map['deskripsi'],
      deadline: map['deadline'],
      selesai: map['selesai'] == 1,
    );
  }
}