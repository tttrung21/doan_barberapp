// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../skin/color_skin.dart';

// Duration for delay before announcement in IOS so that the announcement won't be interrupted.

// Examples can assume:
// late BuildContext context;

/// An optional container for grouping together multiple form field widgets
/// (e.g. [TextField] widgets).
///
/// Each individual form field should be wrapped in a [FormField] widget, with
/// the [FForm] widget as a common ancestor of all of those. Call methods on
/// [FFormState] to save, reset, or validate each [FormField] that is a
/// descendant of this [FForm]. To obtain the [FFormState], you may use [FForm.of]
/// with a context whose ancestor is the [FForm], or pass a [GlobalKey] to the
/// [FForm] constructor and call [GlobalKey.currentState].
///
/// {@tool dartpad}
/// This example shows a [FForm] with one [TextFormField] to enter an email
/// address and an [ElevatedButton] to submit the form. A [GlobalKey] is used here
/// to identify the [FForm] and validate input.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/form.png)
///
/// ** See code in examples/api/lib/widgets/form/form.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [GlobalKey], a key that is unique across the entire app.
///  * [FormField], a single form field widget that maintains the current state.
///  * [TextFormField], a convenience widget that wraps a [TextField] widget in a [FormField].
class FForm extends StatefulWidget {
  /// Creates a container for form fields.
  const FForm({
    super.key,
    required this.child,
    this.canPop,
    this.onPopInvoked,
    @Deprecated(
      'Use canPop and/or onPopInvoked instead. '

      'This feature was deprecated after v3.12.0-1.0.pre.',
    )
    this.autovalidate = false,
    this.onChanged,
    AutovalidateMode? autovalidateMode,
  })  : autovalidateMode = autovalidateMode ?? AutovalidateMode.disabled,
        assert(onPopInvoked == null && canPop == null, '');

  /// Returns the [FFormState] of the closest [FForm] widget which encloses the
  /// given context, or null if none is found.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// FormState? form = Form.maybeOf(context);
  /// form?.save();
  /// ```
  static FFormState? maybeOf(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_FormScope>();
    return scope?._formState;
  }

  static FFormState of(BuildContext context) {
    final formState = maybeOf(context);
    assert(() {
      if (formState == null) {
        throw FlutterError(
          'Form.of() was called with a context that does not contain a Form widget.\n'

          'No Form widget ancestor could be found starting from the context that '
          'was passed to Form.of(). This can happen because you are using a widget '
          'that looks for a Form ancestor, but no such ancestor exists.\n'
          'The context used was:\n'
          '  $context',
        );
      }
      return true;
    }(), '');
    return formState!;
  }

  /// The widget below this widget in the tree.
  ///
  /// This is the root of the widget hierarchy that contains this form.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// Enables the form to veto attempts by the user to dismiss the [ModalRoute]
  /// that contains the form.
  ///
  /// If the callback returns a Future that resolves to false, the form's route
  /// will not be popped.
  ///
  /// See also:
  ///


  /// {@macro flutter.widgets.PopScope.canPop}
  ///
  /// {@tool dartpad}
  /// This sample demonstrates how to use this parameter to show a confirmation
  /// dialog when a navigation pop would cause form data to be lost.
  ///
  /// ** See code in examples/api/lib/widgets/form/form.1.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [onPopInvoked], which also comes from [PopScope] and is often used in
  ///    conjunction with this parameter.
  ///  * [PopScope.canPop], which is what [FForm] delegates to internally.
  final bool? canPop;

  /// {@macro flutter.widgets.navigator.onPopInvoked}
  ///
  /// {@tool dartpad}
  /// This sample demonstrates how to use this parameter to show a confirmation
  /// dialog when a navigation pop would cause form data to be lost.
  ///
  /// ** See code in examples/api/lib/widgets/form/form.1.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [canPop], which also comes from [PopScope] and is often used in
  ///    conjunction with this parameter.
  ///  * [PopScope.onPopInvoked], which is what [FForm] delegates to internally.
  final PopInvokedCallback? onPopInvoked;

  /// Called when one of the form fields changes.
  ///
  /// In addition to this callback being invoked, all the form fields themselves
  /// will rebuild.
  final VoidCallback? onChanged;

