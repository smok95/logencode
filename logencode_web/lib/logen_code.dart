class LogenCode {
  final String area; // 관할지역(동,면,읍,리)
  final String branch; // 지점
  final String region1; // 권역
  final String region2; // 시도(또는 구)
  final String category; // 터미널코드
  final int code; // 지점코드
  final String color; // 권역 색상

  LogenCode.fromJson(dynamic json)
      : area = json['area'],
        branch = json['branch'],
        region1 = json['region1'],
        region2 = json['region2'],
        category = json['category'],
        code = json['code'],
        color = json['color'];

  bool contains(String text) {
    if (text?.isEmpty ?? true) return false;

    if (area.contains(text) ||
        region2.contains(text) ||
        region1.contains(text) ||
        branch.contains(text)) {
      return true;
    }

    return false;
  }
}
