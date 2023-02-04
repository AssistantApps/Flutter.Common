import './enum_base.dart';

enum AdminApprovalStatus {
  pending,
  inReview,
  denied,
  approved,
}

final adminApprovalStatusValues = EnumValues({
  '0': AdminApprovalStatus.pending,
  '1': AdminApprovalStatus.inReview,
  '2': AdminApprovalStatus.denied,
  '3': AdminApprovalStatus.approved,
});
