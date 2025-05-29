import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic/core/services/get_it_service.dart';
import 'package:clinic/core/utils/app_colors.dart';
import 'package:clinic/features/admin/data/models/availability_slot_model.dart';
import 'package:clinic/features/admin/presentation/cubits/admin_availability_cubit.dart';
import 'package:intl/intl.dart';

class AdminAvailabilityTab extends StatefulWidget {
  const AdminAvailabilityTab({Key? key}) : super(key: key);

  @override
  State<AdminAvailabilityTab> createState() => _AdminAvailabilityTabState();
}

class _AdminAvailabilityTabState extends State<AdminAvailabilityTab> {
  late AdminAvailabilityCubit _availabilityCubit;

  @override
  void initState() {
    super.initState();
    _availabilityCubit = getIt<AdminAvailabilityCubit>();
    _availabilityCubit.loadAvailabilitySlots();
  }

  @override
  void dispose() {
    _availabilityCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _availabilityCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Availability'),
          backgroundColor: AppColors.primaryColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => _showAddEditSlotDialog(context),
            ),
          ],
        ),
        body: BlocConsumer<AdminAvailabilityCubit, AdminAvailabilityState>(
          listener: (context, state) {
            if (state is AdminAvailabilityOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green),
              );
            } else if (state is AdminAvailabilityError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            if (state is AdminAvailabilityLoading &&
                !(state is AdminAvailabilityLoaded)) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AdminAvailabilityLoaded) {
              if (state.slots.isEmpty) {
                return const Center(
                  child: Text(
                    'No availability slots defined yet. Tap + to add.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }
              return _buildSlotsList(state.slots);
            }
            if (state is AdminAvailabilityError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(
                child: Text('Press + to add availability slots.'));
          },
        ),
      ),
    );
  }

  Widget _buildSlotsList(List<AvailabilitySlotModel> slots) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: slots.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final slot = slots[index];
        return ListTile(
          title: Text(
              '${slot.dayOfWeek}: ${DateFormat.jm().format(slot.startTime)} - ${DateFormat.jm().format(slot.endTime)}'),
          subtitle: slot.isBooked
              ? Text('Booked by: ${slot.bookedByPatientId ?? 'N/A'}',
                  style: const TextStyle(color: Colors.orange))
              : const Text('Available', style: TextStyle(color: Colors.green)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: AppColors.primaryColor),
                onPressed: () => _showAddEditSlotDialog(context, slot: slot),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => _confirmDeleteSlot(context, slot.id!),
              ),
            ],
          ),
          onTap: () => _showAddEditSlotDialog(context,
              slot: slot), // Allow editing on tap as well
        );
      },
    );
  }

  void _confirmDeleteSlot(BuildContext context, String slotId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Slot'),
        content: const Text(
            'Are you sure you want to delete this availability slot?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              _availabilityCubit.deleteAvailabilitySlot(slotId);
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddEditSlotDialog(BuildContext context,
      {AvailabilitySlotModel? slot}) async {
    final _formKey = GlobalKey<FormState>();
    // String? selectedDay = slot?.dayOfWeek; // Keep original for reference if needed
    // TimeOfDay? startTime =
    //     slot != null ? TimeOfDay.fromDateTime(slot.startTime) : null;
    // TimeOfDay? endTime =
    //     slot != null ? TimeOfDay.fromDateTime(slot.endTime) : null;

    final List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    String? localSelectedDay = slot?.dayOfWeek;
    TimeOfDay? localStartTime =
        slot != null ? TimeOfDay.fromDateTime(slot.startTime) : null;
    TimeOfDay? localEndTime =
        slot != null ? TimeOfDay.fromDateTime(slot.endTime) : null;
    bool createMultipleSlots = false; // New state variable for the checkbox

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(builder: (stfContext, stfSetState) {
          return AlertDialog(
            title: Text(slot == null
                ? 'Add Availability Slot(s)'
                : 'Edit Availability Slot'),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      decoration:
                          const InputDecoration(labelText: 'Day of the Week'),
                      value: localSelectedDay,
                      items: daysOfWeek.map((String day) {
                        return DropdownMenuItem<String>(
                            value: day, child: Text(day));
                      }).toList(),
                      onChanged: (String? newValue) {
                        stfSetState(() {
                          localSelectedDay = newValue;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select a day' : null,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      title: Text(
                          'Start Time: ${localStartTime != null ? localStartTime!.format(stfContext) : 'Select'}'),
                      trailing: const Icon(Icons.access_time),
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                            context: stfContext, // Use stfContext here
                            initialTime: localStartTime ?? TimeOfDay.now());
                        if (picked != null && picked != localStartTime) {
                          stfSetState(() {
                            localStartTime = picked;
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: Text(
                          'End Time: ${localEndTime != null ? localEndTime!.format(stfContext) : 'Select'}'),
                      trailing: const Icon(Icons.access_time),
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                            context: stfContext, // Use stfContext here
                            initialTime: localEndTime ?? TimeOfDay.now());
                        if (picked != null && picked != localEndTime) {
                          stfSetState(() {
                            localEndTime = picked;
                          });
                        }
                      },
                    ),
                    if (slot == null) // Only show for new slots
                      CheckboxListTile(
                        title: const Text('Create multiple hourly slots'),
                        value: createMultipleSlots,
                        onChanged: (bool? value) {
                          stfSetState(() {
                            createMultipleSlots = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      localSelectedDay != null &&
                      localStartTime != null &&
                      localEndTime != null) {
                    final now = DateTime.now();
                    DateTime startDateTime = DateTime(now.year, now.month,
                        now.day, localStartTime!.hour, localStartTime!.minute);
                    DateTime endDateTime = DateTime(now.year, now.month,
                        now.day, localEndTime!.hour, localEndTime!.minute);

                    if (endDateTime.isBefore(startDateTime) ||
                        endDateTime.isAtSameMomentAs(startDateTime)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('End time must be after start time.'),
                            backgroundColor: Colors.red),
                      );
                      return;
                    }

                    if (slot == null && createMultipleSlots) {
                      if (endDateTime.difference(startDateTime).inHours < 1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Duration must be at least 1 hour for multiple slots.'),
                              backgroundColor: Colors.red),
                        );
                        return;
                      }
                      DateTime currentSlotStartTime = startDateTime;
                      while (currentSlotStartTime.isBefore(endDateTime)) {
                        DateTime currentSlotEndTime =
                            currentSlotStartTime.add(const Duration(hours: 1));
                        // Ensure the generated slot does not exceed the overall end time
                        if (currentSlotEndTime.isAfter(endDateTime)) {
                          currentSlotEndTime = endDateTime;
                        }

                        final newSlot = AvailabilitySlotModel(
                          dayOfWeek: localSelectedDay!,
                          startTime: currentSlotStartTime,
                          endTime: currentSlotEndTime,
                          isBooked: false,
                        );
                        _availabilityCubit.addAvailabilitySlot(newSlot);
                        currentSlotStartTime = currentSlotEndTime;
                        // If the last created slot's end time is the overall end time, break
                        if (currentSlotStartTime.isAtSameMomentAs(endDateTime))
                          break;
                      }
                    } else {
                      final newSlot = AvailabilitySlotModel(
                        id: slot?.id,
                        dayOfWeek: localSelectedDay!,
                        startTime: startDateTime,
                        endTime: endDateTime,
                        isBooked: slot?.isBooked ?? false,
                        bookedByPatientId: slot?.bookedByPatientId,
                      );
                      if (slot == null) {
                        _availabilityCubit.addAvailabilitySlot(newSlot);
                      } else {
                        _availabilityCubit.updateAvailabilitySlot(
                            slot.id!, newSlot);
                      }
                    }
                    Navigator.pop(dialogContext);
                  }
                },
                child: Text(slot == null ? 'Add' : 'Save'),
              ),
            ],
          );
        });
      },
    );
  }
}
