import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/colors_manger/colors_manger.dart';
import 'package:todo_app/core/text_manger/textStyles.dart';

class Settingstap extends StatefulWidget {
  @override
  State<Settingstap> createState() => SettingstapState();
}

class SettingstapState extends State<Settingstap> {
  String? SelectedTheme="Ligth";
  String? SelectedLangauge="English";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Theme",
            style: AppLigthStayel.settingsItemTextStyel
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 12,horizontal: 8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManger.WhiteColors,
              border: Border.all(color: Theme.of(context).dividerColor,width: 2)
            ),
            child: Row(
              children: [
                Text(
                  SelectedTheme??"" ,
                  style: AppLigthStayel.ItemViweStayel,
                ),
                Spacer(),
                DropdownButton<String>(
                  value: SelectedTheme,
                  underline: Container(color: Colors.white,),
                  style: AppLigthStayel.drobDownBottunTextStayel,
                  // value: SelectedTheme,
                  items: <String>["Ligth","Dark"].map((val)
                {
                    return DropdownMenuItem<String>(
                      value: val,
                      child:Text(val )
                    );
                  }).toList(),
                  onChanged: (selcted)
                  {
                    SelectedTheme=selcted;
                    setState(() {

                    });

                  },
                )
              ],
            ),
          ),
          SizedBox(height: 14,),
          Text(
            "Language",
            style: AppLigthStayel.settingsItemTextStyel
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 12,horizontal: 8),
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorsManger.ligthcard,
                border: Border.all(color: Theme.of(context).dividerColor,width: 2)
            ),
            child: Row(
              children: [
                Text(
                  SelectedLangauge??"",
                  style: AppLigthStayel.ItemViweStayel,
                ),
                Spacer(),
                DropdownButton<String>(
                  value: SelectedLangauge,
                  underline: Container(color: Colors.white,),
                  style: AppLigthStayel.drobDownBottunTextStayel,
                  // value: SelectedTheme??"",
                  items: <String>["English","Arabic",].map((val)
                  {
                    return DropdownMenuItem<String>(
                        value: val,
                        child:Text(val )
                    );
                  }).toList(),
                  onChanged: (selcted)
                  {
                    SelectedLangauge=selcted;
                    setState(() {
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
