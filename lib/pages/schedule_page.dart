import 'package:flutter/material.dart';

import '../common/schedule_list.dart';
import '../core/color_schemes.dart';
import '../models/schedule_model.dart';
import '../models/shcedule_category_model.dart';
import '../providers/categories_provider.dart';
import '../providers/schedule_provider.dart';
import '../utils/general.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int? _selectedCategory;
  final ScheduleProvider scheduleProvider = ScheduleProvider();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 25, top: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Agenda',
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  FutureBuilder(
                    future: scheduleProvider.getPdf(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return InkWell(
                          onTap: () => launchURL(snapshot.data!),
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.file_download,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 30,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Text(
                'Selecciona la sala',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: CustomColors().grey,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: _roomsDropdown(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
            color: CustomColors().grey,
            child: _listSchedule(context),
          ),
        )
      ],
    );
  }

  Widget _roomsDropdown() {
    final categoriesProvider = CategoriesProvider();
    return FutureBuilder(
      future: categoriesProvider.getCategory(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ScheduleCategoryModel>> snapshot) {
        if (snapshot.hasData) {
          List<ScheduleCategoryModel> categories = snapshot.data ?? [];
          return DropdownButton(
            isExpanded: true,
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            value: _selectedCategory,
            autofocus: false,
            onChanged: (newValue) {
              setState(
                () {
                  if (newValue != null) {
                    _selectedCategory = newValue;
                  }
                },
              );
            },
            onTap: () {},
            items: categories
                .map<DropdownMenuItem<int>>((ScheduleCategoryModel category) {
              return DropdownMenuItem<int>(
                value: category.id,
                child: Text(
                  category.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.black),
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _listSchedule(context) {
    final scheduleProvider = ScheduleProvider();

    return FutureBuilder(
      future: scheduleProvider.getSchedule(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ScheduleModel>> snapshot) {
        if (snapshot.hasData) {
          List<ScheduleModel> schedules;
          if (_selectedCategory != null) {
            schedules = snapshot.data!
                .where((element) =>
                    (element.category == _selectedCategory.toString()))
                .toList();
          } else {
            schedules = snapshot.data!;
          }

          return ScheduleList(schedules: schedules);
        } else {
          return const SizedBox(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
