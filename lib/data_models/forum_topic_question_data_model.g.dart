// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_topic_question_data_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetForumTopicQuestionCollection on Isar {
  IsarCollection<ForumTopicQuestion> get forumTopicQuestions =>
      this.collection();
}

const ForumTopicQuestionSchema = CollectionSchema(
  name: r'ForumTopicQuestion',
  id: 6867348753425773018,
  properties: {
    r'question': PropertySchema(
      id: 0,
      name: r'question',
      type: IsarType.string,
    )
  },
  estimateSize: _forumTopicQuestionEstimateSize,
  serialize: _forumTopicQuestionSerialize,
  deserialize: _forumTopicQuestionDeserialize,
  deserializeProp: _forumTopicQuestionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'forumTopic': LinkSchema(
      id: 1963474941398792395,
      name: r'forumTopic',
      target: r'ForumTopic',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _forumTopicQuestionGetId,
  getLinks: _forumTopicQuestionGetLinks,
  attach: _forumTopicQuestionAttach,
  version: '3.1.0+1',
);

int _forumTopicQuestionEstimateSize(
  ForumTopicQuestion object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.question.length * 3;
  return bytesCount;
}

void _forumTopicQuestionSerialize(
  ForumTopicQuestion object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.question);
}

ForumTopicQuestion _forumTopicQuestionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ForumTopicQuestion();
  object.id = id;
  object.question = reader.readString(offsets[0]);
  return object;
}

P _forumTopicQuestionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _forumTopicQuestionGetId(ForumTopicQuestion object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _forumTopicQuestionGetLinks(
    ForumTopicQuestion object) {
  return [object.forumTopic];
}

void _forumTopicQuestionAttach(
    IsarCollection<dynamic> col, Id id, ForumTopicQuestion object) {
  object.id = id;
  object.forumTopic
      .attach(col, col.isar.collection<ForumTopic>(), r'forumTopic', id);
}

extension ForumTopicQuestionQueryWhereSort
    on QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QWhere> {
  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ForumTopicQuestionQueryWhere
    on QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QWhereClause> {
  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ForumTopicQuestionQueryFilter
    on QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QFilterCondition> {
  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      questionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      questionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      questionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      questionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'question',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      questionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      questionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      questionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      questionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'question',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      questionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      questionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'question',
        value: '',
      ));
    });
  }
}

extension ForumTopicQuestionQueryObject
    on QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QFilterCondition> {}

extension ForumTopicQuestionQueryLinks
    on QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QFilterCondition> {
  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      forumTopic(FilterQuery<ForumTopic> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'forumTopic');
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterFilterCondition>
      forumTopicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'forumTopic', 0, true, 0, true);
    });
  }
}

extension ForumTopicQuestionQuerySortBy
    on QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QSortBy> {
  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterSortBy>
      sortByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterSortBy>
      sortByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }
}

extension ForumTopicQuestionQuerySortThenBy
    on QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QSortThenBy> {
  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterSortBy>
      thenByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QAfterSortBy>
      thenByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }
}

extension ForumTopicQuestionQueryWhereDistinct
    on QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QDistinct> {
  QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QDistinct>
      distinctByQuestion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'question', caseSensitive: caseSensitive);
    });
  }
}

extension ForumTopicQuestionQueryProperty
    on QueryBuilder<ForumTopicQuestion, ForumTopicQuestion, QQueryProperty> {
  QueryBuilder<ForumTopicQuestion, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ForumTopicQuestion, String, QQueryOperations>
      questionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'question');
    });
  }
}
