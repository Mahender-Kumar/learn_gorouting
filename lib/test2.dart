import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TabbedRootScreen extends StatefulWidget {
  /// Constructs a TabbedRootScreen
  const TabbedRootScreen(
      {required this.navigationShell, required this.children, super.key});

  /// The current state of the parent StatefulShellRoute.
  final StatefulNavigationShell navigationShell;

  /// The children (branch Navigators) to display in the [TabBarView].
  final List<Widget> children;

  @override
  State<StatefulWidget> createState() => TabbedRootScreenState();
}

@visibleForTesting
// ignore: public_member_api_docs
class TabbedRootScreenState extends State<TabbedRootScreen>
    with SingleTickerProviderStateMixin {
  @visibleForTesting
  // ignore: public_member_api_docs
  late final TabController tabController = TabController(
      length: widget.children.length,
      vsync: this,
      initialIndex: widget.navigationShell.currentIndex);

  void _switchedTab() {
    if (tabController.index != widget.navigationShell.currentIndex) {
      widget.navigationShell.goBranch(tabController.index);
    }
  }

  @override
  void initState() {
    super.initState();
    tabController.addListener(_switchedTab);
  }

  @override
  void dispose() {
    tabController.removeListener(_switchedTab);
    tabController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TabbedRootScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    tabController.index = widget.navigationShell.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = widget.children
        .mapIndexed((int i, _) => Tab(text: 'Tab ${i + 1}'))
        .toList();

    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Section B root (tab: ${widget.navigationShell.currentIndex + 1})'),
          bottom: TabBar(
            controller: tabController,
            tabs: tabs,
            onTap: (int tappedIndex) => _onTabTap(context, tappedIndex),
          )),
      body: TabBarView(
        controller: tabController,
        children: widget.children,
      ),
    );
  }

  void _onTabTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(index);
  }
}

/// Various extensions on lists of arbitrary elements.
extension ListExtensions<E> on List<E> {
  /// Returns the index of [element] in this sorted list.
  ///
  /// Uses binary search to find the location of [element].
  /// This takes on the order of `log(n)` comparisons.
  /// The list *must* be sorted according to [compare],
  /// otherwise the result is unspecified
  ///
  // Takes an action for each element.
  ///
  /// Calls [action] for each element along with the index in the
  /// iteration order.
  void forEachIndexed(void Function(int index, E element) action) {
    for (var index = 0; index < length; index++) {
      action(index, this[index]);
    }
  }

  /// Takes an action for each element as long as desired.
  ///
  /// Calls [action] for each element.
  /// Stops iteration if [action] returns `false`.
  void forEachWhile(bool Function(E element) action) {
    for (var index = 0; index < length; index++) {
      if (!action(this[index])) break;
    }
  }

  /// Takes an action for each element and index as long as desired.
  ///
  /// Calls [action] for each element along with the index in the
  /// iteration order.
  /// Stops iteration if [action] returns `false`.
  void forEachIndexedWhile(bool Function(int index, E element) action) {
    for (var index = 0; index < length; index++) {
      if (!action(index, this[index])) break;
    }
  }

  /// Maps each element and its index to a new value.
  Iterable<R> mapIndexed<R>(R Function(int index, E element) convert) sync* {
    for (var index = 0; index < length; index++) {
      yield convert(index, this[index]);
    }
  }

  /// The elements whose value and index satisfies [test].
  Iterable<E> whereIndexed(bool Function(int index, E element) test) sync* {
    for (var index = 0; index < length; index++) {
      var element = this[index];
      if (test(index, element)) yield element;
    }
  }

  /// The elements whose value and index do not satisfy [test].
  Iterable<E> whereNotIndexed(bool Function(int index, E element) test) sync* {
    for (var index = 0; index < length; index++) {
      var element = this[index];
      if (!test(index, element)) yield element;
    }
  }

  /// Expands each element and index to a number of elements in a new iterable.
  ///
  /// Like [Iterable.expand] except that the callback function is supplied with
  /// both the index and the element.
  Iterable<R> expandIndexed<R>(
      Iterable<R> Function(int index, E element) expand) sync* {
    for (var index = 0; index < length; index++) {
      yield* expand(index, this[index]);
    }
  }

  void reverseRange(int start, int end) {
    RangeError.checkValidRange(start, end, length);
    while (start < --end) {
      var tmp = this[start];
      this[start] = this[end];
      this[end] = tmp;
      start += 1;
    }
  }

  /// Swaps two elements of this list.
  void swap(int index1, int index2) {
    RangeError.checkValidIndex(index1, this, 'index1');
    RangeError.checkValidIndex(index2, this, 'index2');
    var tmp = this[index1];
    this[index1] = this[index2];
    this[index2] = tmp;
  }

  /// A fixed length view of a range of this list.
  ///
  /// The view is backed by this list, which must not change its length while
  /// Returns true iff [other] has the same [length]
  /// as this list, and the elements of this list and [other]
  /// The [index]th element, or `null` if there is no such element.
  ///
  /// Returns the element at position [index] of this list,
  /// just like [elementAt], if this list has such an element.
  /// If this list does not have enough elements to have one with the given
  /// [index], the `null` value is returned, unlike [elementAt] which throws
  /// instead.
  ///
  /// The [index] must not be negative.
  E? elementAtOrNull(int index) => (index < length) ? this[index] : null;

  /// Contiguous [slice]s of `this` with the given [length].
  ///
  /// Each slice is a view of this list [length] elements long, except for the
  /// last one which may be shorter if `this` contains too few elements. Each
  /// slice begins after the last one ends.
  ///
  /// As with [slice], these slices are backed by this list, which must not
  /// change its length while the views are being used.
  ///
}

/// Vari
