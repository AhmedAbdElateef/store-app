import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/models/categores_model.dart';

import '../home/cubit/main_cubit.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categorisModel != null,
          builder: (context) => ListView.separated(
            physics:const BouncingScrollPhysics(),
              itemBuilder: (context, index) => coustomContainerCategory(
                  cubit.categorisModel!.data!.dataModel[index]),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
              itemCount: cubit.categorisModel!.data!.dataModel.length),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.apps_outlined,
                  size: 200,
                  color: Colors.grey[800],
                ),
                const CircularProgressIndicator(
                  color: Colors.black,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget coustomContainerCategory(DataModel model) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          model.image!,
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),),
                    child: Center(
                      child: Text(model.name! ,
                       style:const TextStyle(
                         color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600
                      ),),
                    ),
              ),
            ),
            
          ],
        ),
  );
}
