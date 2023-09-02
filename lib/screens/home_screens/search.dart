import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/models/search_model.dart';
import 'package:storeapp/screens/home/cubit/main_cubit.dart';
import 'package:storeapp/widgets/coustom_text_form.dart';

// ignore: must_be_immutable
class Search extends StatelessWidget {
  Search({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return Scaffold(
            backgroundColor: MainCubit.get(context).changeTheme
                ? Colors.black
                : Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blue,
                  )),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CoustomTextForm(
                      onChange: (textSearch) {
                        cubit.getSearchData(textSearch);
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your text for Search";
                        }
                        return null;
                      },
                      controller: text,
                      prefIcon: Icons.search,
                      prefIconColor: Colors.blue,
                      passwordText: false,
                      label: "Search",
                      text: TextInputType.text,
                      museTextColor: Colors.blue,
                      borderColor: Colors.blue,
                      borderReduse: 20,
                      labelColor: Colors.blue,
                      userTextColor: Colors.blue,
                    ),
                    const SizedBox(height: 20,),
                    if (state is LoadingGetSearchData)
                    const LinearProgressIndicator(color: Colors.blue,),
                    if (state is SuccessGetSearchData)
                    Expanded(
                      child: ListView.separated(
                        physics:const BouncingScrollPhysics(),
                        itemBuilder:(context, index) => searchContaner(cubit.getSearch!.data!.data[index] , context),
                         separatorBuilder:(context, index) => const SizedBox(height: 10)
                         , itemCount: cubit.getSearch!.data!.data.length,
                         ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
   Widget searchContaner(Data data , context) => Padding(
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
                   data.image!,
                   fit: BoxFit.fill,
                   ),
             ),
           ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SizedBox(
                 width: 200,
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
                   "price : ${data.toString()}",
                   style:  TextStyle(
                     fontSize: 16,
                     color:  MainCubit.get(context).changeTheme ? Colors.white : Colors.black
                   )),
              
             ],
           )
         ],
       ),
     ),
   );
}
