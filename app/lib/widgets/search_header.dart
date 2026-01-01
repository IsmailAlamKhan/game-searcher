import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/search.dart';
import '../providers/search_provider.dart';
import '../utils/debouncer.dart';

class SearchHeader extends HookConsumerWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(searchControllerProvider);
    final searchTextController = useTextEditingController();
    final SearchQueryParams(:query, :tags, :searchPrecise, :searchExact) = searchController.searchQueryParams;
    final debouncer = useDebouncer(const Duration(seconds: 1));

    useListenable(searchTextController);

    useEffect(() {
      if (searchTextController.text != query) {
        searchTextController.text = query ?? '';
      }
      return () {};
    }, [query]);

    useEffect(() {
      debouncer(() {
        if (searchTextController.text != query) {
          searchController.search(searchTextController.text);
        }
      });
      return () {};
    }, [searchTextController.text]);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchTextController,
                  decoration: InputDecoration(
                    hintText: "Enter game title...",
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: ListenableBuilder(
                      listenable: searchTextController,
                      builder: (context, child) {
                        if (searchTextController.text.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return child!;
                      },
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => searchTextController.clear(),
                      ),
                    ),
                  ),
                  onSubmitted: (value) {
                    searchController.search(value);
                    debouncer.cancel();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Tooltip(
                message: "For precise search disables fuzzy search.",
                child: Row(
                  children: [
                    Checkbox(
                      value: searchPrecise,
                      onChanged: (value) =>
                          searchController.searchQueryParams = searchController.searchQueryParams.copyWith(
                            searchPrecise: value!,
                          ),
                    ),
                    const Text("Precise"),
                  ],
                ),
              ),
              Tooltip(
                message: "Use the exact search query.",
                child: Row(
                  children: [
                    Checkbox(
                      value: searchExact,
                      onChanged: (value) =>
                          searchController.searchQueryParams = searchController.searchQueryParams.copyWith(
                            searchExact: value!,
                          ),
                    ),
                    const Text("Exact"),
                  ],
                ),
              ),
            ],
          ),
        ),
        PagingListener(
          controller: searchController.pagingController,
          builder: (context, state, fetchNextPage) {
            if (state.status != PagingStatus.loadingFirstPage ||
                state.status != PagingStatus.subsequentPageError ||
                state.status != PagingStatus.firstPageError) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Showing ${state.items?.length ?? 0} results out of ${searchController.totalCount}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        if (tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: tags.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final tag = tags[index];
                  return Chip(label: Text(tag.name), onDeleted: () => searchController.toggleTag(tag));
                },
              ),
            ),
          ),
      ],
    );
  }
}
