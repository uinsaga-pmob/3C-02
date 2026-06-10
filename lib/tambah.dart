import 'package:flutter/material.dart';
import 'custom_navbar.dart';
import '../database/db_helper.dart';
import '../models/task.dart';

class Tambah extends StatefulWidget {
  final Task? task;
  const Tambah({super.key, this.task});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  final mkController = TextEditingController();
  final jtController = TextEditingController();
  final deskController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      mkController.text = widget.task!.mataKuliah;
      jtController.text = widget.task!.jenisTugas;
      deskController.text = widget.task!.deskripsi;
      selectedDate = widget.task!.deadline;
    }
  }

  @override
  void dispose() {
    mkController.dispose();
    jtController.dispose();
    deskController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;
    setState(() {
      selectedDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  Future<void> simpan() async {
    if (mkController.text.isEmpty || jtController.text.isEmpty || deskController.text.isEmpty || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Semua field wajib diisi")));
      return;
    }
    final task = Task(
      id: widget.task?.id,
      mataKuliah: mkController.text,
      jenisTugas: jtController.text,
      deskripsi: deskController.text,
      deadline: selectedDate!,
      selesai: widget.task?.selesai ?? false,
    );
    if (widget.task == null) {
      await DBHelper.instance.insertTask(task);
    } else {
      await DBHelper.instance.updateTask(task);
    }
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    // --- ADAPTIF WARNA TEMA ---
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final cardColor = isDark ? const Color(0XFF1E1E1E) : Colors.white;

    return Scaffold(
      bottomNavigationBar: const CustomNavBar(selectedIndex: 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16, right: 16, top: 40,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task == null ? "Tambah\nTugas" : "Edit\nTugas",
              style: const TextStyle(color: Color(0XFF018592), fontSize: 34, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _field("Mata Kuliah", mkController, textColor, cardColor, isDark),
            _field("Jenis Tugas", jtController, textColor, cardColor, isDark),
            _field("Deskripsi", deskController, textColor, cardColor, isDark),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: pickDate,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isDark ? null : [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? "Pilih Deadline"
                          : "${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year} ${selectedDate!.hour.toString().padLeft(2, '0')}:${selectedDate!.minute.toString().padLeft(2, '0')}",
                      style: TextStyle(color: textColor),
                    ),
                    const Icon(Icons.calendar_today, color: Color(0XFF018592)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF018592),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                ),
                onPressed: simpan,
                child: Text(widget.task == null ? "Save" : "Update", style: const TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c, Color textColor, Color cardColor, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0XFF018592))),
          const SizedBox(height: 6),
          TextField(
            controller: c,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              filled: true,
              fillColor: cardColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}