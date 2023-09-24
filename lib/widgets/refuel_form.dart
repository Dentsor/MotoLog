import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:motolog/database/database_helper.dart';
import 'package:motolog/database/refuel_db_helper.dart';
import 'package:motolog/models/refuel.dart';
import 'package:motolog/models/vehicle.dart';
import 'package:motolog/utils/refuel_utils.dart';
import 'package:motolog/widgets/checkbox_form_field.dart';

class RefuelForm extends StatefulWidget {
  const RefuelForm(
      {super.key,
      required this.vehicle,
      required this.refuel,
      required this.firstEntry});

  /// The vehicle for which this refueling applies
  final Vehicle vehicle;

  /// A Refuel data object if the form should display/edit an existing entry.
  final Refuel? refuel;

  /// Only applies if Refuel==null (aka. adding new entry), in which case missingPreviousEntry=firstEntry by default.
  final bool firstEntry;

  @override
  State<RefuelForm> createState() => _RefuelEditForm();
}

class _RefuelEditForm extends State<RefuelForm> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  final _formKey = GlobalKey<FormState>();

  /// Form Data
  late DateTime _dateTime;
  late final TextEditingController _stationController;
  late final TextEditingController _quantityController;
  late final TextEditingController _paidController;
  late final TextEditingController _distanceController;
  late bool _filledToCapacity;
  late bool _missingPreviousEntry;

  /// 0 = Editing
  /// 1 = Saving
  /// 2 = Saved
  int saveState = 0;

  @override
  void initState() {
    super.initState();

    // Initialize form data
    if (widget.refuel == null) {
      // Add
      _dateTime = DateTime.now();
      _stationController = TextEditingController();
      _quantityController = TextEditingController();
      _paidController = TextEditingController();
      _distanceController = TextEditingController();
      _filledToCapacity = true;
      _missingPreviousEntry = widget.firstEntry;
    } else {
      // Edit
      _dateTime = widget.refuel!.dateTime;
      _stationController = TextEditingController(text: widget.refuel!.station);
      _quantityController =
          TextEditingController(text: widget.refuel!.quantity.toString());
      _paidController =
          TextEditingController(text: widget.refuel!.paid.toString());
      _distanceController =
          TextEditingController(text: widget.refuel!.paid.toString());
      _filledToCapacity = widget.refuel!.filledToCapacity;
      _missingPreviousEntry = widget.refuel!.missingPreviousEntry;
    }
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      // Update state to show progress indicator
      setState(() {
        saveState = 1;
      });

      // Create Refuel instance to save
      var refuel = Refuel(
        id: widget.refuel?.id,
        vehicleId: widget.vehicle.id!,
        station: _stationController.text,
        dateTime: _dateTime,
        quantity: double.parse(_quantityController.text),
        paid: double.parse(_paidController.text),
        distance: double.parse(_distanceController.text),
        filledToCapacity: _filledToCapacity,
        missingPreviousEntry: _missingPreviousEntry,
      );

      // Save
      if (refuel.id == null) {
        // Add
        await dbHelper.insertRefuel(refuel);
      } else {
        // Edit
        await dbHelper.updateRefuel(refuel);
      }

      // Update state async to navigate back
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
      return const CircularProgressIndicator(); // TODO?
    }

    return FutureBuilder(
        future: dbHelper.retrieveRefuels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            var refuels = snapshot.data!;
            var stations = refuels.map((e) => e.station).toSet().toList();
            stations.sort();

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                title: Text(
                    '${widget.refuel == null ? 'Add' : 'Edit'} Refueling | ${widget.vehicle.name}'),
              ),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        DateTimeFormField(
                          decoration:
                              const InputDecoration(labelText: 'Date and Time'),
                          mode: DateTimeFieldPickerMode.dateAndTime,
                          autovalidateMode: AutovalidateMode.always,
                          initialValue: _dateTime,
                          dateFormat: DateFormat('yyyy-MM-dd HH:mm:ss'),
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter a value';
                            }
                            return null;
                          },
                          onDateSelected: (value) {
                            setState(() {
                              _dateTime = value;
                            });
                          },
                        ),
                        TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: _stationController,
                            decoration: const InputDecoration(
                              labelText: 'Fuel Station',
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          suggestionsCallback: (pattern) {
                            return stations.where((element) => element
                                .toLowerCase()
                                .contains(pattern.toLowerCase()));
                          },
                          itemBuilder: (context, suggestion) => ListTile(
                            title: Text(suggestion),
                          ),
                          hideOnEmpty: true,
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (suggestion) {
                            _stationController.text = suggestion;
                          },
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
                          initialValue: _filledToCapacity,
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter a value';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              _filledToCapacity = value ?? false,
                        ),
                        CheckboxFormField(
                          title: const Text('Missing previous entry'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: _missingPreviousEntry,
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter a value';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              _missingPreviousEntry = value ?? false,
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
          return const Text('No data');
        });
  }
}
