import 'package:flutter/material.dart';
import 'package:safety_app/src/data/models/dashboard_card.dart';

class DashboardCardWidget extends StatelessWidget {
  final DashboardCard card;
  const DashboardCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: _ExpandableContent(card: card),
    );
  }
}

class _ExpandableContent extends StatefulWidget {
  final DashboardCard card;
  const _ExpandableContent({required this.card});

  @override
  __ExpandableContentState createState() => __ExpandableContentState();
}

class __ExpandableContentState extends State<_ExpandableContent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Text(
            widget.card.description,
            maxLines: _isExpanded ? null : 3,
            overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 20),
        Container(color: Theme.of(context).primaryColor, height: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            style: TextButton.styleFrom(backgroundColor: Theme.of(context).secondaryHeaderColor),
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(_isExpanded ? 'Show less' : 'Show more'),
          ),
        ),
        
      ],
    );
  }
}

