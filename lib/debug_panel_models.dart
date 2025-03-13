class RuleElement {
  String? type;
  List<RulesAction>? items;
  List<RulesAction>? actions;
  List<Condition>? conditions;
  List<RuleElement>? success;
  List<RuleElement>? failed;
  String? actionType;
  List<ActionComponent>? components;

  RuleElement({
    this.type,
    this.items,
    this.actions,
    this.conditions,
    this.success,
    this.failed,
    this.actionType,
    this.components,
  });

  factory RuleElement.fromJson(Map<String, dynamic> json) {
    final List<RulesAction>? items = (json['items'] as List?)
        ?.map(
          (e) => RulesAction.fromJson(e),
        ).toList();
    final List<RulesAction>? actions = (json['actions'] as List?)
        ?.map(
          (e) => RulesAction.fromJson(e),
        ).toList();
    final List<Condition>? conditions = (json['conditions'] as List?)
        ?.map(
          (e) => Condition.fromJson(e),
        ).toList();
    final List<RuleElement>? success = (json['success'] as List?)
        ?.map(
          (e) => RuleElement.fromJson(e),
        ).toList();
    final List<RuleElement>? failed = (json['failed'] as List?)
        ?.map(
          (e) => RuleElement.fromJson(e),
        ).toList();
    final List<ActionComponent>? components = (json['components'] as List?)
        ?.map(
          (e) => ActionComponent.fromJson(e),
        ).toList();
    return RuleElement(
      type: json['type'] as String?,
      items: items,
      actions: actions,
      conditions: conditions,
      success: success,
      failed: failed,
      actionType: json['actionType'] as String?,
      components: components,
    );
  }
}

class Condition {
  String? conditionOperator;
  String? conditionType;
  Operand? operand;
  List<Condition>? conditions;

  Condition({
    this.conditionOperator,
    this.conditionType,
    this.operand,
    this.conditions,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    final List<Condition>? conditions = (json['conditions'] as List?)
        ?.map(
          (e) => Condition.fromJson(e),
        ).toList();
    return Condition(
      conditionOperator: json['conditionOperator'] as String?,
      conditionType: json['conditionType'] as String?,
      operand: json['operand'] != null ? Operand.fromJson(json['operand']) : null,
      conditions: conditions,
    );
  }
}

class Operand {
  OperandHs? lhs;
  OperandHs? rhs;
  String? operator;

  Operand({this.lhs, this.rhs, this.operator,});

  factory Operand.fromJson(Map<String, dynamic> json) {
    return Operand(
      lhs: json['lhs'] != null ? OperandHs.fromJson(json['lhs']) : null,
      rhs: json['rhs'] != null ? OperandHs.fromJson(json['rhs']) : null,
      operator: json['operator'] as String?,
    );
  }
}

class OperandHs {
  String? tag;
  String? value;

  OperandHs({this.tag, this.value,});

  factory OperandHs.fromJson(Map<String, dynamic> json) {
    return OperandHs(
      tag: json['tag'] as String?,
      value: json['value'] as String?,
    );
  }
}

class Property {
  String? property;
  String? value;

  Property({this.property, this.value,});

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      property: json['property'] as String?,
      value: json['value'] as String?,
    );
  }
}

class ActionComponent {
  String? component;
  List<Property>? properties;

  ActionComponent({
    this.component,
    this.properties,
  });

  factory ActionComponent.fromJson(Map<String, dynamic> json) {
    final List<Property>? properties = (json['properties'] as List?)
        ?.map(
          (e) => Property.fromJson(e),
        ).toList();
    return ActionComponent(
      component: json['component'] as String?,
      properties: properties,
    );
  }
}

class ActionReplacement {
  String? replace;
  String? replaceWith;

  ActionReplacement({this.replace, this.replaceWith,});

  factory ActionReplacement.fromJson(Map<String, dynamic> json) {
    return ActionReplacement(
      replace: json['replace'] as String?,
      replaceWith: json['with'] as String?,
    );
  }
}

class ActionVariable {
  String? variable;
  String? value;

  ActionVariable({this.variable, this.value,});

  factory ActionVariable.fromJson(Map<String, dynamic> json) {
    return ActionVariable(
      variable: json['variable'] as String?,
      value: json['value'] as String?,
    );
  }
}

class ActionPlaceholder {
  String? position;
  String? contents;

  ActionPlaceholder({this.position, this.contents,});

  factory ActionPlaceholder.fromJson(Map<String, dynamic> json) {
    return ActionPlaceholder(
      position: json['position'] as String?,
      contents: json['contents'] as String?,
    );
  }
}

class RulesAction {
  String? actionType;
  List<ActionComponent>? components;
  List<ActionReplacement>? replacements;
  List<ActionVariable>? variables;
  List<ActionPlaceholder>? placeholders;

  RulesAction({
    this.actionType,
    this.components,
    this.replacements,
    this.variables,
    this.placeholders,
  });

