import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'create_company_screen.dart';
import 'create_service_screen.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({super.key});
  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppState>().fetchCompanies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Companies')),
      body: Builder(
        builder: (_) {
          if (state.loading)
            return const Center(child: CircularProgressIndicator());
          if (state.error != null)
            return Center(child: Text('Error: ${state.error}'));
          if (state.companies.isEmpty)
            return const Center(child: Text('No companies yet.'));
          return ListView.builder(
            itemCount: state.companies.length,
            itemBuilder: (_, i) {
              final c = state.companies[i];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  title: Text(c.name),
                  subtitle: Text('Reg: ${c.registrationNumber}'),
                  children: [
                    if (c.services.isEmpty)
                      const ListTile(title: Text('No services')),
                    ...c.services.map(
                      (s) => ListTile(
                        title: Text(s.name),
                        subtitle: Text(s.description),
                        trailing: Text('\$${s.price.toStringAsFixed(2)}'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'addCompany',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateCompanyScreen()),
            ),
            label: const Text('Add Company'),
            icon: const Icon(Icons.domain_add),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'addService',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateServiceScreen()),
            ),
            label: const Text('Add Service'),
            icon: const Icon(Icons.design_services),
          ),
        ],
      ),
    );
  }
}
