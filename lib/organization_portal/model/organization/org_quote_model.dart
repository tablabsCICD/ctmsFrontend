

import '../../../model/my_bids.dart';

class OrgQuoteModel {
  List<QuoteWithPostDetailList>? content;
  bool? last;
  int? totalPages;
  int? totalElements;
  String? sort;
  bool? first;
  int? numberOfElements;
  int? size;
  int? number;

  OrgQuoteModel(
      {this.content,
      this.last,
      this.totalPages,
      this.totalElements,
      this.sort,
      this.first,
      this.numberOfElements,
      this.size,
      this.number});

  OrgQuoteModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null && json['content'] is List) {
      content = <QuoteWithPostDetailList>[];
      json['content'].forEach((v) {
        content!.add(new QuoteWithPostDetailList.fromJson(v));
      });
    } else {
      content = []; // fallback if data is "", null, or not a list
    }

    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    sort = json['sort'] ?? '';
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    size = json['size'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['last'] = this.last;
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['sort'] = this.sort;
    data['first'] = this.first;
    data['numberOfElements'] = this.numberOfElements;
    data['size'] = this.size;
    data['number'] = this.number;
    return data;
  }
}

class QuoteWithPostDetailList {
  GenericCardsDto? genericCardsDto;
  List<BidingDetails>? bidingList;

  QuoteWithPostDetailList({this.genericCardsDto, this.bidingList});

  QuoteWithPostDetailList.fromJson(Map<String, dynamic> json) {
    genericCardsDto = json['genericCardsDto'] != null
        ? new GenericCardsDto.fromJson(json['genericCardsDto'])
        : null;
    if (json['bidings'] != null) {
      bidingList = <BidingDetails>[];
      json['bidings'].forEach((v) {
        bidingList!.add(new BidingDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.genericCardsDto != null) {
      data['genericCardsDto'] = this.genericCardsDto!.toJson();
    }
    if (this.bidingList != null) {
      data['bidings'] = this.bidingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

