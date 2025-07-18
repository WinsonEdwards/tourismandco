import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _searchController = TextEditingController();
  List<Location> _searchResults = [];
  bool _isSearching = false;
  String _error = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchCities(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _error = '';
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = '';
    });

    try {
      final results = await _weatherService.searchCities(query);
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isSearching = false;
      });
    }
  }

  Future<void> _selectCity(Location location) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );

    try {
      final weather = await _weatherService.getWeatherByCoordinates(
        location.latitude,
        location.longitude,
      );
      Navigator.pop(context); // Close loading dialog
      Navigator.pop(context, weather); // Return weather data
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading weather data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Cities'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter city name...',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.white),
                        onPressed: () {
                          _searchController.clear();
                          _searchCities('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {});
                _searchCities(value);
              },
            ),
          ).animate().slideY(begin: -0.3, end: 0),
          Expanded(
            child: _isSearching
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _error.isNotEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Error searching cities',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _error,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : _searchResults.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  _searchController.text.isEmpty
                                      ? 'Search for a city to see weather'
                                      : 'No cities found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              final location = _searchResults[index];
                              return Card(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(
                                      Icons.location_city,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(
                                    location.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    location.state != null
                                        ? '${location.state}, ${location.country}'
                                        : location.country,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey[400],
                                  ),
                                  onTap: () => _selectCity(location),
                                ),
                              )
                                  .animate(delay: (index * 100).ms)
                                  .fadeIn(duration: 300.ms)
                                  .slideX(begin: 0.3, end: 0);
                            },
                          ),
          ),
        ],
      ),
    );
  }
}