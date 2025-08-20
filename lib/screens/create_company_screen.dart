import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class CreateCompanyScreen extends StatefulWidget {
  const CreateCompanyScreen({super.key});
  @override
  State<CreateCompanyScreen> createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends State<CreateCompanyScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _reg = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _reg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Create Company')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _reg,
                decoration: const InputDecoration(
                  labelText: 'Registration Number',
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: state.loading
                    ? null
                    : () async {
                        if (!_form.currentState!.validate()) return;
                        final ok = await context.read<AppState>().createCompany(
                          _name.text.trim(),
                          _reg.text.trim(),
                        );
                        if (ok && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Company created')),
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
    );
  }
}
