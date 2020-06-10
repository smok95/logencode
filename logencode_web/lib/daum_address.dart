import 'dart:convert';

class AreaKeyword {
  // 권역이름
  String name;
  // 검색실패시 권역이름에서 삭제할 단어(1글자)
  // 예) '시'인 경우, 대구시 -> 대구로 변경 후 재검색
  List<String> exclude;

  AreaKeyword(this.name, this.exclude);

  @override
  String toString() {
    // TODO: implement toString
    return name;
  }
}

class DaumAddress {
  /**
   * 다음 도로명주소 API의 응답값[source]을
   * 지점코드를 검색할 수 있는 형태[List<AreaKeyword>]로 변환한다.
   */
  static List<AreaKeyword> convertFrom(Map<String, dynamic> data) {
    if (data == null) return null;

    final String sido = data['sido'];
    final String sigungu = data['sigungu'];

    print('sido is ${sido}');

    List<AreaKeyword> area = [
      AreaKeyword('', null), // 권역1(도, 광역시, 특별시 등)
      AreaKeyword('', ['시']), // 권역2(시,군,구)
      AreaKeyword('', null), // 권역3(군,구)
      AreaKeyword('', null), // 권역4(동,읍,면)
      AreaKeyword('', null), // 권역5(리)
    ];

    var a1 = area[0];
    var a2 = area[1];
    var a3 = area[2];
    var a4 = area[3];
    var a5 = area[4];

    // 시/도 이름 -> 권역이름으로 변환
    if (sido.isNotEmpty) {
      switch (sido) {
        case '서울':
          a1.name = '서울권';
          break;
        case '부산':
          a1.name = '경상권';
          a2.name = sido;
          break;
        case '대구':
          a1.name = '경상권';
          a2.name = sido;
          break;
        case '인천':
          a1.name = '경기권';
          a2.name = sido;
          break;
        case '광주':
          a1.name = '전라권';
          a2.name = sido;
          break;
        case '대전':
          a1.name = '충청권';
          a2.name = sido;
          break;
        case '울산':
          a1.name = '경상권';
          a2.name = sido;
          break;
        case '제주특별자치도':
          a1.name = '제주권';
          break;
        case '세종특별자치시':
          a1.name = '충청권';
          a2.name = '세종시';
          break;
        case '경기':
          a1.name = '경기권';
          break;
        case '충남':
        case '충북':
          a1.name = '충청권';
          break;
        case '강원':
          a1.name = '강원권';
          break;
        case '경남':
        case '경북':
          a1.name = '경상권';
          break;
        case '전남':
        case '전북':
          a1.name = '전라권';
          break;
      }
    }

    if (a2.name.isEmpty) {
      a2.name = sigungu;

      // '시'와 '구' 분리, 예) 성남시 분당구
      var arr = a2.name.split(" ");
      if (arr.length >= 2) {
        a2.name = arr[0];
        a3.name = arr[1];
      }
    } else {
      a3.name = sigungu;
    }

    final String sTemp = data['bname1'] ?? '';
    if (sTemp.length > 0) {
      a4.name = sTemp;
      a5.name = data['bname'];
    } else {
      a4.name = data['bname'];
    }

    return area;
  }
}
