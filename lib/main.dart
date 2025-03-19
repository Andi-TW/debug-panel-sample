import 'dart:convert';

import 'package:debug_panel_sample/common_debug_panel/common_debug_panel_widget.dart';
import 'package:debug_panel_sample/debug_panel_models.dart';
import 'package:debug_panel_sample/debug_panel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CommonDebugPanelWidget(
        decoration: CommonDebugPanelWidgetDecorationImpl(),
        label: CommonDebugPanelWidgetLabel(
          buttonLabel: 'Debug Panel',
        ),
        child: Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              'App Page',
              style: TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DebugPanelButtonDecorationImpl implements DebugPanelButtonDecoration {
  @override
  Color? get backgroundColor => const Color(0xFFF0F3F5);

  @override
  Color? get textColor => const Color(0xFF1F4074);

  @override
  Widget get image => SvgPicture.asset(
        'assets/bug.svg',
        fit: BoxFit.scaleDown,
      );
}

class CommonDebugPanelWidgetDecorationImpl
    implements CommonDebugPanelWidgetDecoration {
  @override
  DebugPanelButtonDecoration get buttonDecoration =>
      DebugPanelButtonDecorationImpl();
}

class BookingDebugPanelRulesSetContentViewDecorationImpl implements BookingDebugPanelRulesSetContentViewDecoration {
  @override
  TextStyle get captionLabelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Colors.black,
      );

  @override
  TextStyle get tagLabelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF0066B3),
      );

  @override
  TextStyle get valueLabelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF1DB36E),
      );

  @override
  BookingDebugPanelOverviewWidgetDecoration get overviewWidgetDecoration =>
      BookingDebugPanelOverviewWidgetDecorationImpl();

  @override
  BookingDebugPanelSectionDecoration get sectionDecoration =>
      BookingDebugPanelSectionDecorationImpl();
  
  @override
  BookingDebugPanelExecutedRulesViewDecoration get executedRulesViewDecoration =>
      BookingDebugPanelExecutedRulesViewDecorationImpl();
}

class BookingDebugPanelSectionDecorationImpl implements BookingDebugPanelSectionDecoration {
  @override
  Color? get bgColor => const Color(0xFFFFFFFF);

  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Colors.black,
      );

  @override
  Color? get titleBgColor => const Color(0xFFE1E7EA);
}

class SubBookingDebugPanelSectionDecorationImpl
    implements BookingDebugPanelSectionDecoration {
  @override
  Color? get bgColor => const Color(0xFFFFFFFF);

  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Colors.black,
      );

  @override
  Color? get titleBgColor => const Color(0xFFFCF5E6);
}

class BookingDebugPanelConditionPillContentViewDecorationImpl
    implements BookingDebugPanelPillContentViewDecoration {
  @override
  Color get color => const Color(0xFFE6A935);

  @override
  TextStyle get titleStyle => const TextStyle(
        color: Color(0xFFE6A935),
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );

  @override
  Color? get bgColor => Colors.white;
}

class ActionBookingDebugPanelPillContentViewDecorationImpl implements BookingDebugPanelPillContentViewDecoration {
  @override
  Color get color => const Color(0xFF0066B3);

  @override
  TextStyle get titleStyle => const TextStyle(
        color: Color(0xFF0066B3),
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );

  @override
  Color? get bgColor => Colors.white;
}

class BookingDebugPanelOverviewWidgetDecorationImpl
    implements BookingDebugPanelOverviewWidgetDecoration {
  @override
  BookingDebugPanelConditionViewDecoration get conditionViewDecoration =>
      BookingDebugPanelConditionViewDecorationImpl();

  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12.0,
        color: Color(0xFF333333),
      );

  @override
  TextStyle get tagStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10,
        color: Color(0xFFA7B6BF),
      );

  @override
  TextStyle get valueStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 10,
        color: Color(0xFF333333),
      );

  @override
  BookingDebugPanelPillContentViewDecoration get actionPillContentViewDecoration =>
      ActionBookingDebugPanelPillContentViewDecorationImpl();
}

