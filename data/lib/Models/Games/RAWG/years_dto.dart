
class YearsDTO {
  num? from;
  num? to;
  String? filter;
  num? decade;
  List<YearsDTO>? years;
  bool? nofollow;
  num? count;

  YearsDTO(
      { this.from,
        this.to,
        this.filter,
        this.decade,
        this.years,
        this.nofollow,
        this.count});

  YearsDTO.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    filter = json['filter'];
    decade = json['decade'];
    if (json['years'] != null) {
      years = <YearsDTO>[];
      json['years'].forEach((v) {
        years!.add( YearsDTO.fromJson(v));
      });
    }
    nofollow = json['nofollow'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    data['filter'] = filter;
    data['decade'] = decade;
    if (years != null) {
      data['years'] = years!.map((v) => v.toJson()).toList();
    }
    data['nofollow'] = nofollow;
    data['count'] = count;
    return data;
  }
}
