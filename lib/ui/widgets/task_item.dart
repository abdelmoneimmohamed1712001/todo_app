import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5,),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .3,
          motion: StretchMotion(),
          children: [
            SlidableAction(onPressed: (context) {

            },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'remove',
            )
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: .3,
          motion: StretchMotion(),
          children: [
            SlidableAction(

              // An action can be bigger than the others.
              flex: 1,
              onPressed: (context) {

              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),


          ],
        ),


        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Play basket ball',style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(height: 5,),
                    Text('Play basket ball',style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: 5,),
                    const Row(
                      children: [
                        Icon(Icons.date_range),
                        SizedBox(width: 5,),
                        Text('31 / 8 / 2024')
                      ],
                    ),

                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {

                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 21),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor),
                      child: const Icon(
                        (Icons.check),
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
