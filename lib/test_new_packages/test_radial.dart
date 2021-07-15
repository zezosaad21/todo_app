import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<GDPdata> _chargeData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _chargeData = getChargeData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 300,
          child: SfCircularChart(
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              RadialBarSeries<GDPdata, String>(
                maximumValue: 100,
                dataSource: _chargeData,
                xValueMapper: (GDPdata data, _) => data.contenent,
                yValueMapper: (GDPdata data, _) => data.gdb,
                dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                enableTooltip: true,
              )
            ],
          ),
        ),
      ),
    );
  }

  List<GDPdata> getChargeData() {
    final List<GDPdata> chargData = [
      GDPdata('Ahmed', 40),
      GDPdata('zezo', 60),
      GDPdata('fatma', 80),
      GDPdata('mama', 20),
      GDPdata('saad', 50),
    ];
    return chargData;
  }
}

class GDPdata {
  final String contenent;
  final int gdb;

  GDPdata(this.contenent, this.gdb);
}
