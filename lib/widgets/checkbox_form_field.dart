import 'package:flutter/material.dart';

/// Based on answer from https://stackoverflow.com/a/57897318
class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    super.key,
    Widget? title,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              dense: state.hasError,
              title: title,
              value: state.value,
              onChanged: state.didChange,
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText ?? '',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
}