class BookingDebugPanelConditionViewDecorationImpl
    implements BookingDebugPanelConditionViewDecoration {
  @override
  TextStyle get conditionCompareLabelStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12.0,
        color: Color(0xFFE6A935),
      );

  @override
  TextStyle get tagStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10,
        color: Color(0xFFA7B6BF),
      );

  @override
  TextStyle get valueStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 10,
        color: Color(0xFF333333),
      );

  @override
  BookingDebugPanelPillContentViewDecoration get conditionPillContentViewDecoration =>
      BookingDebugPanelConditionPillContentViewDecorationImpl();

  @override
  BookingDebugPanelConditionResultViewDecoration get positiveConditionResultViewDecoration =>
      GreenBookingDebugPanelConditionResultViewDecorationImpl();

  @override
  BookingDebugPanelConditionResultViewDecoration get negativeConditionResultViewDecoration => RedBookingDebugPanelConditionResultViewDecorationImpl();

  @override
  BookingDebugPanelPillContentViewDecoration get actionPillContentViewDecoration =>
      ActionBookingDebugPanelPillContentViewDecorationImpl();

  @override
  BookingDebugPanelEmptyActionViewDecoration get emptyActionViewDecoration =>
      BookingDebugPanelEmptyActionViewDecorationImpl();

  @override
  BookingDebugPanelConditionCompareDetailsViewDecoration
      get conditionCompareDetailsViewDecoration =>
          BookingDebugPanelConditionCompareDetailsViewDecorationImpl();
}

class BookingDebugPanelExecutedRulesViewDecorationImpl implements BookingDebugPanelExecutedRulesViewDecoration {
  @override
  TextStyle get captionLabelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Colors.black,
      );

  @override
  TextStyle get tagLabelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF0066B3),
      );

  @override
  TextStyle get valueLabelStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF1DB36E),
      );

  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: Color(0xFF1F4074),
      );

  @override
  BookingDebugPanelSectionDecoration get subSectionDecoration => SubBookingDebugPanelSectionDecorationImpl();
}

class BookingDebugPanelScrollableContentDecorationImpl
    implements BookingDebugPanelScrollableContentDecoration {
  @override
  Color? get thumbColor => const Color(0xFF0D4689);

  @override
  BookingDebugPanelRulesSetContentViewDecoration
      get rulesSetContentViewDecoration =>
          BookingDebugPanelRulesSetContentViewDecorationImpl();
}

class BookingDebugPanelEmptyActionViewDecorationImpl implements BookingDebugPanelEmptyActionViewDecoration {
  @override
  Color? get bgColor => const Color(0xFFFAFBFC);

  @override
  Color? get borderColor => const Color(0xFFCED8DD);

  @override
  TextStyle get labelStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12.0,
        color: Color(0xFFCED8DD),
      );
}

class GreenBookingDebugPanelConditionResultViewDecorationImpl
    implements BookingDebugPanelConditionResultViewDecoration {
  @override
  Color? get bgColor => const Color(0xFFEAF8F8);

  @override
  TextStyle get expandButtonStyle => const TextStyle(
        color: Colors.white,
        fontSize: 8.0,
      );

  @override
  Color? get color => const Color(0xFF00AFAD);

  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10.0,
        color: Color(0xFF00AFAD),
      );
}

class RedBookingDebugPanelConditionResultViewDecorationImpl
    implements BookingDebugPanelConditionResultViewDecoration {
  @override
  Color? get bgColor => const Color(0xFFFCEDF0);

  @override
  TextStyle get expandButtonStyle => const TextStyle(
        color: Colors.white,
        fontSize: 8.0,
      );

  @override
  Color? get color => const Color(0xFFD1223E);

  @override
  TextStyle get titleStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10.0,
        color: Color(0xFFD1223E),
      );
}

class BookingDebugPanelTagLabelDecorationImpl
    implements BookingDebugPanelTagLabelDecoration {
  final Color? backgroundColor;

  BookingDebugPanelTagLabelDecorationImpl({required this.backgroundColor});

  @override
  Color? get bgColor => backgroundColor;

  @override
  TextStyle get labelStyle => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10,
        color: Colors.white,
      );
}

class BookingDebugPanelConditionCompareDetailsViewDecorationImpl
    implements BookingDebugPanelConditionCompareDetailsViewDecoration {
  @override
  TextStyle get descriptionTextStyle => const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 10,
        color: Color(0xFF333333),
      );

  @override
  TextStyle get operatorTextStyle => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 10,
        color: Color(0xFFD1223E),
      );

  @override
  BookingDebugPanelTagLabelDecoration get lhsTagLabelDecoration =>
      BookingDebugPanelTagLabelDecorationImpl(
          backgroundColor: const Color(0xFFA7B6BF));

  @override
  BookingDebugPanelTagLabelDecoration get rhsTagLabelDecoration =>
      BookingDebugPanelTagLabelDecorationImpl(
          backgroundColor: const Color(0xFF1DB36E));
}

