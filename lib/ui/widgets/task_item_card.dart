import 'package:flutter/material.dart';

class ItemTaskCard extends StatelessWidget {
  const ItemTaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Lorem Ipsum is simply dummy",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const Text(
                "Lorem Ipsum is simply dummy, Lorem Ipsum is simply dummy Lorem Ipsum is simply dummy"),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Date: 15/11/2023",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Chip(label: Text("New", style: TextStyle(
                  color: Colors.white,
                ),), backgroundColor: Colors.blue,),
                Wrap(
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever_outlined, color: Colors.red,),
                    ),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.edit, color: Colors.green,),),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}