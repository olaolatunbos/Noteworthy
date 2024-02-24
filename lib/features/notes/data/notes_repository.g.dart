// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notesRepositoryHash() => r'415cd32424d639122a0276eae586f9bd3df4324f';

/// See also [notesRepository].
@ProviderFor(notesRepository)
final notesRepositoryProvider = Provider<NotesRepository>.internal(
  notesRepository,
  name: r'notesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotesRepositoryRef = ProviderRef<NotesRepository>;
String _$notesListStreamHash() => r'd8434111ed6c584ebc9242b49922429767db67cb';

/// See also [notesListStream].
@ProviderFor(notesListStream)
final notesListStreamProvider = AutoDisposeStreamProvider<List<Note>>.internal(
  notesListStream,
  name: r'notesListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notesListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotesListStreamRef = AutoDisposeStreamProviderRef<List<Note>>;
String _$notesListFutureHash() => r'64e60e7cca7baa6b3ab46ac69613276e20af6393';

/// See also [notesListFuture].
@ProviderFor(notesListFuture)
final notesListFutureProvider = AutoDisposeFutureProvider<List<Note>>.internal(
  notesListFuture,
  name: r'notesListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notesListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotesListFutureRef = AutoDisposeFutureProviderRef<List<Note>>;
String _$importantNotesStreamHash() =>
    r'708c9071be9c11f5575843dbcb0a8a160e7296b6';

/// See also [importantNotesStream].
@ProviderFor(importantNotesStream)
final importantNotesStreamProvider =
    AutoDisposeStreamProvider<List<Note>>.internal(
  importantNotesStream,
  name: r'importantNotesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$importantNotesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ImportantNotesStreamRef = AutoDisposeStreamProviderRef<List<Note>>;
String _$bookmarkedNotesStreamHash() =>
    r'7bbfb2dd66bb646ffcbaad2ec6fc3ba951569c62';

/// See also [bookmarkedNotesStream].
@ProviderFor(bookmarkedNotesStream)
final bookmarkedNotesStreamProvider =
    AutoDisposeStreamProvider<List<Note>>.internal(
  bookmarkedNotesStream,
  name: r'bookmarkedNotesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookmarkedNotesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BookmarkedNotesStreamRef = AutoDisposeStreamProviderRef<List<Note>>;
String _$noteStreamHash() => r'26ac46082ae58cc7f748a1c6053fb284d7276a8e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef NoteStreamRef = AutoDisposeStreamProviderRef<Note?>;

/// See also [noteStream].
@ProviderFor(noteStream)
const noteStreamProvider = NoteStreamFamily();

/// See also [noteStream].
class NoteStreamFamily extends Family<AsyncValue<Note?>> {
  /// See also [noteStream].
  const NoteStreamFamily();

  /// See also [noteStream].
  NoteStreamProvider call(
    String id,
  ) {
    return NoteStreamProvider(
      id,
    );
  }

  @override
  NoteStreamProvider getProviderOverride(
    covariant NoteStreamProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'noteStreamProvider';
}

/// See also [noteStream].
class NoteStreamProvider extends AutoDisposeStreamProvider<Note?> {
  /// See also [noteStream].
  NoteStreamProvider(
    this.id,
  ) : super.internal(
          (ref) => noteStream(
            ref,
            id,
          ),
          from: noteStreamProvider,
          name: r'noteStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$noteStreamHash,
          dependencies: NoteStreamFamily._dependencies,
          allTransitiveDependencies:
              NoteStreamFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is NoteStreamProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$noteFutureHash() => r'905df8a4114547df479f650ecfdc9a51bcc79b3e';
typedef NoteFutureRef = AutoDisposeFutureProviderRef<Note?>;

/// See also [noteFuture].
@ProviderFor(noteFuture)
const noteFutureProvider = NoteFutureFamily();

/// See also [noteFuture].
class NoteFutureFamily extends Family<AsyncValue<Note?>> {
  /// See also [noteFuture].
  const NoteFutureFamily();

  /// See also [noteFuture].
  NoteFutureProvider call(
    String id,
  ) {
    return NoteFutureProvider(
      id,
    );
  }

  @override
  NoteFutureProvider getProviderOverride(
    covariant NoteFutureProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'noteFutureProvider';
}

/// See also [noteFuture].
class NoteFutureProvider extends AutoDisposeFutureProvider<Note?> {
  /// See also [noteFuture].
  NoteFutureProvider(
    this.id,
  ) : super.internal(
          (ref) => noteFuture(
            ref,
            id,
          ),
          from: noteFutureProvider,
          name: r'noteFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$noteFutureHash,
          dependencies: NoteFutureFamily._dependencies,
          allTransitiveDependencies:
              NoteFutureFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is NoteFutureProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