  /// Used to enable/disable form fields auto validation and update their error
  /// text.
  ///
  /// {@macro flutter.widgets.FormField.autovalidateMode}
  final AutovalidateMode autovalidateMode;

  final bool autovalidate;

  @override
  FFormState createState() => FFormState();
}

/// State associated with a [FForm] widget.
///
/// A [FFormState] object can be used to [save], [reset], and [validate] every
/// [FFormField] that is a descendant of the associated [FForm].
///
/// Typically obtained via [FForm.of].
class FFormState extends State<FForm> {
  int _generation = 0;
  bool _hasInteractedByUser = false;
  final Set<FFormFieldState<dynamic>> _fields = <FFormFieldState<dynamic>>{};

  // Called when a form field has changed. This will cause all form fields
  // to rebuild, useful if form fields have interdependencies.
  void _fieldDidChange() {
    widget.onChanged?.call();

    _hasInteractedByUser = _fields.any((FFormFieldState<dynamic> field) => field._hasInteractedByUser.value);
    _forceRebuild();
  }

  void _forceRebuild() {
    setState(() {
      ++_generation;
    });
  }

  void _register(FFormFieldState<dynamic> field) {
    _fields.add(field);
  }

  void _unregister(FFormFieldState<dynamic> field) {
    _fields.remove(field);
  }

  Set<FFormFieldState<dynamic>> getFields() => _fields;

  @override
  Widget build(BuildContext context) {
    switch (widget.autovalidateMode) {
      case AutovalidateMode.always:
        _validate();
      case AutovalidateMode.onUserInteraction:
        if (_hasInteractedByUser) {
          _validate();
        }
      case AutovalidateMode.disabled:
        break;
    }

    if (widget.canPop != null || widget.onPopInvoked != null) {
      return PopScope(
        canPop: widget.canPop ?? true,
        onPopInvoked: widget.onPopInvoked,
        child: _FormScope(
          formState: this,
          generation: _generation,
          child: widget.child,
        ),
      );
    }

    return PopScope(
      canPop: widget.canPop ?? true,
      onPopInvoked: widget.onPopInvoked,
      child: _FormScope(
        formState: this,
        generation: _generation,
        child: widget.child,
      ),
    );
  }

  /// Saves every [FFormField] that is a descendant of this [FFForm].
  void save() {
    for (final field in _fields) {
      field.save();
    }
  }

  /// Resets every [FormField] that is a descendant of this [FForm] back to its
  /// [FormField.initialValue].
  ///
  /// The [FForm.onChanged] callback will be called.
  ///
  /// If the form's [FForm.autovalidateMode] property is [AutovalidateMode.always],
  /// the fields will all be revalidated after being reset.
  void reset() {
    for (final field in _fields) {
      field.reset();
    }
    _hasInteractedByUser = false;
    _fieldDidChange();
  }

  /// Validates every [FFormField] that is a descendant of this [FForm], and
  /// returns true if there are no errors.
  ///
  /// The form will rebuild to report the results.
  bool validate({Set<FFormFieldState<dynamic>>? fields}) {
    _hasInteractedByUser = true;
    _forceRebuild();
    return _validate(fields: fields);
  }

  bool _validate({Set<FFormFieldState<dynamic>>? fields}) {
    var hasError = false;
    for (final field in fields ?? _fields) {
      hasError = !field.validate() || hasError;
    }
    return !hasError;
  }

  List<FFormFieldState> getInvalidFields() {
    return _fields.where((element) => element.status == TFStatus.error).toList();
  }
}

class _FormScope extends InheritedWidget {
  const _FormScope({
    required super.child,
    required FFormState formState,
    required int generation,
  })  : _formState = formState,
        _generation = generation;

  final FFormState _formState;

  /// Incremented every time a form field has changed. This lets us know when
  /// to rebuild the form.
  final int _generation;

  /// The [FForm] associated with this widget.
  FForm get form => _formState.widget;

  @override
  bool updateShouldNotify(_FormScope old) => _generation != old._generation;
}

