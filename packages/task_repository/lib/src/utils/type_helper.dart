enum Type { work, study, family }

extension TaskType on int {
  Type get selectedType {
    if (this > 0 && this < 35) {
      return Type.work;
    } else if (this > 35 && this < 70) {
      return Type.study;
    } else if (this > 70 && this < 100) {
      return Type.family;
    } else {
      return Type.work;
    }
  }
}
