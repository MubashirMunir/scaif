class SearchModule {
  String alphaTwoCode;
  List<String> webPages;
  String country;
  List<String> domains;
  String name;
  String stateProvince;

  SearchModule({
    required this.alphaTwoCode,
    required this.webPages,
    required this.country,
    required this.domains,
    required this.name,
    required this.stateProvince,
  });

  factory SearchModule.fromJson(Map<String, dynamic> json) {
    return SearchModule(
        alphaTwoCode: json['alpha_two_code'] as String,
        webPages: List<String>.from(json['web_pages'] ?? []),
        country: json['country'] as String,
        domains: List<String>.from(json['domains'] ?? []),
        name: json['name'] as String,
        stateProvince: json['state-province'] as String? ?? 'unknown');
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'alpha_two_code': alphaTwoCode,
  //     'web_pages': webPages,
  //     'country': country,
  //     'domains': domains,
  //     'name': name,
  //     'state-province': stateProvince,
  //   };
  // }
}
