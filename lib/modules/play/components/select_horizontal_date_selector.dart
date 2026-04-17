
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectHorizontalDateSelector extends StatefulWidget{
  final Function(DateTime date) onChangeSelectedDate;
  final DateTime initialDate;
  const SelectHorizontalDateSelector({super.key, required this.onChangeSelectedDate, required this.initialDate});


  @override
  State<StatefulWidget> createState() => _SelectHorizontalDateSelectorState();
}

class _SelectHorizontalDateSelectorState extends State<SelectHorizontalDateSelector>{

  DateTime _selectedDate = DateTime.now();
  final ScrollController _controller = ScrollController();
  final List<DateTime> _dates = [];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _generateDates();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _generateDates(){
    final now = DateTime.now();
    for(int i = 0; i < 12; i++){
      _dates.add(now.add(Duration(days: i)));
    }
  }
  void _onDateSelected(DateTime date){
    setState(() {
      _selectedDate = date;
    });
    widget.onChangeSelectedDate(date);
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: const Locale('ru', 'RU'),
      initialDate: _selectedDate,
      firstDate: _dates.first,
      lastDate: _dates.last,
      builder: (BuildContext context, Widget? child){
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              onSurface: Colors.black
            )
          ),
          child: child ?? const SizedBox(),
        );
      }
    );
    if(pickedDate != null && pickedDate != _selectedDate){
      final int index = _dates.indexWhere((date) =>
      date.year == pickedDate.year &&
          date.month == pickedDate.month &&
          date.day == pickedDate.day
      );

      if (index != -1) {
        _onDateSelected(pickedDate);

        // Прокрутка к выбранному элементу
        _controller.animateTo(
          index * 30.0, // ширина одного элемента (примерно)
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: _dates.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){

                final date = _dates[index];
                final isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month && date.year == _selectedDate.year;
                return GestureDetector(
                  onTap: () => _onDateSelected(date),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: isSelected ? Color.fromRGBO(149, 255, 92, 1) : Colors.white,
                        border: Border.all(color: isSelected ? Colors.transparent : Color.fromRGBO(3, 135, 52, 1), width: 1.5)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat("EEE").format(date),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          DateFormat('d').format(date),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          IconButton(
              onPressed: (){
                _showDatePicker(context);
              },
              icon: Icon(Icons.calendar_month_outlined)
          )
        ],
      ),
    );
  }
}