import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/models/get_favorites_model.dart';
import 'package:storeapp/screens/home/cubit/main_cubit.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return ConditionalBuilder(
          condition: state is ! LoadingGetFavoritesData,
          builder:(context) =>  ListView.separated(
            physics:const BouncingScrollPhysics(),
            itemBuilder: (context, index) => favoritesContaner(cubit.getFavorites!.data!.data[index].products!, context),
            separatorBuilder:(context, index) => const Divider(
              color: Colors.grey,
              endIndent: 50,
              indent: 50,
              height: 0.5,
              thickness: 1),
            itemCount: cubit.getFavorites!.data!.data.length),
          fallback:(context) =>const Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }

  Widget favoritesContaner(DetilsDataAll data , context) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue.withOpacity(0.3)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                          data.image!),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: Text(
                          data.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                            color: MainCubit.get(context).changeTheme ? Colors.white : Colors.black,
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                          "price : ${data.price.toString()}",
                          style:  TextStyle(
                            fontSize: 16,
                            color:  MainCubit.get(context).changeTheme ? Colors.white : Colors.black
                          )),
                      if (data.discount!= 0)
                        Text(
                            "OldPrice : ${data.oldPrice.toString()}",
                            style:  TextStyle(
                              color:  MainCubit.get(context).changeTheme ? Colors.red : Colors.black,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough)),
                      if (data.discount != 0)
                        Text(
                            "Discount : ${data.discount}",
                            style: const TextStyle(
                                fontSize: 17, color: Colors.red)),
                    ],
                  )
                ],
              ),
            ),
          ),
          if (data.discount != 0)
            const Padding(
              padding: EdgeInsets.only(left: 30, top: 17),
              child: Text(
                "Discount",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    backgroundColor: Colors.red,
                    fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 115,left: 340),
              child: IconButton(
                          onPressed: () {
                            MainCubit.get(context).changeFavorites(data.id!);
                            // print(model.id);
                          },
                          icon: MainCubit.get(context).favorites[data.id]!?
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          ) :const Icon(
                            Icons.favorite,
                            color: Colors.grey,
                            size: 20,
                          ) ),
            ),
        ],
      );
}