/// Signature for validating a form field.
///
/// Returns an error string to display if the input is invalid, or null
/// otherwise.
///
/// Used by [FFormField.validator].
typedef FFormFieldValidator<T> = FTextFieldStatus? Function(T? value);

/// Signature for being notified when a form field changes value.
///
/// Used by [FFormField.onSaved].
typedef FFormFieldSetter<T> = void Function(T? newValue);

/// Signature for building the widget representing the form field.
///
/// Used by [FFormField.builder].
typedef FormFieldBuilder<T> = Widget Function(FFormFieldState<T> field);

/// A single form field.
///
/// This widget maintains the current state of the form field, so that updates
/// and validation errors are visually reflected in the UI.
///
/// When used inside a [FForm], you can use methods on [FFormState] to query or
/// manipulate the form data as a whole. For example, calling [FFormState.save]
/// will invoke each [FFormField]'s [onSaved] callback in turn.
///
/// Use a [GlobalKey] with [FFormField] if you want to retrieve its current
/// state, for example if you want one form field to depend on another.
///
/// A [FForm] ancestor is not required. The [FForm] allows one to
/// save, reset, or validate multiple fields at once. To use without a [FForm],
/// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
/// save or reset the form field.
///
/// See also:
///
///  * [FForm], which is the widget that aggregates the form fields.
///  * [TextField], which is a commonly used form field for entering text.
class FFormField<T> extends StatefulWidget {
  /// Creates a single form field.
  const FFormField({
    super.key,
    required this.builder,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.autovalidate = false,
    this.enabled = true,
    AutovalidateMode? autovalidateMode,
    this.restorationId,
  }) : autovalidateMode = (autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled);

  /// An optional method to call with the final value when the form is saved via
  /// [FFormState.save].
  final FFormFieldSetter<T>? onSaved;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  ///
  /// The returned value is exposed by the [FFormFieldState.errorText] property.
  /// The [TextFormField] uses this to override the [InputDecoration.errorText]
  /// value.
  ///
  /// Alternating between error and normal state can cause the height of the
  /// [TextFormField] to change if no other subtext decoration is set on the
  /// field. To create a field whose height is fixed regardless of whether or
  /// not an error is displayed, either wrap the  [TextFormField] in a fixed
  /// height parent like [SizedBox], or set the [InputDecoration.helperText]
  /// parameter to a space.
  final FFormFieldValidator<T>? validator;

  /// Function that returns the widget representing this form field. It is
  /// passed the form field state as input, containing the current value and
  /// validation state of this field.
  final FormFieldBuilder<T> builder;

  /// An optional value to initialize the form field to, or null otherwise.
  final T? initialValue;

  /// Whether the form is able to receive user input.
  ///
  /// Defaults to true. If [autovalidateMode] is not [AutovalidateMode.disabled],
  /// the field will be auto validated. Likewise, if this field is false, the widget
  /// will not be validated regardless of [autovalidateMode].
  final bool enabled;

  /// Used to enable/disable this form field auto validation and update its
  /// error text.
  ///
  /// {@template flutter.widgets.FormField.autovalidateMode}
  /// If [AutovalidateMode.onUserInteraction], this FormField will only
  /// auto-validate after its content changes. If [AutovalidateMode.always], it
  /// will auto-validate even without user interaction. If
  /// [AutovalidateMode.disabled], auto-validation will be disabled.
  ///
  /// Defaults to [AutovalidateMode.disabled].
  /// {@endtemplate}
  final AutovalidateMode autovalidateMode;

  /// Restoration ID to save and restore the state of the form field.
  ///
  /// Setting the restoration ID to a non-null value results in whether or not
  /// the form field validation persists.
  ///
  /// The state of this widget is persisted in a [RestorationBucket] claimed
  /// from the surrounding [RestorationScope] using the provided restoration ID.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  final String? restorationId;

  final bool autovalidate;

  @override
  FFormFieldState<T> createState() => FFormFieldState<T>();
}

/// The current state of a [FFormField]. Passed to the [FormFieldBuilder] method
/// for use in constructing the form field's widget.
class FFormFieldState<T> extends State<FFormField<T>> with RestorationMixin {
  late T? _value = widget.initialValue;
  final RestorableBool _hasInteractedByUser = RestorableBool(false);

