import 'dart:convert';

import 'package:debug_panel_sample/common_debug_panel_widget.dart';
import 'package:debug_panel_sample/debug_panel_models.dart';
import 'package:debug_panel_sample/debug_panel_view.dart';
import 'package:debug_panel_sample/scrollable_debug_panel_view.dart';
import 'package:flutter/material.dart';
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
      // home: const DebugPanelPage(),
      home: CommonDebugPanelWidget(
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

class DebugPanelPage extends StatelessWidget {
  const DebugPanelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Debug Panel Demo Page',
        ),
      ),
      body: DebugPanelView(
        response: DebugPanelResponse.fromJson(jsonDecode(dataJson)),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

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
      "dictionaries": {
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
      },
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