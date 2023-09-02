import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storeapp/models/categores_model.dart';
import 'package:storeapp/models/products_model.dart';
import 'package:storeapp/screens/home/cubit/main_cubit.dart';
import 'package:storeapp/widgets/coustom_toast.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is SuccessFavoritesData) {
          if (state.model.status == false) {
            coustomToast(
                message: state.model.message!,
                bgColor: Colors.red,
                textColor: Colors.white,
                lengthMessage: Toast.LENGTH_LONG,
                whereMessage: ToastGravity.BOTTOM);
          }
        }
      },
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categorisModel != null,
            builder: (context) => productBuilder(
                cubit.homeModel!, cubit.categorisModel!, context),
            fallback: (context) =>const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: 200,
                        color: Colors.blue,
                      ),
                       CircularProgressIndicator(
                        color: Colors.blue,
                      )
                    ],
                  ),
                ));
      },
    );
  }

  Widget productBuilder(
          HomeData model, CategorisModel categorisModel, context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: CarouselSlider(
              items: model.data!.banners
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          image: DecorationImage(
                            image: NetworkImage(
                              "${e.image}",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  height: 170,
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Categoris",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 80,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    coutomCategory(categorisModel.data!.dataModel[index]),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: categorisModel.data!.dataModel.length),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "New Productes",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              color: MainCubit.get(context).changeTheme ? Colors.black : Colors.grey.shade300,
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 1 / 1.65,
                children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        gridProducts(model.data!.products[index], context)),
              ),
            ),
          ),
        ],
      );

  Widget coutomCategory(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.network(height: 100, width: 100,  fit: BoxFit.cover,"${model.image}"),
          Container(
            height: 20,
            width: 100,
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.7)),
            child: Text(
              "${model.name}",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          )
        ],
      );

  Widget gridProducts(ProductModel model, context) => Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
              color: MainCubit.get(context).changeTheme ? Colors.blue.withOpacity(0.3):Colors.white, 
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        model.image!,
                        height: 200,
                        width: double.infinity,
                      ),
                      if (model.discount != 0)
                        const Text(
                          "Discount",
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.red,
                              fontSize: 15),
                        )
                    ],
                  ),
                  Text(
                    model.name!,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: MainCubit.get(context).changeTheme ? Colors.white : Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       "Price : ${ model.price.toString()}",
                        style: const TextStyle(color: Colors.green),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          "Old Price : ${model.oldPrice.toString()}",
                          style: const TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          "Discount :${model.discount.toString()}%",
                          style: const TextStyle(color: Colors.blue),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          MainCubit.get(context).changeFavorites(model.id!);
                          // print(model.id);
                        },
                        icon: MainCubit.get(context).favorites[model.id]!?
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ) :const Icon(
                          Icons.favorite,
                          color: Colors.grey,
                          size: 20,
                        ) ),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       FontAwesomeIcons.cartPlus,
                    //       color: Colors.grey[600],
                    //       size: 20,
                    //     )),
                  ],
                ),
              )
            ]),
          ),
        ),
      );
}
