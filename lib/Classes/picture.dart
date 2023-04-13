class Picture {
  int id;
  String? name;
  String? alternativeText;
  String? caption;
  Format? formats;

  Picture(
      {required this.id,
      this.name,
      this.alternativeText,
      this.caption,
      this.formats});

  factory Picture.fromJson(Map<String, dynamic> data) {
    return Picture(
      id: data['id'],
      name: data['name'],
      alternativeText: data['alternativeText'],
      caption: data['caption'],
      formats:
          data['formats'] != null ? Format.fromJson(data['formats']) : null,
    );
  }
}

class Format {
  Size? large;
  Size? small;
  Size? medium;
  Size? thumbnail;

  Format({this.large, this.small, this.medium, this.thumbnail});

  factory Format.fromJson(Map<String, dynamic> data) {
    return Format(
      large: data['large'] != null ? Size.fromJson(data['large']) : null,
      small: data['small'] != null ? Size.fromJson(data['small']) : null,
      medium: data['medium'] != null ? Size.fromJson(data['medium']) : null,
      thumbnail:
          data['thumbnail'] != null ? Size.fromJson(data['thumbnail']) : null,
    );
  }
}

class Size {
  String? ext;
  String? url;
  double? size;
  int? width;
  int? height;

  Size({this.ext, this.url, this.size, this.width, this.height});

  factory Size.fromJson(Map<String, dynamic> data) {
    return Size(
      ext: data['ext'],
      url: data['url'],
      size: data['size'],
      width: data['width'],
      height: data['height'],
    );
  }
}
