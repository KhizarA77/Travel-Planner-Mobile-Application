import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // Adjust the height of the container
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(25), // Rounded corners
        border:
            Border.all(color: Colors.grey, width: 1), // Border color and width
      ),
      child: Row(
        children: [
          SizedBox(width: 15), // Left padding
          Icon(
            Icons.search,
            color: Colors.grey, // Icon color
          ),
          SizedBox(width: 10), // Spacing between icon and text
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search places', // Placeholder text
                hintStyle: TextStyle(
                  color: Colors.grey, // Hint text color
                  fontSize: 16, // Font size
                ),
                border: InputBorder.none, // Remove the border
              ),
              onChanged: (value) {
                // Handle search input changes
                print('Search input: $value');
              },
            ),
          ),
          VerticalDivider(
            color: Colors.grey, // Divider color
            width: 1, // Divider thickness
            indent: 10, // Top padding for divider
            endIndent: 10, // Bottom padding for divider
          ),
          IconButton(
            icon: Icon(
              Icons.tune, // Filter icon
              color: Colors.grey, // Icon color
            ),
            onPressed: () {
              // Action for filter button
              print('Filter button clicked');
            },
          ),
        ],
      ),
    );
  }
}
