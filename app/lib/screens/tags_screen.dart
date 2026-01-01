import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/search.dart';
import '../models/tag.dart';
import '../providers/search_provider.dart';
import '../providers/tags_provider.dart';
import '../utils/debouncer.dart';
import '../widgets/paged_child_builder.dart';

class TagsScreen extends HookConsumerWidget {
  const TagsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(tagsControllerProvider);
    final searchController = ref.watch(searchControllerProvider);
    final SearchQueryParams(:tags) = searchController.searchQueryParams;
    final selectedTags = useState(tags);

    useEffect(() {
      selectedTags.value = tags;
      return null;
    }, [tags]);

    return Scaffold(
      appBar: AppBar(title: const Text("Discovery Tags")),
      body: Column(
        children: [
          _Search(controller: controller),
          Expanded(
            child: PagingListener(
              controller: controller.pagingController,
              builder: (context, state, fetchNextPage) {
                return PagedGridView<int, Tag>(
                  state: state,
                  fetchNextPage: fetchNextPage,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  builderDelegate: AppPagedChildBuilderDelegate<int, Tag>(
                    pagingController: controller.pagingController,
                    itemBuilder: (context, item, index) => TagCard(
                      item: item,
                      isSelected: selectedTags.value.contains(item),
                      onTap: () {
                        final _selectedTags = selectedTags.value.toList();
                        if (_selectedTags.contains(item)) {
                          _selectedTags.remove(item);
                        } else {
                          _selectedTags.add(item);
                        }
                        selectedTags.value = _selectedTags;
                      },
                    ),
                    emptyTitle: "No tags found",
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: selectedTags.value.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                searchController.searchQueryParams = searchController.searchQueryParams.copyWith(
                  tags: selectedTags.value,
                );
                context.go('/');
              },
              icon: const Icon(Icons.search),
              label: Text("Search (${selectedTags.value.length})"),
            )
          : null,
    );
  }
}

class _Search extends HookConsumerWidget {
  const _Search({required this.controller});

  final TagsController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTextController = useTextEditingController();
    useListenable(searchTextController);
    final debouncer = useDebouncer(const Duration(seconds: 1));

    useEffect(() {
      debouncer(() => controller.search(searchTextController.text));
      return null;
    }, [searchTextController.text]);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchTextController,
        decoration: InputDecoration(
          labelText: 'Search Tags',
          prefixIcon: const Icon(Icons.search),
        ),
        onSubmitted: (value) {
          debouncer.cancel();
          controller.search(value);
        },
      ),
    );
  }
}

class TagCard extends ConsumerWidget {
  const TagCard({super.key, required this.item, required this.isSelected, required this.onTap});

  final Tag item;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget Function(Widget child) childBuilder;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    if (item.imageBackground != null) {
      childBuilder = (child) => Ink.image(
        image: CachedNetworkImageProvider(item.imageBackground!),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          colors.surface.withValues(alpha: .6),
          BlendMode.darken,
        ),
        child: child,
      );
    } else {
      childBuilder = (child) => Container(
        color: colors.surface.withValues(alpha: .6),
        child: child,
      );
    }
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: isSelected
          ? RoundedRectangleBorder(
              side: BorderSide(color: colors.primary.withValues(alpha: .6), width: 3),
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      child: childBuilder(
        InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.name,
                    style: TextStyle(color: colors.onSurface, fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              if (isSelected) Positioned(top: 8, right: 8, child: Icon(Icons.check_circle, color: colors.primary)),
            ],
          ),
        ),
      ),
    );
  }
}
