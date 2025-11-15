class TestStats {
  int tries = 0;
  int wrongs = 0;

  fail() {
    tries++;
    wrongs++;
  }

  correct() {
    tries++;
  }
}
