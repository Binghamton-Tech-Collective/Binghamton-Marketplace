import "package:flutter/material.dart";

/// Resusable circular widget for showing categories
class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Column(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              "https://media.licdn.com/dms/image/D4E03AQH1m-DsPxkXkQ/profile-displayphoto-shrink_800_800/0/1663694541598?e=2147483647&v=beta&t=jbiXqn5fY7dJUCgtYZ9a_KZrYWRmCHzg0YkJBdGoURg",
            ),
          ),
          Text(
            "Textbooks",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      );
}
