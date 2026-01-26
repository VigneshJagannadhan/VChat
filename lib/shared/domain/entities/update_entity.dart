class UpdateEntity {
  String? latestVersion;
  String? minSupportedVersion;
  bool? forceUpdate;
  String? updateMessage;

  UpdateEntity({
    this.latestVersion,
    this.minSupportedVersion,
    this.forceUpdate,
    this.updateMessage,
  });

  bool isVersionOutdated({required String currentVersion}) {
    List<int> parseVersion(String v) {
      final parts = v.split('.');
      final nums = parts.map((p) {
        final m = RegExp(r'\d+').firstMatch(p.trim());
        return m != null ? int.tryParse(m.group(0)!) ?? 0 : 0;
      }).toList();
      while (nums.length < 3) {
        nums.add(0);
      }
      return nums;
    }

    final c = parseVersion(currentVersion);
    final l = parseVersion(latestVersion ?? '0');

    for (int i = 0; i < 3; i++) {
      if (c[i] < l[i]) return true;
      if (c[i] > l[i]) return false;
    }
    return false;
  }
}
