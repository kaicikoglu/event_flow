// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_topic_answer_data_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetForumTopicAnswerCollection on Isar {
  IsarCollection<ForumTopicAnswer> get forumTopicAnswers => this.collection();
}

const ForumTopicAnswerSchema = CollectionSchema(
  name: r'ForumTopicAnswer',
  id: -4023472842662890904,
  properties: {
    r'answer': PropertySchema(
      id: 0,
      name: r'answer',
      type: IsarType.string,
    )
  },
  estimateSize: _forumTopicAnswerEstimateSize,
  serialize: _forumTopicAnswerSerialize,
  deserialize: _forumTopicAnswerDeserialize,
  deserializeProp: _forumTopicAnswerDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'forumTopicQuestion': LinkSchema(
      id: -3960791655407341420,
      name: r'forumTopicQuestion',
      target: r'ForumTopicQuestion',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _forumTopicAnswerGetId,
  getLinks: _forumTopicAnswerGetLinks,
  attach: _forumTopicAnswerAttach,
  version: '3.1.0+1',
);

int _forumTopicAnswerEstimateSize(
  ForumTopicAnswer object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.answer.length * 3;
  return bytesCount;
}

void _forumTopicAnswerSerialize(
  ForumTopicAnswer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.answer);
}

ForumTopicAnswer _forumTopicAnswerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ForumTopicAnswer();
  object.answer = reader.readString(offsets[0]);
  object.id = id;
  return object;
}

P _forumTopicAnswerDeserializeProp<P>(
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

Id _forumTopicAnswerGetId(ForumTopicAnswer object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _forumTopicAnswerGetLinks(ForumTopicAnswer object) {
  return [object.forumTopicQuestion];
}

void _forumTopicAnswerAttach(
    IsarCollection<dynamic> col, Id id, ForumTopicAnswer object) {
  object.id = id;
  object.forumTopicQuestion.attach(col,
      col.isar.collection<ForumTopicQuestion>(), r'forumTopicQuestion', id);
}

extension ForumTopicAnswerQueryWhereSort
    on QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QWhere> {
  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ForumTopicAnswerQueryWhere
    on QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QWhereClause> {
  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterWhereClause>
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

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterWhereClause> idBetween(
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

extension ForumTopicAnswerQueryFilter
    on QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QFilterCondition> {
  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      answerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      answerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      answerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      answerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'answer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      answerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      answerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      answerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      answerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'answer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      answerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answer',
        value: '',
      ));
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      answerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'answer',
        value: '',
      ));
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
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

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
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

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
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
}

extension ForumTopicAnswerQueryObject
    on QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QFilterCondition> {}

extension ForumTopicAnswerQueryLinks
    on QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QFilterCondition> {
  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      forumTopicQuestion(FilterQuery<ForumTopicQuestion> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'forumTopicQuestion');
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterFilterCondition>
      forumTopicQuestionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'forumTopicQuestion', 0, true, 0, true);
    });
  }
}

extension ForumTopicAnswerQuerySortBy
    on QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QSortBy> {
  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterSortBy>
      sortByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.asc);
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterSortBy>
      sortByAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.desc);
    });
  }
}

extension ForumTopicAnswerQuerySortThenBy
    on QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QSortThenBy> {
  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterSortBy>
      thenByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.asc);
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterSortBy>
      thenByAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.desc);
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension ForumTopicAnswerQueryWhereDistinct
    on QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QDistinct> {
  QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QDistinct> distinctByAnswer(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answer', caseSensitive: caseSensitive);
    });
  }
}

extension ForumTopicAnswerQueryProperty
    on QueryBuilder<ForumTopicAnswer, ForumTopicAnswer, QQueryProperty> {
  QueryBuilder<ForumTopicAnswer, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ForumTopicAnswer, String, QQueryOperations> answerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answer');
    });
  }
}