const dictionariesJson = '''
{
    "operators": {
        "has": "contains",
        "eq": "is equal to",
        "ne": "is not equal to",
        "gt": "is greater than",
        "gte": "is greater than or equal to",
        "lt": "is less than",
        "lte": "is less than or equal to",
        "in": "is in list",
        "nin": "is not in list",
        "all": "contains all",
        "regex": "matches pattern"
    },
    "rulesets": {
        "88866fb8-76d7-4b4f-9773-40e6d5e0aca2": {
            "name": "Flight Selection Page",
            "rules": {
                "99f10e19-0b85-4c3a-9c30-a9db9633f295": {
                    "name": "Test Rule",
                    "overview": [
                        {
                            "type": "condition",
                            "conditions": [
                                {
                                    "conditionType": "single",
                                    "operand": {
                                        "lhs": {
                                            "tag": "App",
                                            "value": "Aircraft Type"
                                        },
                                        "operator": "eq",
                                        "rhs": {
                                            "tag": "Lit",
                                            "value": "A312"
                                        }
                                    }
                                },
                                {
                                    "conditionOperator": "AND",
                                    "conditionType": "group",
                                    "conditions": [
                                        {
                                            "conditionType": "single",
                                            "operand": {
                                                "lhs": {
                                                    "tag": "App",
                                                    "value": "Aircraft Type"
                                                },
                                                "operator": "eq",
                                                "rhs": {
                                                    "tag": "Lit",
                                                    "value": "A321, A320, A333"
                                                }
                                            }
                                        },
                                        {
                                            "conditionOperator": "OR",
                                            "conditionType": "single",
                                            "operand": {
                                                "lhs": {
                                                    "tag": "App",
                                                    "value": "First Origin Check"
                                                },
                                                "operator": "eq",
                                                "rhs": {
                                                    "tag": "Lit",
                                                    "value": "true"
                                                }
                                            }
                                        },
                                        {
                                            "conditionOperator": "AND",
                                            "conditionType": "group",
                                            "conditions": [
                                                {
                                                    "conditionType": "single",
                                                    "operand": {
                                                        "lhs": {
                                                            "tag": "App",
                                                            "value": "Aircraft Type"
                                                        },
                                                        "operator": "eq",
                                                        "rhs": {
                                                            "tag": "Lit",
                                                            "value": "A321, A320, A333"
                                                        }
                                                    }
                                                },
                                                {
                                                    "conditionOperator": "OR",
                                                    "conditionType": "single",
                                                    "operand": {
                                                        "lhs": {
                                                            "tag": "App",
                                                            "value": "First Origin Check"
                                                        },
                                                        "operator": "eq",
                                                        "rhs": {
                                                            "tag": "Lit",
                                                            "value": "true"
                                                        }
                                                    }
                                                }
                                            ]
                                        }
                                    ]
                                },
                                {
                                    "conditionOperator": "AND",
                                    "conditionType": "single",
                                    "operand": {
                                        "lhs": {
                                            "tag": "App",
                                            "value": "Has Selected Insurance"
                                        },
                                        "operator": "eq",
                                        "rhs": {
                                            "tag": "App",
                                            "value": "Is Time To Think Selected"
                                        }
                                    }
                                }
                            ],
                            "success": [
                                {
                                    "type": "action",
                                    "actions": [
                                        {
                                            "actionType": "Set Component Configuration",
                                            "components": [
                                                {
                                                    "component": "Credit Card Fee",
                                                    "properties": [
                                                        {
                                                            "property": "Should Display",
                                                            "value": "true"
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                },
                                {
                                    "type": "action",
                                    "actions": [
                                        {
                                            "actionType": "Replace Localisation",
                                            "replacements": [
                                                {
                                                    "replace": "old-localisation-key",
                                                    "with": "new-localisation-key"
                                                }
                                            ]
                                        }
                                    ]
                                },
                                {
                                    "type": "action",
                                    "actions": [
                                        {
                                            "actionType": "Set Variable",
                                            "variables": [
                                                {
                                                    "variable": "Flow Type",
                                                    "value": "booking"
                                                }
                                            ]
                                        }
                                    ]
                                },
                                {
                                    "type": "action",
                                    "actions": [
                                        {
                                            "actionType": "Set Placeholder",
                                            "placeholders": [
                                                {
                                                    "position": "top",
                                                    "contents": "ph-en-m-flight-selection-mid-PricePerPax-my"
                                                }
                                            ]
                                        }
                                    ]
                                },
                                {
                                    "type": "condition",
                                    "conditions": [
                                        {
                                            "conditionType": "single",
                                            "operand": {
                                                "lhs": {
                                                    "tag": "App",
                                                    "value": "Aircraft Type"
                                                },
                                                "operator": "eq",
                                                "rhs": {
                                                    "tag": "Lit",
                                                    "value": "A321"
                                                }
                                            }
                                        }
                                    ],
                                    "success": [
                                        {
                                            "type": "action",
                                            "actions": [
                                                {
                                                    "actionType": "Set Component Configuration",
                                                    "components": [
                                                        {
                                                            "component": "Credit Card Fee",
                                                            "properties": [
                                                                {
                                                                    "property": "Should Display",
                                                                    "value": "true"
                                                                }
                                                            ]
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ],
                            "failed": [
                                {
                                    "type": "action",
                                    "actions": [
                                        {
                                            "actionType": "Set Component Configuration",
                                            "components": [
                                                {
                                                    "component": "Enrich Quick SignUp",
                                                    "properties": [
                                                        {
                                                            "property": "Should Display",
                                                            "value": "true"
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                },
                                {
                                    "type": "condition",
                                    "conditions": [
                                        {
                                            "conditionType": "single",
                                            "operand": {
                                                "lhs": {
                                                    "tag": "App",
                                                    "value": "Aircraft Type"
                                                },
                                                "operator": "eq",
                                                "rhs": {
                                                    "tag": "Lit",
                                                    "value": "A321"
                                                }
                                            }
                                        }
                                    ],
                                    "success": [
                                        {
                                            "type": "action",
                                            "actions": [
                                                {
                                                    "actionType": "Set Component Configuration",
                                                    "components": [
                                                        {
                                                            "component": "Credit Card Fee",
                                                            "properties": [
                                                                {
                                                                    "property": "Should Display",
                                                                    "value": "true"
                                                                }
                                                            ]
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                },
                "fdc1b305-7a38-4de8-808b-a18f1c1d15b6": {
                    "name": "Skip Shopping cart & Credit Card Fee",
                    "overview": [
                        {
                            "type": "action",
                            "items": [
                                {
                                    "actionType": "Set Component Configuration",
                                    "components": [
                                        {
                                            "component": "Cart Summary Page",
                                            "properties": [
                                                {
                                                    "property": "Should Display",
                                                    "value": "true"
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            "type": "action",
                            "items": [
                                {
                                    "actionType": "Set Component Configuration",
                                    "components": [
                                        {
                                            "component": "Credit Card Fee",
                                            "properties": [
                                                {
                                                    "property": "Should Display",
                                                    "value": "true"
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                },
                "671b702e-9958-4c07-9734-746985b21e14": {
                    "name": "Change Flight Button",
                    "overview": [
                        {
                            "actionType": "Set Component Configuration",
                            "components": [
                                {
                                    "component": "Change Flight Button",
                                    "properties": [
                                        {
                                            "property": "Is Enabled",
                                            "value": "true"
                                        },
                                        {
                                            "property": "Applicable Flow Types",
                                            "value": "check-in"
                                        },
                                        {
                                            "property": "Button Display Delay",
                                            "value": "1"
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            "actionType": "Set Component Configuration",
                            "components": [
                                {
                                    "component": "Change Flight Button",
                                    "properties": [
                                        {
                                            "property": "Is Enabled",
                                            "value": "true"
                                        },
                                        {
                                            "property": "Applicable Flow Types",
                                            "value": "check-in"
                                        },
                                        {
                                            "property": "Button Display Delay",
                                            "value": "1"
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
            }
        }
    }
}
''';

