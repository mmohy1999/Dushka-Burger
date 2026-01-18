import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MenuLoadedController {
  final VoidCallback onSelectionChanged;
  final bool Function() isMounted;

  final ScrollController scrollController = ScrollController();
  final ScrollController categoryScrollController = ScrollController();
  final GlobalKey listKey = GlobalKey();
  final List<GlobalKey> categoryKeys = [];
  final List<GlobalKey> chipKeys = [];
  int selectedIndex = 0;

  MenuLoadedController({
    required this.onSelectionChanged,
    required this.isMounted,
  });

  void init() {
    scrollController.addListener(_onScroll);
  }

  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    categoryScrollController.dispose();
  }

  void syncCategoryKeys(int count) {
    if (categoryKeys.length == count && chipKeys.length == count) {
      return;
    }
    categoryKeys
      ..clear()
      ..addAll(List.generate(count, (_) => GlobalKey()));
    chipKeys
      ..clear()
      ..addAll(List.generate(count, (_) => GlobalKey()));
    if (selectedIndex >= count) {
      selectedIndex = 0;
    }
  }

  void onCategoryTap(int index) {
    if (index < 0 || index >= categoryKeys.length) {
      return;
    }
    setSelectedIndex(index);
    scrollToCategory(index);
  }

  void _onScroll() {
    if (categoryKeys.isEmpty || !scrollController.hasClients) {
      return;
    }
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 4) {
      setSelectedIndex(categoryKeys.length - 1);
      return;
    }
    final listContext = listKey.currentContext;
    if (listContext == null) {
      return;
    }
    final listBox = listContext.findRenderObject() as RenderBox?;
    if (listBox == null) {
      return;
    }
    final listTop = listBox.localToGlobal(Offset.zero).dy;
    int? candidate;
    for (var i = 0; i < categoryKeys.length; i++) {
      final headerContext = categoryKeys[i].currentContext;
      if (headerContext == null) {
        continue;
      }
      final headerBox = headerContext.findRenderObject() as RenderBox?;
      if (headerBox == null) {
        continue;
      }
      final headerTop = headerBox.localToGlobal(Offset.zero).dy;
      if (headerTop <= listTop + 8) {
        candidate = i;
      }
    }
    final nextIndex = candidate ?? 0;
    setSelectedIndex(nextIndex);
  }

  void scrollToCategory(int index, {bool allowRetry = true}) {
    final targetContext = categoryKeys[index].currentContext;
    if (targetContext == null) {
      if (allowRetry) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!isMounted()) {
            return;
          }
          scrollToCategory(index, allowRetry: false);
        });
      }
      return;
    }
    final renderObject = targetContext.findRenderObject();
    if (renderObject == null) {
      return;
    }
    final viewport = RenderAbstractViewport.of(renderObject);
    if (viewport == null) {
      return;
    }
    final targetOffset = viewport.getOffsetToReveal(renderObject, 0).offset;
    final position = scrollController.position;
    final clampedOffset = targetOffset.clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    scrollController.animateTo(
      clampedOffset,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  void setSelectedIndex(int index) {
    if (index == selectedIndex) {
      scrollChipIntoView(index);
      return;
    }
    selectedIndex = index;
    onSelectionChanged();
    scrollChipIntoView(index);
  }

  void scrollChipIntoView(int index) {
    if (index < 0 || index >= chipKeys.length) {
      return;
    }
    final chipContext = chipKeys[index].currentContext;
    if (chipContext == null) {
      return;
    }
    Scrollable.ensureVisible(
      chipContext,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      alignment: 0.4,
    );
  }
}
