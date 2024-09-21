import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_app/models/model.dart';
import 'package:flutter_practice_app/controller/api_controllar.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MVCApiCall extends StatefulWidget {
  @override
  State createState() => _ApiCallState();
}

class _ApiCallState extends StateMVC<MVCApiCall> {
  _ApiCallState() : super(ApiControllar()) {
    con = controller as ApiControllar;
  }
  late ApiControllar con;

  @override
  void initState() {
    super.initState();
    con.getCountryList();
    con.getCountriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country List'),
        actions: [
          IconButton(
              onPressed: () => Get.to(SecondApiCall(items: con.countries,)),
              icon: Icon(Icons.accessibility_new))
        ],
      ),
      body: con.country.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: con.country.length,
              itemBuilder: (context, index) {
                String code = con.country.keys.elementAt(index);
                Country country = con.country[code]!;
                return ListTile(
                  title: Text(country.name),
                  subtitle: Text('region- ${country.region}'),
                  leading: Text(code),
                );
              },
            ),
    );
  }
}

class SecondApiCall extends StatefulWidget {
  List<dynamic> items = [];
  SecondApiCall({required this.items});
  @override
  _SecondApiCallState createState() => _SecondApiCallState();
}

class _SecondApiCallState extends State<SecondApiCall> {
   final ScrollController _scrollController = ScrollController();
  List<dynamic> _displayedItems = [];
  bool _isLoading = false;
  bool _isRefreshing = false;
  int _currentPage = 0;
  final int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _fetchMoreData();
    }
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isRefreshing = true;
    });
    // Simulate a network request or data fetching
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _displayedItems = widget.items.take(_itemsPerPage).toList();
      _currentPage = 1;
      _isRefreshing = false;
    });
  }

  Future<void> _refreshData() async {
    await _loadInitialData();
  }

  Future<void> _fetchMoreData() async {
    if (_isLoading || _isRefreshing) return;
    if (_currentPage * _itemsPerPage >= widget.items.length) return; // No more data to load

    setState(() {
      _isLoading = true;
    });

    // Simulate a network request or data fetching
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _currentPage++;
      int startIndex = (_currentPage - 1) * _itemsPerPage;
      int endIndex = (_currentPage * _itemsPerPage).clamp(0, widget.items.length);
      _displayedItems.addAll(widget.items.sublist(startIndex, endIndex));
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paginated ListView')),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _displayedItems.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _displayedItems.length) {
              return Center(child: CircularProgressIndicator());
            }
            String imageUrl = _displayedItems[index]['media']['flag'];
            return ListTile(
              title: Text(_displayedItems[index]['name']),
              subtitle: Text('currency :- ${_displayedItems[index]['currency']}'),
              leading: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(Icons.circle_notifications_rounded),
                  ),
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}
