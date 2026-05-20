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
  final dlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      mkController.text = widget.task!.mataKuliah;
      jtController.text = widget.task!.jenisTugas;
      deskController.text = widget.task!.deskripsi;
      dlController.text = widget.task!.deadline;
    }
  }

  @override
  void dispose() {
    mkController.dispose();
    jtController.dispose();
    deskController.dispose();
    dlController.dispose();
    super.dispose();
  }

  Future<void> simpan() async {
    if (mkController.text.isEmpty ||
        jtController.text.isEmpty ||
        deskController.text.isEmpty ||
        dlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field wajib diisi")),
      );
      return;
    }

    final task = Task(
      id: widget.task?.id,
      mataKuliah: mkController.text,
      jenisTugas: jtController.text,
      deskripsi: deskController.text,
      deadline: dlController.text,
      selesai: widget.task?.selesai ?? false,
    );

    if (widget.task == null) {
      await DBHelper.instance.insertTask(task);
    } else {
      await DBHelper.instance.updateTask(task);
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      bottomNavigationBar: const CustomNavBar(selectedIndex: 1),

      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            Text(
              widget.task == null ? "Tambah\n        Tugas" : "Edit\n        Tugas",
              style: const TextStyle(
                color: Color(0XFF018592),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 28),

            _field("Mata Kuliah", mkController),
            _field("Jenis Tugas", jtController),
            _field("Deskripsi", deskController),
            _field("Deadline", dlController),

            const SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF018592),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                onPressed: simpan,
                child: Text(
                  widget.task == null ? "Save" : "Update",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0XFF018592))),
          const SizedBox(height: 8),
          TextField(
            controller: c,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0XFF1E1E1E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}