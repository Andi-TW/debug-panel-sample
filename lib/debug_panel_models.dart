class BookingDebugPanelRuleElement {
  String? type;
  List<BookingDebugPanelRulesAction>? items;
  List<BookingDebugPanelRulesAction>? actions;
  List<BookingDebugPanelCondition>? conditions;
  List<BookingDebugPanelRuleElement>? success;
  List<BookingDebugPanelRuleElement>? failed;
  String? actionType;
  List<BookingDebugPanelActionComponent>? components;

  BookingDebugPanelRuleElement({
    this.type,
    this.items,
    this.actions,
    this.conditions,
    this.success,
    this.failed,
    this.actionType,
    this.components,
  });

  factory BookingDebugPanelRuleElement.fromJson(Map<String, dynamic> json) {
    final List<BookingDebugPanelRulesAction>? items = (json['items'] as List?)
        ?.map(
          (e) => BookingDebugPanelRulesAction.fromJson(e),
        )
        .toList();
    final List<BookingDebugPanelRulesAction>? actions =
        (json['actions'] as List?)
            ?.map(
              (e) => BookingDebugPanelRulesAction.fromJson(e),
            )
            .toList();
    final List<BookingDebugPanelCondition>? conditions =
        (json['conditions'] as List?)
            ?.map(
              (e) => BookingDebugPanelCondition.fromJson(e),
            )
            .toList();
    final List<BookingDebugPanelRuleElement>? success =
        (json['success'] as List?)
            ?.map(
              (e) => BookingDebugPanelRuleElement.fromJson(e),
            )
            .toList();
    final List<BookingDebugPanelRuleElement>? failed = (json['failed'] as List?)
        ?.map(
          (e) => BookingDebugPanelRuleElement.fromJson(e),
        )
        .toList();
    final List<BookingDebugPanelActionComponent>? components =
        (json['components'] as List?)
            ?.map(
              (e) => BookingDebugPanelActionComponent.fromJson(e),
            )
            .toList();
    return BookingDebugPanelRuleElement(
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

class BookingDebugPanelCondition {
  String? conditionOperator;
  String? conditionType;
  BookingDebugPanelOperand? operand;
  List<BookingDebugPanelCondition>? conditions;

  BookingDebugPanelCondition({
    this.conditionOperator,
    this.conditionType,
    this.operand,
    this.conditions,
  });

  factory BookingDebugPanelCondition.fromJson(Map<String, dynamic> json) {
    final List<BookingDebugPanelCondition>? conditions =
        (json['conditions'] as List?)
            ?.map(
              (e) => BookingDebugPanelCondition.fromJson(e),
            )
            .toList();
    return BookingDebugPanelCondition(
      conditionOperator: json['conditionOperator'] as String?,
      conditionType: json['conditionType'] as String?,
      operand: json['operand'] != null
          ? BookingDebugPanelOperand.fromJson(json['operand'])
          : null,
      conditions: conditions,
    );
  }
}

class BookingDebugPanelOperand {
  BookingDebugPanelOperandHs? lhs;
  BookingDebugPanelOperandHs? rhs;
  String? operator;

  BookingDebugPanelOperand({
    this.lhs,
    this.rhs,
    this.operator,
  });

  factory BookingDebugPanelOperand.fromJson(Map<String, dynamic> json) {
    return BookingDebugPanelOperand(
      lhs: json['lhs'] != null
          ? BookingDebugPanelOperandHs.fromJson(json['lhs'])
          : null,
      rhs: json['rhs'] != null
          ? BookingDebugPanelOperandHs.fromJson(json['rhs'])
          : null,
      operator: json['operator'] as String?,
    );
  }
}

class BookingDebugPanelOperandHs {
  String? tag;
  String? value;

  BookingDebugPanelOperandHs({
    this.tag,
    this.value,
  });

  factory BookingDebugPanelOperandHs.fromJson(Map<String, dynamic> json) {
    return BookingDebugPanelOperandHs(
      tag: json['tag'] as String?,
      value: json['value'] as String?,
    );
  }
}

class BookingDebugPanelProperty {
  String? property;
  String? value;

  BookingDebugPanelProperty({
    this.property,
    this.value,
  });

  factory BookingDebugPanelProperty.fromJson(Map<String, dynamic> json) {
    return BookingDebugPanelProperty(
      property: json['property'] as String?,
      value: json['value'] as String?,
    );
  }
}

class BookingDebugPanelActionComponent {
  String? component;
  List<BookingDebugPanelProperty>? properties;

  BookingDebugPanelActionComponent({
    this.component,
    this.properties,
  });

  factory BookingDebugPanelActionComponent.fromJson(Map<String, dynamic> json) {
    final List<BookingDebugPanelProperty>? properties =
        (json['properties'] as List?)
            ?.map(
              (e) => BookingDebugPanelProperty.fromJson(e),
            )
            .toList();
    return BookingDebugPanelActionComponent(
      component: json['component'] as String?,
      properties: properties,
    );
  }
}

class BookingDebugPanelActionReplacement {
  String? replace;
  String? replaceWith;

  BookingDebugPanelActionReplacement({
    this.replace,
    this.replaceWith,
  });

  factory BookingDebugPanelActionReplacement.fromJson(
      Map<String, dynamic> json) {
    return BookingDebugPanelActionReplacement(
      replace: json['replace'] as String?,
      replaceWith: json['with'] as String?,
    );
  }
}

class BookingDebugPanelActionVariable {
  String? variable;
  String? value;

  BookingDebugPanelActionVariable({
    this.variable,
    this.value,
  });

  factory BookingDebugPanelActionVariable.fromJson(Map<String, dynamic> json) {
    return BookingDebugPanelActionVariable(
      variable: json['variable'] as String?,
      value: json['value'] as String?,
    );
  }
}

class BookingDebugPanelActionPlaceholder {
  String? position;
  String? contents;

  BookingDebugPanelActionPlaceholder({
    this.position,
    this.contents,
  });

  factory BookingDebugPanelActionPlaceholder.fromJson(
      Map<String, dynamic> json) {
    return BookingDebugPanelActionPlaceholder(
      position: json['position'] as String?,
      contents: json['contents'] as String?,
    );
  }
}

class BookingDebugPanelRulesAction {
  String? actionType;
  List<BookingDebugPanelActionComponent>? components;
  List<BookingDebugPanelActionReplacement>? replacements;
  List<BookingDebugPanelActionVariable>? variables;
  List<BookingDebugPanelActionPlaceholder>? placeholders;

  BookingDebugPanelRulesAction({
    this.actionType,
    this.components,
    this.replacements,
    this.variables,
    this.placeholders,
  });

  factory BookingDebugPanelRulesAction.fromJson(Map<String, dynamic> json) {
    final List<BookingDebugPanelActionComponent>? components =
        (json['components'] as List?)
            ?.map(
              (e) => BookingDebugPanelActionComponent.fromJson(e),
            )
            .toList();
    final List<BookingDebugPanelActionReplacement>? replacements =
        (json['replacements'] as List?)
            ?.map(
              (e) => BookingDebugPanelActionReplacement.fromJson(e),
            )
            .toList();
    final List<BookingDebugPanelActionVariable>? variables =
        (json['variables'] as List?)
            ?.map(
              (e) => BookingDebugPanelActionVariable.fromJson(e),
            )
            .toList();
    final List<BookingDebugPanelActionPlaceholder>? placeholders =
        (json['placeholders'] as List?)
            ?.map(
              (e) => BookingDebugPanelActionPlaceholder.fromJson(e),
            )
            .toList();
    return BookingDebugPanelRulesAction(
      actionType: json['actionType'] as String?,
      components: components,
      replacements: replacements,
      variables: variables,
      placeholders: placeholders,
    );
  }
}

class BookingDebugPanelRulesTemp {
  String? name;
  List<BookingDebugPanelRuleElement>? overview;

  BookingDebugPanelRulesTemp({
    this.name,
    this.overview,
  });

  factory BookingDebugPanelRulesTemp.fromJson(Map<String, dynamic> json) {
    final List<BookingDebugPanelRuleElement>? overview =
        (json['overview'] as List?)
            ?.map(
              (e) => BookingDebugPanelRuleElement.fromJson(e),
            )
            .toList();
    return BookingDebugPanelRulesTemp(
      name: json['name'] as String?,
      overview: overview,
    );
  }
}

class BookingDebugPanelRulesetsTemp {
  String? name;
  Map<String, BookingDebugPanelRulesTemp>? rules;

  BookingDebugPanelRulesetsTemp({
    this.name,
    this.rules,
  });

  factory BookingDebugPanelRulesetsTemp.fromJson(Map<String, dynamic> json) {
    final rules = (json['rules'] as Map?)?.map(
      (key, value) {
        final rule = BookingDebugPanelRulesTemp.fromJson(value);
        return MapEntry<String, BookingDebugPanelRulesTemp>(key, rule);
      },
    );
    return BookingDebugPanelRulesetsTemp(
      name: json['name'] as String?,
      rules: rules,
    );
  }
}

class BookingDebugPanelDictionaries {
  Map<String, String>? operators;
  Map<String, BookingDebugPanelRulesetsTemp>? rulesets;

  BookingDebugPanelDictionaries({
    this.operators,
    this.rulesets,
  });

  factory BookingDebugPanelDictionaries.fromJson(Map<String, dynamic> json) {
    final rules = (json['rulesets'] as Map?)?.map(
      (key, value) {
        final rule = BookingDebugPanelRulesetsTemp.fromJson(value);
        return MapEntry<String, BookingDebugPanelRulesetsTemp>(key, rule);
      },
    );
    return BookingDebugPanelDictionaries(
      operators: (json['operators'] as Map?)?.map((key, value) => MapEntry(key, value?.toString() ?? ''),),
      rulesets: rules,
    );
  }
}

class BookingDebugPanelRulePropertyValue {
  String? current;

  BookingDebugPanelRulePropertyValue({
    this.current,
  });

  factory BookingDebugPanelRulePropertyValue.fromJson(
      Map<String, dynamic> json) {
    return BookingDebugPanelRulePropertyValue(
      current: json['current'] as String?,
    );
  }
}

class BookingDebugPanelRuleProperty {
  String? property;
  BookingDebugPanelRulePropertyValue? value;

  BookingDebugPanelRuleProperty({
    this.property,
    this.value,
  });

  factory BookingDebugPanelRuleProperty.fromJson(Map<String, dynamic> json) {
    return BookingDebugPanelRuleProperty(
      property: json['property'] as String?,
      value: json['value'] != null
          ? BookingDebugPanelRulePropertyValue.fromJson(json['value'])
          : null,
    );
  }
}

class BookingDebugPanelRule {
  String? ruleId;
  List<BookingDebugPanelRuleProperty>? variables;
  List<BookingDebugPanelRulesAction>? actions;

  BookingDebugPanelRule({
    this.ruleId,
    this.variables,
    this.actions,
  });

  factory BookingDebugPanelRule.fromJson(Map<String, dynamic> json) {
    final List<BookingDebugPanelRuleProperty>? variables =
        (json['variables'] as List?)
            ?.map(
              (e) => BookingDebugPanelRuleProperty.fromJson(e),
            )
            .toList();
    final List<BookingDebugPanelRulesAction>? actions =
        (json['actions'] as List?)
            ?.map(
              (e) => BookingDebugPanelRulesAction.fromJson(e),
            )
            .toList();
    return BookingDebugPanelRule(
      ruleId: json['ruleId'] as String?,
      variables: variables,
      actions: actions,
    );
  }
}

class BookingDebugPanelRuleSet {
  String? rulesetId;
  bool? isApplied;
  List<BookingDebugPanelRule>? executedRules;

  BookingDebugPanelRuleSet({
    this.rulesetId,
    this.isApplied,
    this.executedRules,
  });

  factory BookingDebugPanelRuleSet.fromJson(Map<String, dynamic> json) {
    final List<BookingDebugPanelRule>? executedRules = (json['executedRules'] as List?)
        ?.map(
          (e) => BookingDebugPanelRule.fromJson(e),
        ).toList();
    return BookingDebugPanelRuleSet(
      rulesetId: json['rulesetId'] as String?,
      isApplied: json['isApplied'] as bool?,
      executedRules: executedRules,
    );
  }
}

class BookingDebugPanelDebug {
  BookingDebugPanelAdminRules? adminRules;

  BookingDebugPanelDebug({
    this.adminRules,
  });

  factory BookingDebugPanelDebug.fromJson(Map<String, dynamic> json) {
    return BookingDebugPanelDebug(
      adminRules: json['adminRules'] != null
          ? BookingDebugPanelAdminRules.fromJson(json['adminRules'])
          : null,
    );
  }
}

class BookingDebugPanelAdminRules {
  List<BookingDebugPanelRuleSet>? rulesets;

  BookingDebugPanelAdminRules({
    this.rulesets,
  });

  factory BookingDebugPanelAdminRules.fromJson(Map<String, dynamic> json) {
    final List<BookingDebugPanelRuleSet>? rulesets = (json['rulesets'] as List?)
        ?.map(
          (e) => BookingDebugPanelRuleSet.fromJson(e),
        )
        .toList();
    return BookingDebugPanelAdminRules(rulesets: rulesets);
  }
}

class BookingDebugPanelResponse {
  BookingDebugPanelDebug? debug;

  BookingDebugPanelResponse({
    this.debug,
  });

  factory BookingDebugPanelResponse.fromJson(Map<String, dynamic> json) {
    return BookingDebugPanelResponse(
      debug: json['debug'] != null ? BookingDebugPanelDebug.fromJson(json['debug']) : null,
    );
  }
}
