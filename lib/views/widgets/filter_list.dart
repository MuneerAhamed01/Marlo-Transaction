import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transactions/utils/styles.dart';

enum FilterListType { selection, range }

class FilterList extends StatefulWidget {
  const FilterList({
    super.key,
    this.items,
    this.active,
    this.onPressed,
    required this.title,
    this.type = FilterListType.selection,
    this.onChanged,
    this.minAmount,
    this.maxAmount,
  });

  final List<String>? items;
  final String? active;
  final Function(String?)? onPressed;
  final String title;
  final FilterListType type;
  final Function(int?, int?)? onChanged;
  final int? minAmount;
  final int? maxAmount;

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  final Color _active = const Color(0xffE7F7FC);
  final Color _textColor = const Color(0xff0CABDF);

  String? _activeItem;

  @override
  void initState() {
    super.initState();
    _activeItem = widget.active;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == FilterListType.range) return _rangeSelector();
    return _selectionSelector();
  }

  Container _selectionSelector() {
    return _wrapWitTitleAndBackground(
      Wrap(
        runSpacing: 8,
        spacing: 8,
        children: widget.items!.map((e) => _buildButtons(e)).toList(),
      ),
    );
  }

  Container _wrapWitTitleAndBackground(Widget child) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Styles.notoSans.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          child
        ],
      ),
    );
  }

  Widget _rangeSelector() {
    return _wrapWitTitleAndBackground(
      _CustomNumberTextField(
        onChanged: widget.onChanged!,
        maxAmount: widget.maxAmount,
        minAmount: widget.minAmount,
      ),
    );
  }

  Widget _buildButtons(String text) {
    final isActive = _activeItem == text;
    return GestureDetector(
      onTap: () {
        if (_activeItem == text) {
          setState(() {
            _activeItem = null;
          });
          widget.onPressed?.call(null);
          return;
        }
        setState(() {
          _activeItem = text;
        });
        widget.onPressed?.call(text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            color: isActive ? _active : null,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: Styles.notoSans.copyWith(
            fontSize: 14,
            color: isActive ? _textColor : const Color(0xff979797),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _CustomNumberTextField extends StatefulWidget {
  final Function(int?, int?) onChanged;
  final int? minAmount;
  final int? maxAmount;

  const _CustomNumberTextField(
      {required this.onChanged, this.minAmount, this.maxAmount});

  @override
  State<_CustomNumberTextField> createState() => _CustomNumberTextFieldState();
}

class _CustomNumberTextFieldState extends State<_CustomNumberTextField> {
  final TextEditingController _controllerMin = TextEditingController();

  final TextEditingController _controllerMax = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerMax.text = (widget.maxAmount ?? '').toString();
    _controllerMin.text = (widget.minAmount ?? '').toString();
    _controllerMax.addListener(_onChangeAmount);
    _controllerMin.addListener(_onChangeAmount);
  }

  _onChangeAmount() {
    widget.onChanged.call(
        int.tryParse(_controllerMin.text), int.tryParse(_controllerMax.text));
  }

  @override
  void dispose() {
    super.dispose();
    _controllerMax.removeListener(_onChangeAmount);
    _controllerMin.removeListener(_onChangeAmount);
    _controllerMax.dispose();
    _controllerMin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _textField(_controllerMin, 'Minimum'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _textField(_controllerMax, 'Maximum'),
        )
      ],
    );
  }

  Stack _textField(TextEditingController controller, String label) {
    return Stack(
      children: [
        Container(
          height: 51.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFE9EEF0),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8.0).copyWith(top: 30),
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0).copyWith(bottom: 2),
          child: Text(
            label,
            style: Styles.notoSans.copyWith(
              fontSize: 12,
              color: const Color(0xff979797),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
