import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/app_theme.dart';
import 'package:toktik/infrastructure/datasources/local_videos_datasource_impl.dart';
import 'package:toktik/infrastructure/repositories/video_post_repositories.impl.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/screens/discover/discover_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final videoPostReposity = VideoPostRepositoriesImpl(
      videosDataSource: LocalVideoDatasourceImpl()
      );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // lazy: false, // Provider has lazy by default
          create: (_) => DiscoverProvider( videosRepository: videoPostReposity)..loadNextPage()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        title: 'Tok Tik',
        home: const DiscoverScreen(),
      ),
    );
  }
}

