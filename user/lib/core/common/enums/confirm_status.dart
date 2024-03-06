enum ConfirmStatus {
  create(false),
  update(true);

  final bool value;

  const ConfirmStatus(this.value);
}
