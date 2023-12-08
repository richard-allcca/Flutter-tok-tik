import 'package:toktik/domain/datasourses/video_post_datasource.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/domain/repositories/video_post_repository.dart';



class VideoPostRepositoriesImpl implements VideoPostRepository {

  final VideoPostDatasource videosDataSource;

  VideoPostRepositoriesImpl({
    required this.videosDataSource
  });

  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) {

    return videosDataSource.getTrendingVideosByPage(page);
  }

}