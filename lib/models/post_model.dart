class Post {
  String? imgPost;
  String? captionPost;

  Post(this.imgPost, this.captionPost);

  Post.fromJson(Map<String, dynamic> json)
      : imgPost = json['imgPost'],
        captionPost = json["captionPost"];

  Map<String, dynamic> toJson() => {
        'imgPost': imgPost,
        'captionPost': captionPost,
      };
}
