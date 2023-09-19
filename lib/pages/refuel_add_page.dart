import 'package:date_field/date_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motolog/database/database_helper.dart';
import 'package:motolog/database/refuel_db_helper.dart';
import 'package:motolog/models/refuel.dart';
import 'package:motolog/models/vehicle.dart';
import 'package:motolog/widgets/checkbox_form_field.dart';

class RefuelAddPage extends StatefulWidget {
  const RefuelAddPage({super.key, required this.vehicle, required this.refuels});

  final Vehicle vehicle;
  final List<Refuel> refuels;

  @override
  State<RefuelAddPage> createState() => _RefuelAddPageState();
}

class _RefuelAddPageState extends State<RefuelAddPage> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  final _formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  final _stationController = TextEditingController();
  final _quantityController = TextEditingController();
  final _paidController = TextEditingController();
  final _distanceController = TextEditingController();
  bool filledToCapacity = true;
  bool? missingPreviousEntry = null;

  /// 0 = Editing
  /// 1 = Saving
  /// 2 = Saved
  int saveState = 0;

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        saveState = 1;
      });
      var refuel = Refuel(
        vehicleId: widget.vehicle.id!,
        station: _stationController.text,
        dateTime: dateTime,
        quantity: double.parse(_quantityController.text),
        paid: double.parse(_paidController.text),
        distance: double.parse(_distanceController.text),
        filledToCapacity: filledToCapacity,
        missingPreviousEntry: missingPreviousEntry ?? widget.refuels.isEmpty,
      );
      if (kDebugMode) {
        print(refuel);
      }
      await dbHelper.insertRefuel(refuel);
      setState(() {
        saveState = 2;
      });
    }
  }

  @override
  void dispose() {
    _stationController.dispose();
    _quantityController.dispose();
    _paidController.dispose();
    _distanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (saveState == 1) {
      return const CircularProgressIndicator();
    }
    if (saveState == 2) {
      Navigator.pop(context);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text('Add Refueling | ${widget.vehicle.name}'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              children: <Widget>[
                DateTimeFormField(
                  decoration: const InputDecoration(labelText: 'Date and Time'),
                  mode: DateTimeFieldPickerMode.dateAndTime,
                  autovalidateMode: AutovalidateMode.always,
                  initialValue: dateTime,
                  dateFormat: DateFormat('yyyy-MM-dd HH:mm:ss'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onDateSelected: (value) {
                    setState(() {
                      dateTime = value;
                    });
                  },
                ),
                TextFormField(
                  controller: _stationController,
                  decoration: const InputDecoration(labelText: 'Fuel Station'),
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                      labelText: 'Quantity (${Refuel.fuelUnit})'),
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _paidController,
                  decoration: const InputDecoration(
                      labelText: 'Paid (${Refuel.currency})'),
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a number';
                    }
                    if (double.parse(value) < 0) {
                      return 'Please enter a positive number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _distanceController,
                  decoration: const InputDecoration(
                      labelText: 'Distance (${Refuel.distanceUnit})'),
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a number';
                    }
                    if (double.parse(value) < 0) {
                      return 'Please enter a positive number';
                    }
                    return null;
                  },
                ),
                CheckboxFormField(
                  title: const Text('Refueled to capacity'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: filledToCapacity,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onSaved: (value) => filledToCapacity = value ?? false,
                ),
                CheckboxFormField(
                  title: const Text('Missing previous entry'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: widget.refuels.isEmpty,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onSaved: (value) => missingPreviousEntry = value ?? false,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    onPressed: onSubmit,
                    label: const Text('Save'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
