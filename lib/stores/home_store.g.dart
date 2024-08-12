// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$usersAtom = Atom(name: 'HomeStoreBase.users', context: context);

  @override
  List<ModelUser> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<ModelUser> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'HomeStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_isRemoveAtom =
      Atom(name: 'HomeStoreBase._isRemove', context: context);

  @override
  bool get _isRemove {
    _$_isRemoveAtom.reportRead();
    return super._isRemove;
  }

  @override
  set _isRemove(bool value) {
    _$_isRemoveAtom.reportWrite(value, super._isRemove, () {
      super._isRemove = value;
    });
  }

  late final _$_keyAtom = Atom(name: 'HomeStoreBase._key', context: context);

  @override
  String get _key {
    _$_keyAtom.reportRead();
    return super._key;
  }

  @override
  set _key(String value) {
    _$_keyAtom.reportWrite(value, super._key, () {
      super._key = value;
    });
  }

  late final _$_getDataAsyncAction =
      AsyncAction('HomeStoreBase._getData', context: context);

  @override
  Future<void> _getData({String? key, String? value}) {
    return _$_getDataAsyncAction
        .run(() => super._getData(key: key, value: value));
  }

  late final _$_saveUserAsyncAction =
      AsyncAction('HomeStoreBase._saveUser', context: context);

  @override
  Future<void> _saveUser(List<ModelUser> users) {
    return _$_saveUserAsyncAction.run(() => super._saveUser(users));
  }

  late final _$_loadUserListAsyncAction =
      AsyncAction('HomeStoreBase._loadUserList', context: context);

  @override
  Future<List<ModelUser>> _loadUserList() {
    return _$_loadUserListAsyncAction.run(() => super._loadUserList());
  }

  late final _$callGetDataAsyncAction =
      AsyncAction('HomeStoreBase.callGetData', context: context);

  @override
  Future<void> callGetData({String? key, String? value}) {
    return _$callGetDataAsyncAction
        .run(() => super.callGetData(key: key, value: value));
  }

  late final _$_removeDataAsyncAction =
      AsyncAction('HomeStoreBase._removeData', context: context);

  @override
  Future<void> _removeData({required ModelUser user}) {
    return _$_removeDataAsyncAction.run(() => super._removeData(user: user));
  }

  late final _$callRemoveDataAsyncAction =
      AsyncAction('HomeStoreBase.callRemoveData', context: context);

  @override
  Future<void> callRemoveData({required ModelUser user}) {
    return _$callRemoveDataAsyncAction
        .run(() => super.callRemoveData(user: user));
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  void setIsLoading(bool a) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setIsLoading');
    try {
      return super.setIsLoading(a);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void callSetIsLoading(bool a) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.callSetIsLoading');
    try {
      return super.callSetIsLoading(a);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool getIsRemove() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.getIsRemove');
    try {
      return super.getIsRemove();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setKey(String value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setKey');
    try {
      return super.setKey(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void callSetKey(String value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.callSetKey');
    try {
      return super.callSetKey(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getKey() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.getKey');
    try {
      return super.getKey();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
users: ${users},
isLoading: ${isLoading}
    ''';
  }
}
