import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lojaapp/core/architeture/bloc_builder.dart';
import 'package:lojaapp/features/categories/domain/entities/categories_entity.dart';
import 'package:lojaapp/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:lojaapp/features/home/presentation/ui/home_screen.dart';
import 'package:lojaapp/features/home/presentation/widgets/custom_drawer_widgets.dart';

import '../../../../core/architeture/bloc_state.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late CategoriesBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: BlocScreenBuilder(
            stream: bloc.state,
            builder: (state) {
              if (state is BlocStableState) {
                List<CategoriesEntity> categories = state.data!;

                return ListView(
                  children: categories.map((e) => Text(e.name)).toList(),
                );
              } else {
                return const SizedBox.shrink();
              }
            }));
  }
}
