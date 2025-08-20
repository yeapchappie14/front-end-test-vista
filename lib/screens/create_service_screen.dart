import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({super.key});
  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();
  int? _companyId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final st = context.read<AppState>();
      if (st.companies.isEmpty) st.fetchCompanies();
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Create Service')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<int>(
                  value: _companyId,
                  items: state.companies
                      .map(
                        (c) => DropdownMenuItem<int>(
                          value: c.id,
                          child: Text('${c.name} (ID ${c.id})'),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _companyId = v),
                  decoration: const InputDecoration(labelText: 'Company'),
                  validator: (v) => v == null ? 'Select a company' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Service Name'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _desc,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _price,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price (e.g. 99.99)',
                  ),
                  validator: (v) {
                    final d = double.tryParse(v ?? '');
                    if (d == null) return 'Enter a number';
                    if (d < 0) return 'Must be positive';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state.loading
                      ? null
                      : () async {
                          if (!_form.currentState!.validate()) return;
                          final ok = await context
                              .read<AppState>()
                              .createService(
                                _name.text.trim(),
                                _desc.text.trim(),
                                double.parse(_price.text.trim()),
                                _companyId!,
                              );
                          if (ok && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Service created')),
                            );
                            Navigator.pop(context);
                          }
                        },
                  child: const Text('Create'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
