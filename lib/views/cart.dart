import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../features/cart/bloc.dart';
import '../features/update_cart_item/bloc.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});
  @override
  State<CartView> createState() => _CartViewState();
}
class _CartViewState extends State<CartView> {
  final CartBloc bloc = GetIt.I<CartBloc>();
  final updateBloc=GetIt.I<UpdateCartItemBloc>();// Correct type and reference
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("السلة",style: TextStyle(color:
        Theme.of(context).primaryColor),),centerTitle: true,
      ),
      body: BlocBuilder(
        bloc: bloc, // Use the correct bloc instance
        builder: (context, state) {
          if (state is GetCartFailedState) {
            return Center(child: Text(state.msg));
          } else if (state is GetCartSuccessState) {
            return Column(
              children: [
                Expanded(
                    child: Container(
                      child: ListView.separated(
                          padding: EdgeInsets.all(16),
                          itemBuilder: (context, index) => _Item
                            (model: state.model.list[index],
                            updatebloc:updateBloc,
                            onUpdate: () {
                              setState(() {});
                            },
                            onDeletePress: () {
                              state.model.list.remove(index);
                              setState(() {});
                            },),

                          separatorBuilder: (context, index) =>SizedBox(height: 16.h,)
                          , itemCount: state.model.list.length),
                    )),
                Container(
                  padding: EdgeInsets.all(16),
                  // height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "عندك كوبون؟ ادخل رقم الكوبون"
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),
                          FilledButton(onPressed: () {
                          }, child: Text("تطبيق"))
                        ],
                      ),
                      SizedBox(height: 8,),
                      Center(child: Text("جميع الاسعار تشمل قيمة الضريبه المضافه %15${state.model.vat}%")),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("إجمالى المنتجات"),
                                Text(" ${state.model.totalBeforeDiscount} ر.س"),

                              ],
                            ),
                            SizedBox(height: 16,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("الخصم"),
                                Text("${state.model.totalDiscountCart} ر.س"),
                              ],
                            ),
                            Divider(color: Colors.white,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("الاجمالى"),
                                Text(" ${state.model.totalAfterDiscount} ر.س"),
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).primaryColor.withOpacity(.3)
                        ),
                      ),
                      FilledButton(onPressed: () {

                      }, child: Text("goToCompleteOrder".tr()))
                    ],
                  ),
                  //  color: Colors.red,
                  width: double.infinity,
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _Item extends StatefulWidget {
  final ProductModel model;
  final UpdateCartItemBloc updatebloc;
  final VoidCallback onDeletePress,onUpdate;
  const _Item({super.key, required this.model, required this.onDeletePress, required this.onUpdate, required this.updatebloc});

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {





  int count=1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              widget.model.image,
              height:70 ,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16,),
          Expanded(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.model.title),
              Row(
                children: [
                  Text("${widget.model.price}ر.س",style: TextStyle(
                      color: Theme.of(context).primaryColor
                  ),),
                  SizedBox(width: 4,),
                  Text("${widget.model.priceBeforeDiscount}ر.س"
                    ,style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Theme.of(context).primaryColor
                    ),),
                ],),
              Container(
                padding: EdgeInsets.symmetric
                  (horizontal: 4,vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocListener(
                      bloc:widget.updatebloc,
                      listener: (BuildContext context, state) {
                        if(state is UpdateCartItemSuccessState &&
                            state.id==widget.model.id&&state.isAdd)
                        {
                          print("listener");
                          widget.model.plus() ;
                          setState(() {});
                          widget.onUpdate();
                        }
                      },
                      child: GestureDetector(
                          onTap:(){
                            widget.updatebloc.add(
                                UpdateCartItemEvent(
                                    id: widget.model.id,
                                    isAdd: false,
                                    amount:widget.model.amount)
                            );
                          },
                          child: Container(color: Colors.white,child:
                          Icon(Icons.add,size: 30,
                              color: Theme.of(context).primaryColor))),
                    ),
                    SizedBox(width: 4,),
                    Text("$count",style: TextStyle(color:
                    Theme.of(context).primaryColor),),
                    SizedBox(width: 4,),
                    BlocListener(
                      bloc: widget.updatebloc,
                      listener: (context, state) {
                        if(state is UpdateCartItemSuccessState&& state.id
                            ==widget.model.id && !state.isAdd)
                        {
                          print("listener");
                          widget.model.minus();
                          setState(() {});
                          widget.onUpdate();
                        }
                      },
                      child: GestureDetector(
                          onTap: () {
                            widget.updatebloc.add(
                                UpdateCartItemEvent(
                                    id: widget.model.id,
                                    isAdd: true,
                                    amount:widget.model.amount)
                            );
                          },
                          child: Container(color: Colors.white,child:
                          Icon(Icons.remove,size: 30,  color: Theme.of(context).primaryColor))),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                ),)
            ],
          )),
          IconButton(onPressed:widget.onDeletePress,
              icon: Icon(Icons.delete_forever,color: Colors.red,))
        ],
      ),
    );
  }
}
