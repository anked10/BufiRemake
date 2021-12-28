import 'package:bufi_remake/core/config/colors.dart';
import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/models/item_sub_category_model.dart';
import 'package:bufi_remake/src/pages/Explorar/tabs/ProductCategoryPage.dart';
import 'package:bufi_remake/src/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ItemSubCategoryProductsPage extends StatelessWidget {
  const ItemSubCategoryProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangePageProductos>(context, listen: false);
    final categoryBloc = ProviderBloc.category(context);
    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorPrimary,
        title: ValueListenableBuilder<String>(
            valueListenable: provider.titulo2,
            builder: (_, value, __) {
              return Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
        actions: [
          Container(
            height: ScreenUtil().setHeight(40),
            width: ScreenUtil().setWidth(40),
            child: SvgPicture.asset('assets/svg/search.svg'),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(24),
          ),
        ],
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            provider.changePage(1);
            categoryBloc.cleanStreamItemSubCategory();
          },
          child: Container(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(24),
            ),
            height: ScreenUtil().setHeight(45),
            width: ScreenUtil().setWidth(45),
            child: SvgPicture.asset('assets/svg/back.svg'),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: categoryBloc.itemsubcategoryStream,
          builder: (context, AsyncSnapshot<List<ItemSubCategoryModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                var datos = snapshot.data!;
                return ListView.builder(
                    itemCount: datos.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(24),
                              vertical: ScreenUtil().setHeight(16),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${datos[index].nameItemSubCategory}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: colorIcon,
                                  size: ScreenUtil().setSp(18),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: Color(0XFFA1A1A1),
                            thickness: 0.4,
                          ),
                        ],
                      );
                    });
              } else {
                return Text('Sin itemsubcategorías');
              }
            } else {
              return ShowLoadding(
                fondo: Colors.transparent,
                w: double.infinity,
                h: double.infinity,
                active: true,
                colorText: Colors.white,
              );
            }
          }),
    );
  }
}