const dataJson = '''
{
  "data": {
    "bookingStepper": {
      "shouldDisplay": true
    },
    "cartSummaryPage": {
      "shouldDisplay": true,
      "attributes": {
        "loader": {
          "shouldDisplay": true,
          "attributes": {
            "title": "loader.cart-summary.title",
            "description": "loader.cart-summary.description",
            "image": ""
          }
        }
      }
    },
    "flightSelectionPage": {
      "attributes": {
        "loader": {
          "shouldDisplay": true,
          "attributes": {
            "title": "loader.fare-selection.title",
            "description": "loader.fare-selection.description",
            "image": "https://uat.malaysiaairlines.com/content/dam/mh/dsp/general/loader/Upgrade.jpg"
          }
        }
      }
    },
    "header": {
      "attributes": {
        "logo": {
          "shouldDisplay": true
        },
        "shoppingCartIcon": {
          "shouldDisplay": true
        },
        "stepper": {
          "shouldDisplay": true
        }
      }
    },
    "lateLogin": {
      "isEnabled": true
    },
    "passengerPage": {
      "inputFields": {
        "title": {
          "isEditable": true
        },
        "firstName": {
          "isEditable": true
        },
        "lastName": {
          "isEditable": true
        },
        "email": {
          "isEditable": true
        },
        "frequentFlyer": {
          "isEditable": true
        }
      },
      "attributes": {
        "loader": {
          "shouldDisplay": true,
          "attributes": {
            "title": "loader.passenger.title",
            "description": "loader.passenger.description",
            "image": "https://uat.malaysiaairlines.com/content/dam/mh/dsp/general/loader/Enrich.jpg"
          }
        }
      }
    },
    "shareItineraryFeature": {
      "isEnabled": false
    }
  },
  "debug": {
    "adminRules": {
      "rulesets": [
        {
          "rulesetId": "88866fb8-76d7-4b4f-9773-40e6d5e0aca2",
          "isApplied": true,
          "executedRules": [
            {
              "ruleId": "99f10e19-0b85-4c3a-9c30-a9db9633f295",
              "variables": [
                {
                  "property": "aircraftType",
                  "value": {
                    "current": "A321"
                  }
                },
                {
                  "property": "officeId",
                  "value": {
                    "current": "MH08FG"
                  }
                }
              ],
              "actions": [
                {
                  "actionType": "Set Component Configuration",
                  "components": [
                    {
                      "component": "Credit Card Fee",
                      "properties": [
                        {
                          "property": "Should Display",
                          "value": "true"
                        }
                      ]
                    }
                  ]
                },
                {
                  "actionType": "Set Component Configuration",
                  "components": [
                    {
                      "component": "Cart Summary Page",
                      "properties": [
                        {
                          "property": "Should Display",
                          "value": "true"
                        }
                      ]
                    }
                  ]
                },
                {
                  "actionType": "Replace Localisation",
                  "replacements": [
                    {
                      "replace": "old-localisation-key",
                      "with": "new-localisation-key"
                    }
                  ]
                },
                {
                  "actionType": "Set Variable",
                  "variables": [
                    {
                      "variable": "Flow Type",
                      "value": "booking"
                    }
                  ]
                },
                {
                  "actionType": "Set Placeholder",
                  "placeholders": [
                    {
                      "position": "top",
                      "contents": "ph-en-m-flight-selection-mid-PricePerPax-my"
                    }
                  ]
                }
              ]
            },
            {
              "ruleId": "fdc1b305-7a38-4de8-808b-a18f1c1d15b6",
              "variables": [
                {
                  "property": "aircraftType",
                  "value": {
                    "current": "A321"
                  }
                },
                {
                  "property": "officeId",
                  "value": {
                    "current": "MH08FG"
                  }
                }
              ],
              "actions": [
                {
                  "actionType": "Set Component Configuration",
                  "components": [
                    {
                      "component": "Cart Summary Page",
                      "properties": [
                        {
                          "property": "Should Display",
                          "value": "true"
                        }
                      ]
                    }
                  ]
                },
                {
                  "actionType": "Set Component Configuration",
                  "components": [
                    {
                      "component": "Credit Card Fee",
                      "properties": [
                        {
                          "property": "Should Display",
                          "value": "true"
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "ruleId": "671b702e-9958-4c07-9734-746985b21e14",
              "variables": [
                {
                  "property": "aircraftType",
                  "value": {
                    "current": "A321"
                  }
                },
                {
                  "property": "officeId",
                  "value": {
                    "current": "MH08FG"
                  }
                }
              ],
              "actions": [
                {
                  "actionType": "Set Component Configuration",
                  "components": [
                    {
                      "component": "Change Flight Button",
                      "properties": [
                        {
                          "property": "Is Enabled",
                          "value": "true"
                        },
                        {
                          "property": "Applicable Flow Types",
                          "value": "check-in"
                        },
                        {
                          "property": "Button Display Delay",
                          "value": "0"
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  }
}
''';