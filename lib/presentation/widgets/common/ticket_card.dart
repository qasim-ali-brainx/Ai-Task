import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/view_constants.dart';
import '../../../domain/models/ticket_entity.dart';
import 'app_chip.dart';

class TicketCard extends StatefulWidget {
  const TicketCard({required this.ticket, required this.onTap, super.key});
  final TicketEntity ticket;
  final VoidCallback onTap;

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final Color priorityColor = widget.ticket.priority == 'High'
        ? ColorConstants.priorityHigh
        : widget.ticket.priority == 'Medium'
            ? ColorConstants.priorityMedium
            : ColorConstants.priorityLow;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _isPressed ? 0.98 : 1,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: ViewConstants.spacingSm),
          padding: const EdgeInsets.all(ViewConstants.spacingLg),
          decoration: BoxDecoration(
            color: ColorConstants.backgroundCard,
            borderRadius: BorderRadius.circular(12),
            border: Border(left: BorderSide(color: priorityColor, width: 4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.ticket.title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: ViewConstants.spacingSm),
              Row(
                children: <Widget>[
                  AppChip(label: widget.ticket.priority),
                  const SizedBox(width: ViewConstants.spacingSm),
                  Text('${widget.ticket.complexityPoints} SP'),
                ],
              ),
              const SizedBox(height: ViewConstants.spacingSm),
              Text(
                widget.ticket.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
