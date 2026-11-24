
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CarTable(),
  ));
}

class Car {
  final String make;
  final int model;
  final int price;

  Car(this.make, this.model, this.price);
}

class CarTable extends StatefulWidget {
  const CarTable({super.key});

  @override
  State<CarTable> createState() => _CarTableState();
}

class _CarTableState extends State<CarTable> {
  final List<Car> cars = [
    Car('Honda', 2021, 35000),
    Car('Toyota', 2011, 6000),
    Car('BMW', 2010, 9000),
  ];

  int? sortColumnIndex;
  bool sortAscending = true;

  void sortCars(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;

      cars.sort((a, b) {
        int result;

        if (columnIndex == 0) {
          result = a.make.compareTo(b.make);
        } else if (columnIndex == 1) {
          result = a.model.compareTo(b.model);
        } else {
          result = a.price.compareTo(b.price);
        }

        return ascending ? result : -result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car DataTable'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortAscending,
          columns: [
            DataColumn(
              label: const Text('Car Make'),
              onSort: (columnIndex, ascending) {
                sortCars(columnIndex, ascending);
              },
            ),
            DataColumn(
              label: const Text('Model'),
              numeric: true,
              onSort: (columnIndex, ascending) {
                sortCars(columnIndex, ascending);
              },
            ),
            DataColumn(
              label: const Text('Price'),
              numeric: true,
              onSort: (columnIndex, ascending) {
                sortCars(columnIndex, ascending);
              },
            ),
          ],
          rows: cars.map((car) {
            return DataRow(
              cells: [
                DataCell(Text(car.make)),
                DataCell(Text(car.model.toString())),
                DataCell(Text(car.price.toString())),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
