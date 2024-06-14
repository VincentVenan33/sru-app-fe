// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_order_jual_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalOrderJualPayload _$ApprovalOrderJualPayloadFromJson(
        Map<String, dynamic> json) =>
    ApprovalOrderJualPayload(
      action: json['action'] as String,
      requestData: ApprovalOrderJualRequest.fromJson(
          json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApprovalOrderJualPayloadToJson(
        ApprovalOrderJualPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

ApprovalOrderJualRequest _$ApprovalOrderJualRequestFromJson(
        Map<String, dynamic> json) =>
    ApprovalOrderJualRequest(
      statusdisetujui: json['status_disetujui'] as int?,
      disetujuioleh: json['disetujui_oleh'] as int?,
    );

Map<String, dynamic> _$ApprovalOrderJualRequestToJson(
        ApprovalOrderJualRequest instance) =>
    <String, dynamic>{
      'status_disetujui': instance.statusdisetujui,
      'disetujui_oleh': instance.disetujuioleh,
    };

ApprovalOrderJualResponse _$ApprovalOrderJualResponseFromJson(
        Map<String, dynamic> json) =>
    ApprovalOrderJualResponse(
      msg: json['msg'] as bool?,
      code: json['code'] as int?,
    );

Map<String, dynamic> _$ApprovalOrderJualResponseToJson(
        ApprovalOrderJualResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
    };
