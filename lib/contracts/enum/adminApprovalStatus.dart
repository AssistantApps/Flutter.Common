import 'enumBase.dart';

enum AdminApprovalStatus {
  Pending,
  InReview,
  Denied,
  Approved,
}
final adminApprovalStatusValues = EnumValues({
  '0': AdminApprovalStatus.Pending,
  '1': AdminApprovalStatus.InReview,
  '2': AdminApprovalStatus.Denied,
  '3': AdminApprovalStatus.Approved,
});
