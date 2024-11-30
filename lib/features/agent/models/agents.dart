
class Agent {
  String agentId;
  String agentName;
  String agentAddress;
  String agentPhoneNumber;
  String agentCode;
  String agentEmail;

  Agent({
    required this.agentId,
    required this.agentName,
    required this.agentAddress,
    required this.agentPhoneNumber,
    required this.agentCode,
    required this.agentEmail,
  });

  // Convert Agent to JSON for other uses
  Map<String, dynamic> toJson() => {
    'agentId': agentId,
    'agentName': agentName,
    'agentAddress': agentAddress,
    'agentPhoneNumber': agentPhoneNumber,
    'agentCode': agentCode,
    'agentEmail': agentEmail,
  };
}
