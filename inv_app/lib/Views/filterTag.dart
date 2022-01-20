import 'package:flutter/material.dart';

Widget myTagsChipUIWidget({
  tagModel,
  onTap,
  action,
  selected,
}) {
  return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 5.0,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: selected ? Colors.green : Colors.blueAccent[100],
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Text(
                "${tagModel.name}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ));
}
