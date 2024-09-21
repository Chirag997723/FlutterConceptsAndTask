import 'package:flutter/material.dart';
import 'package:flutter_practice_app/provider/count_provider.dart';
import 'package:flutter_practice_app/provider/theme_provider.dart';
import 'package:flutter_practice_app/screen/cart_screen.dart';
import 'package:flutter_practice_app/screen/ui/bloc_api.dart';
import 'package:flutter_practice_app/screen/ui/counter_screen.dart';
import 'package:flutter_practice_app/controller/myController.dart';
import 'package:flutter_practice_app/widgets/productCard.dart';
import 'package:flutter_practice_app/screen/ui/news_api.dart';
import 'package:flutter_practice_app/screen/ui/switch_screen.dart';
import 'package:flutter_practice_app/screen/ui/task_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class StateManagement extends StatelessWidget {
  var taskName = [
    'GetX',
    'ApiCallGetx',
    'CounterProvider',
    'BlocEx',
    'SwitchScreen',
    'BlocApi',
    'BlocApi2',
    'BlocApi3',
    'TaskScreen',
    'NewsApi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'appHeading',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: taskName.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(taskName[index]),
            leading: Icon(Icons.insert_emoticon),
            subtitle: Text(index.toString()),
            onTap: () {
              switch (index) {
                case 0:
                  Get.to(GetXActivity());
                  break;
                case 1:
                  Get.to(ApiCallGetx());
                  break;
                case 2:
                  Get.to(CounterProvider());
                  break;
                case 3:
                  Get.to(CounterScreen());
                  break;
                case 4:
                  Get.to(SwitchScreen());
                  break;
                case 5:
                  Get.to(BlocApi());
                  break;
                case 6:
                  Get.to(BlocPara1());
                  break;
                case 7:
                  Get.to(BlocPara2());
                  break;
                case 8:
                  Get.to(TaskScreen());
                  break;
                case 9:
                  Get.to(NewsApi());
                  break;
              }
            },
          );
        },
      ),
    );
  }
}

class CounterProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build');
    return ChangeNotifierProvider<CountProvider>(
      create: (_) => CountProvider(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'CounterProvider',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Consumer<CountProvider>(
            builder: (context, value, child) {
              return Text(
                value.counter.toString(),
                style: TextStyle(fontSize: 20),
              );
            },
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            final provider = Provider.of<CountProvider>(context, listen: false);
            return FloatingActionButton(
              onPressed: () {
                provider.increment();
              },
              child: Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}

class ApiCallGetx extends StatelessWidget {
  var proController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ApiCall',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () => Get.to(CartScreen()),
              child: Stack(
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Consumer<ThemeProvider>(
                        builder: (context, value, child) {
                          return Text(
                            value.cartItems.length.toString(),
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (proController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: proController.productList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.57,
              ),
              itemBuilder: (context, index) {
                final product = proController.productList[index];
                return ProductCard(
                  productName: product.title!,
                  productPrice: product.price!,
                  productImage: product.image!,
                  index: index,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class GetXActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'GetXActivity',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder(
                init: MyController(),
                builder: (controller) => Text('${controller.counter}')),
            ElevatedButton(
                onPressed: () {
                  var myCon = Get.find<MyController>();
                  myCon.increment();
                },
                child: Text('counting'))
          ],
        ),
      ),
    );
  }
}
