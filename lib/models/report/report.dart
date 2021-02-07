class Report {
  final DateTime startDate;
  final DateTime endDate;
  final String email;
  final ReportTypeSend reportType;
  final String comment;

  const Report({
    this.startDate,
    this.endDate,
    this.reportType,
    this.comment,
    this.email,
  });

  bool get canSave =>
      startDate != null &&
      endDate != null &&
      reportType != null &&
      (reportType is SelfReportType ||
          (reportType is DoctorReportType &&
              email != null &&
              email.isNotEmpty));

  Report copyWith({
    String comment,
    DateTime startDate,
    DateTime endDate,
    ReportTypeSend type,
    String email,
  }) {
    return Report(
      comment: comment ?? this.comment,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reportType: type ?? reportType,
      email: email ?? this.email,
    );
  }
}

final reportTypes = [SelfReportType(), DoctorReportType()];

abstract class ReportTypeSend {
  final String title;

  ReportTypeSend({this.title});
}

class SelfReportType implements ReportTypeSend {
  @override
  String get title => 'Отправить себе';
}

class DoctorReportType implements ReportTypeSend {
  @override
  String get title => 'Отправить врачу';
}
