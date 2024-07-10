// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voting_topic_data_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVotingTopicCollection on Isar {
  IsarCollection<VotingTopic> get votingTopics => this.collection();
}

const VotingTopicSchema = CollectionSchema(
  name: r'VotingTopic',
  id: -1604314939566518728,
  properties: {
    r'createdDate': PropertySchema(
      id: 0,
      name: r'createdDate',
      type: IsarType.dateTime,
    ),
    r'eventId': PropertySchema(
      id: 1,
      name: r'eventId',
      type: IsarType.long,
    ),
    r'isSelected': PropertySchema(
      id: 2,
      name: r'isSelected',
      type: IsarType.bool,
    ),
    r'topicTitle': PropertySchema(
      id: 3,
      name: r'topicTitle',
      type: IsarType.string,
    )
  },
  estimateSize: _votingTopicEstimateSize,
  serialize: _votingTopicSerialize,
  deserialize: _votingTopicDeserialize,
  deserializeProp: _votingTopicDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'event': LinkSchema(
      id: -4632711996499431852,
      name: r'event',
      target: r'Event',
      single: true,
    ),
    r'options': LinkSchema(
      id: 1967809603987702637,
      name: r'options',
      target: r'VoteOption',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _votingTopicGetId,
  getLinks: _votingTopicGetLinks,
  attach: _votingTopicAttach,
  version: '3.1.0+1',
);

int _votingTopicEstimateSize(
  VotingTopic object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.topicTitle.length * 3;
  return bytesCount;
}

void _votingTopicSerialize(
  VotingTopic object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdDate);
  writer.writeLong(offsets[1], object.eventId);
  writer.writeBool(offsets[2], object.isSelected);
  writer.writeString(offsets[3], object.topicTitle);
}

VotingTopic _votingTopicDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VotingTopic();
  object.createdDate = reader.readDateTime(offsets[0]);
  object.eventId = reader.readLong(offsets[1]);
  object.id = id;
  object.topicTitle = reader.readString(offsets[3]);
  return object;
}

P _votingTopicDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _votingTopicGetId(VotingTopic object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _votingTopicGetLinks(VotingTopic object) {
  return [object.event, object.options];
}

void _votingTopicAttach(
    IsarCollection<dynamic> col, Id id, VotingTopic object) {
  object.id = id;
  object.event.attach(col, col.isar.collection<Event>(), r'event', id);
  object.options.attach(col, col.isar.collection<VoteOption>(), r'options', id);
}

extension VotingTopicQueryWhereSort
    on QueryBuilder<VotingTopic, VotingTopic, QWhere> {
  QueryBuilder<VotingTopic, VotingTopic, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VotingTopicQueryWhere
    on QueryBuilder<VotingTopic, VotingTopic, QWhereClause> {
  QueryBuilder<VotingTopic, VotingTopic, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<VotingTopic, VotingTopic, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterWhereClause> idBetween(
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

extension VotingTopicQueryFilter
    on QueryBuilder<VotingTopic, VotingTopic, QFilterCondition> {
  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      createdDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdDate',
        value: value,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      createdDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdDate',
        value: value,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      createdDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdDate',
        value: value,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      createdDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition> eventIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventId',
        value: value,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      eventIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventId',
        value: value,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition> eventIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventId',
        value: value,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition> eventIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition> idBetween(
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

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      isSelectedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSelected',
        value: value,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      topicTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topicTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      topicTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topicTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      topicTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topicTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      topicTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topicTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      topicTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'topicTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      topicTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'topicTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      topicTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'topicTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      topicTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'topicTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      topicTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topicTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      topicTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'topicTitle',
        value: '',
      ));
    });
  }
}

extension VotingTopicQueryObject
    on QueryBuilder<VotingTopic, VotingTopic, QFilterCondition> {}

extension VotingTopicQueryLinks
    on QueryBuilder<VotingTopic, VotingTopic, QFilterCondition> {
  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition> event(
      FilterQuery<Event> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'event');
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition> eventIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'event', 0, true, 0, true);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition> options(
      FilterQuery<VoteOption> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'options');
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      optionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'options', length, true, length, true);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      optionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'options', 0, true, 0, true);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      optionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'options', 0, false, 999999, true);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      optionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'options', 0, true, length, include);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      optionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'options', length, include, 999999, true);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterFilterCondition>
      optionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'options', lower, includeLower, upper, includeUpper);
    });
  }
}

extension VotingTopicQuerySortBy
    on QueryBuilder<VotingTopic, VotingTopic, QSortBy> {
  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> sortByCreatedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdDate', Sort.asc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> sortByCreatedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdDate', Sort.desc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> sortByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.asc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> sortByEventIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.desc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> sortByIsSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.asc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> sortByIsSelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.desc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> sortByTopicTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicTitle', Sort.asc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> sortByTopicTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicTitle', Sort.desc);
    });
  }
}

extension VotingTopicQuerySortThenBy
    on QueryBuilder<VotingTopic, VotingTopic, QSortThenBy> {
  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> thenByCreatedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdDate', Sort.asc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> thenByCreatedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdDate', Sort.desc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> thenByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.asc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> thenByEventIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.desc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> thenByIsSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.asc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> thenByIsSelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.desc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> thenByTopicTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicTitle', Sort.asc);
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QAfterSortBy> thenByTopicTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicTitle', Sort.desc);
    });
  }
}

extension VotingTopicQueryWhereDistinct
    on QueryBuilder<VotingTopic, VotingTopic, QDistinct> {
  QueryBuilder<VotingTopic, VotingTopic, QDistinct> distinctByCreatedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdDate');
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QDistinct> distinctByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventId');
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QDistinct> distinctByIsSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSelected');
    });
  }

  QueryBuilder<VotingTopic, VotingTopic, QDistinct> distinctByTopicTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topicTitle', caseSensitive: caseSensitive);
    });
  }
}

extension VotingTopicQueryProperty
    on QueryBuilder<VotingTopic, VotingTopic, QQueryProperty> {
  QueryBuilder<VotingTopic, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VotingTopic, DateTime, QQueryOperations> createdDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdDate');
    });
  }

  QueryBuilder<VotingTopic, int, QQueryOperations> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventId');
    });
  }

  QueryBuilder<VotingTopic, bool, QQueryOperations> isSelectedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSelected');
    });
  }

  QueryBuilder<VotingTopic, String, QQueryOperations> topicTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topicTitle');
    });
  }
}
