import 'package:app/logic/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cart.dart';
import 'components/category_section/view.dart';
import 'components/products/view.dart';
import 'components/slider/view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed:
        () {
          navigateTo(CartView());
        }, icon: Icon(Icons.shopping_cart,color:
         Colors.white,))],
        title: Text("منتجاتنا",style:
        TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff16A124),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Column(
            children: [
               const SliderSection(),
              SizedBox(height: 16.h,),
                const CategorySection(),
              SizedBox(height: 16.h,),
                const ProductsSection(),
            ]),
      ) ,
    );
  }
}