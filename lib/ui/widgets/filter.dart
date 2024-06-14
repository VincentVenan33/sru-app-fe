import 'dart:ui';

import 'package:flutter/material.dart';

import '../shared/spacings.dart';

class FilterBottom {
  static void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          // ignore: deprecated_member_use
          height: window.physicalSize.height * 0.3,
          padding: const EdgeInsets.only(
            top: 24,
            right: 12,
            left: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Pilih Slab',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Spacings.verSpace(
                7,
              ),
              const Row(
                children: [
                  Text(
                    'Gudang : Palmerah',
                    style: TextStyle(
                      color: Color(0xFF636C6D),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              Spacings.verSpace(
                28.5,
              ),
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.broken_image_rounded,
                    ),
                    Spacings.horSpace(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '000000216220000068',
                            style: TextStyle(
                              color: Color(0xFF8F8F8F),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacings.verSpace(
                            6,
                          ),
                          const Text(
                            'Slab a1',
                            style: TextStyle(
                              color: Color(0xFF8F8F8F),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacings.verSpace(
                            6,
                          ),
                          const Text(
                            'amadeus white - SLAB - URAT POLISH ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                    ),
                  ],
                ),
              ),
              Spacings.verSpace(
                16,
              ),
              const Divider(
                thickness: 1,
                color: Color(0xFFEBEBEB),
              ),
              Spacings.verSpace(
                16,
              ),
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.broken_image_rounded,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '000000216220000069',
                          style: TextStyle(
                            color: Color(0xFF8F8F8F),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacings.verSpace(
                          6,
                        ),
                        const Text(
                          'Slab a2',
                          style: TextStyle(
                            color: Color(0xFF8F8F8F),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacings.verSpace(
                          6,
                        ),
                        const Text(
                          'amadeus white - SLAB - URAT POLISH ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                    ),
                  ],
                ),
              ),
              Spacings.verSpace(
                16,
              ),
              const Divider(
                thickness: 1,
                color: Color(0xFFEBEBEB),
              ),
              Spacings.verSpace(
                16,
              ),
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.broken_image_rounded,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '000000216220000070',
                          style: TextStyle(
                            color: Color(0xFF8F8F8F),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacings.verSpace(
                          6,
                        ),
                        const Text(
                          'Slab a3',
                          style: TextStyle(
                            color: Color(0xFF8F8F8F),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacings.verSpace(
                          6,
                        ),
                        const Text(
                          'amadeus white - SLAB - URAT POLISH ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