  final RestorableStringN _statusText = RestorableStringN(null);
  TFStatus? _status;

  /// The current value of the form field.
  T? get value => _value;

  /// The current validation error returned by the [FormField.validator]
  /// callback, or null if no errors have been triggered. This only updates when
  /// [validate] is called.
  String? get statusText => _statusText.value;
  TFStatus? get status {
    if (_status == null) {
      return TFStatus.normal;
    }
    return _status;
  }

  /// True if this field has any validation errors.
  bool get hasStatus => _status == TFStatus.error;

  /// Returns true if the user has modified the value of this field.
  ///
  /// This only updates to true once [didChange] has been called and resets to
  /// false when [reset] is called.
  bool get hasInteractedByUser => _hasInteractedByUser.value;

  /// True if the current value is valid.
  ///
  /// This will not set [errorText] or [hasError] and it will not update
  /// error display.
  ///
  /// See also:
  ///
  ///  * [validate], which may update [errorText] and [hasError].
  bool get isValid => widget.validator?.call(_value) == null;

  /// Calls the [FormField]'s onSaved method with the current value.
  void save() {
    widget.onSaved?.call(value);
  }

  /// Resets the field to its initial value.
  void reset() {
    setState(() {
      _value = widget.initialValue;
      _hasInteractedByUser.value = false;
      _statusText.value = null;
      _status = TFStatus.normal;
    });
    FForm.maybeOf(context)?._fieldDidChange();
  }

  /// Calls [FormField.validator] to set the [errorText]. Returns true if there
  /// were no errors.
  ///
  /// See also:
  ///
  ///  * [isValid], which passively gets the validity without setting
  ///    [errorText] or [hasError].
  bool validate() {
    setState(_validate);
    return !hasStatus;
  }

  void _validate() {
    if (widget.validator != null) {
      _statusText.value = widget.validator!(_value)?.message;
      _status = widget.validator!(_value)?.status;
    }
  }

  /// Updates this field's state to the new value. Useful for responding to
  /// child widget changes, e.g. [Slider]'s [Slider.onChanged] argument.
  ///
  /// Triggers the [FForm.onChanged] callback and, if [FForm.autovalidateMode] is
  /// [AutovalidateMode.always] or [AutovalidateMode.onUserInteraction],
  /// revalidates all the fields of the form.
  void didChange(T? value) {
    setState(() {
      _value = value;
      _hasInteractedByUser.value = true;
    });
    FForm.maybeOf(context)?._fieldDidChange();
  }

  /// Sets the value associated with this form field.
  ///
  /// This method should only be called by subclasses that need to update
  /// the form field value due to state changes identified during the widget
  /// build phase, when calling `setState` is prohibited. In all other cases,
  /// the value should be set by a call to [didChange], which ensures that
  /// `setState` is called.
  @protected
  // ignore: use_setters_to_change_properties, (API predates enforcing the lint)
  void setValue(T? value) {
    _value = value;
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_statusText, 'status_text');
    registerForRestoration(_hasInteractedByUser, 'has_interacted_by_user');
  }

  @override
  void deactivate() {
    FForm.maybeOf(context)?._unregister(this);
    super.deactivate();
  }

  @override
  void dispose() {
    _statusText.dispose();
    _hasInteractedByUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enabled) {
      switch (widget.autovalidateMode) {
        case AutovalidateMode.always:
          _validate();
        case AutovalidateMode.onUserInteraction:
          if (_hasInteractedByUser.value) {
            _validate();
          }
        case AutovalidateMode.disabled:
          break;
      }
    }
    FForm.maybeOf(context)?._register(this);
    return widget.builder(this);
  }
}

class FTextFieldStatus {
  final TFStatus? status;
  final String? message;
  FTextFieldStatus({this.message, this.status = TFStatus.normal});
}

enum TFStatus {
  normal,
  error,
  success,
  warning,
}

extension TFStatusColor on TFStatus {
  static const colors = {
    TFStatus.normal: FColorSkin.primaryText,
    TFStatus.error: FColorSkin.error,
    TFStatus.success: FColorSkin.success,
    TFStatus.warning: FColorSkin.warning,
  };

  Color get color => colors[this]!;
}