  factory RulesAction.fromJson(Map<String, dynamic> json) {
    final List<ActionComponent>? components = (json['components'] as List?)
        ?.map(
          (e) => ActionComponent.fromJson(e),
        ).toList();
    final List<ActionReplacement>? replacements = (json['replacements'] as List?)
        ?.map(
          (e) => ActionReplacement.fromJson(e),
        ).toList();
    final List<ActionVariable>? variables = (json['variables'] as List?)
        ?.map(
          (e) => ActionVariable.fromJson(e),
        ).toList();
    final List<ActionPlaceholder>? placeholders = (json['placeholders'] as List?)
        ?.map(
          (e) => ActionPlaceholder.fromJson(e),
        ).toList();
    return RulesAction(
      actionType: json['actionType'] as String?,
      components: components,
      replacements: replacements,
      variables: variables,
      placeholders: placeholders,
    );
  }
}

class RulesTemp {
  String? name;
  List<RuleElement>? overview;

  RulesTemp({
    this.name,
    this.overview,
  });

  factory RulesTemp.fromJson(Map<String, dynamic> json) {
    final List<RuleElement>? overview = (json['overview'] as List?)
        ?.map(
          (e) => RuleElement.fromJson(e),
        ).toList();
    return RulesTemp(
      name: json['name'] as String?,
      overview: overview,
    );
  }
}

class RulesetsTemp {
  String? name;
  Map<String, RulesTemp>? rules;

  RulesetsTemp({
    this.name,
    this.rules,
  });

  factory RulesetsTemp.fromJson(Map<String, dynamic> json) {
    final rules = (json['rules'] as Map?)?.map(
      (key, value) {
        final rule = RulesTemp.fromJson(value);
        return MapEntry<String, RulesTemp>(key, rule);
      },
    );
    return RulesetsTemp(name: json['name'] as String?, rules: rules,);
  }
}

class Dictionaries {
  Map<String, String>? operators;
  Map<String, RulesetsTemp>? rulesets;

  Dictionaries({
    this.operators,
    this.rulesets,
  });

  factory Dictionaries.fromJson(Map<String, dynamic> json) {
    final rules = (json['rulesets'] as Map?)?.map(
      (key, value) {
        final rule = RulesetsTemp.fromJson(value);
        return MapEntry<String, RulesetsTemp>(key, rule);
      },
    );
    return Dictionaries(
      operators: (json['operators'] as Map?)?.map((key, value) => MapEntry(key, value?.toString() ?? ''),),
      rulesets: rules,
    );
  }
}

class RulePropertyValue {
  String? current;

  RulePropertyValue({this.current,});

  factory RulePropertyValue.fromJson(Map<String, dynamic> json) {
    return RulePropertyValue(
      current: json['current'] as String?,
    );
  }
}

class RuleProperty {
  String? property;
  RulePropertyValue? value;

  RuleProperty({
    this.property,
    this.value,
  });

  factory RuleProperty.fromJson(Map<String, dynamic> json) {
    return RuleProperty(
      property: json['property'] as String?,
      value: json['value'] != null ? RulePropertyValue.fromJson(json['value']) : null,
    );
  }
}

class Rule {
  String? ruleId;
  List<RuleProperty>? variables;
  List<RulesAction>? actions;

  Rule({
    this.ruleId,
    this.variables,
    this.actions,
  });

  factory Rule.fromJson(Map<String, dynamic> json) {
    final List<RuleProperty>? variables = (json['variables'] as List?)
        ?.map(
          (e) => RuleProperty.fromJson(e),
        ).toList();
    final List<RulesAction>? actions = (json['actions'] as List?)
        ?.map(
          (e) => RulesAction.fromJson(e),
        ).toList();
    return Rule(
      ruleId: json['ruleId'] as String?,
      variables: variables,
      actions: actions,
    );
  }
}

class RuleSet {
  String? rulesetId;
  bool? isApplied;
  List<Rule>? executedRules;

  RuleSet({
    this.rulesetId,
    this.isApplied,
    this.executedRules,
  });

  factory RuleSet.fromJson(Map<String, dynamic> json) {
    final List<Rule>? executedRules = (json['executedRules'] as List?)
        ?.map(
          (e) => Rule.fromJson(e),
        ).toList();
    return RuleSet(
      rulesetId: json['rulesetId'] as String?,
      isApplied: json['isApplied'] as bool?,
      executedRules: executedRules,
    );
  }
}

class Debug {
  AdminRules? adminRules;

  Debug({this.adminRules,});

  factory Debug.fromJson(Map<String, dynamic> json) {
    return Debug(
      adminRules: json['adminRules'] != null ? AdminRules.fromJson(json['adminRules']) : null,
    );
  }
}

class AdminRules {
  Dictionaries? dictionaries;
  List<RuleSet>? rulesets;

  AdminRules({
    this.dictionaries,
    this.rulesets,
  });

  factory AdminRules.fromJson(Map<String, dynamic> json) {
    final List<RuleSet>? rulesets = (json['rulesets'] as List?)
        ?.map(
          (e) => RuleSet.fromJson(e),
        ).toList();
    return AdminRules(
      dictionaries: json['dictionaries'] != null ? Dictionaries.fromJson(json['dictionaries']) : null,
      rulesets: rulesets,
    );
  }
}

class DebugPanelResponse {
  Debug? debug;

  DebugPanelResponse({
    this.debug,
  });

  factory DebugPanelResponse.fromJson(Map<String, dynamic> json) {
    return DebugPanelResponse(
      debug: json['debug'] != null ? Debug.fromJson(json['debug']) : null,
    );
  }
}