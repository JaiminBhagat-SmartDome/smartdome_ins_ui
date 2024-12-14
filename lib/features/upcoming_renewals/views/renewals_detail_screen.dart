import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening the email, whatsapp, and phone app
import '../models/renewals.dart';

class RenewalDetailScreen extends StatelessWidget {
  final Renewal renewal;

  const RenewalDetailScreen({Key? key, required this.renewal})
      : super(key: key);

  // Function to open the email app
  Future<void> _openEmailApp() async {
    String emailContent = '''
Policy Number: ${renewal.policyNumber}
Product Code: ${renewal.productCode}
Product Name: ${renewal.productName}
LOB Description: ${renewal.lobDescription}
Policy Inception Date: ${renewal.policyInceptionDate.toLocal().toString().split(' ')[0]}
Policy Expiry Date: ${renewal.policyExpiryDate.toLocal().toString().split(' ')[0]}
Policy Holder Code: ${renewal.policyHolderCode}
''';

    final emailUri = Uri(
      scheme: 'mailto',
      path: renewal.client?.emailAddresses.values.join(','),
      queryParameters: {
        'subject': 'Policy Renewal Details',
        'body': emailContent
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not open email app';
    }
  }

  // Function to open WhatsApp
  Future<void> _openWhatsApp() async {
    String message = '''
Policy Number: ${renewal.policyNumber}
Product Code: ${renewal.productCode}
Product Name: ${renewal.productName}
LOB Description: ${renewal.lobDescription}
Policy Inception Date: ${renewal.policyInceptionDate.toLocal().toString().split(' ')[0]}
Policy Expiry Date: ${renewal.policyExpiryDate.toLocal().toString().split(' ')[0]}
Policy Holder Code: ${renewal.policyHolderCode}
''';

    String? clientPhoneNumber =
        getValidPhoneNumber(renewal.client?.phoneNumbers ?? {});
    final whatsappUri = Uri.parse(
        'https://wa.me/$clientPhoneNumber?text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'Could not open WhatsApp';
    }
  }

  // Function to open the phone dialer
  Future<void> _makeCall(BuildContext context) async {
    if (renewal.client!.phoneNumbers.isEmpty) return;

    List<String> phoneNumbers = renewal.client!.phoneNumbers.values
        .where((number) =>
            number.length == 10 && RegExp(r'^[0-9]{10}$').hasMatch(number))
        .toList();

    // Show a dialog to choose which number to call
    String selectedPhoneNumber =
        phoneNumbers.first; // Default selection is the first number

    if (phoneNumbers.length > 1) {
      // If more than one number, show a dialog to choose
      selectedPhoneNumber = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Select Phone Number'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: phoneNumbers.map((phoneNumber) {
                    return ListTile(
                      title: Text(phoneNumber),
                      onTap: () {
                        Navigator.of(context).pop(phoneNumber);
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ) ??
          phoneNumbers.first;
    }

    final phoneUri = Uri.parse('tel:$selectedPhoneNumber');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not make the call';
    }
  }

  String? getValidPhoneNumber(Map<String, String> phoneNumbers) {
    // Check if the mobile number exists and is 10 digits long
    String? mobile = phoneNumbers["mobile"];
    if (mobile != null &&
        mobile.length == 10 &&
        RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
      return mobile; // Return the valid mobile number
    }

    // Check if the office number exists and is 10 digits long
    String? office = phoneNumbers["office"];
    if (office != null &&
        office.length == 10 &&
        RegExp(r'^[0-9]{10}$').hasMatch(office)) {
      return office; // Return the valid office number
    }

    // Return null if neither is valid
    return null;
  }

  String formatPhoneNumbers(Map<String, String> phoneNumbers) {
    List<String> formattedNumbers = [];

    // Check for each phone number and add it to the list if it's not empty
    if (phoneNumbers["office"]!.isNotEmpty) {
      formattedNumbers.add('Office: ${phoneNumbers["office"]}');
    }
    if (phoneNumbers["other"]!.isNotEmpty) {
      formattedNumbers.add('Other: ${phoneNumbers["other"]}');
    }
    if (phoneNumbers["mobile"]!.isNotEmpty) {
      formattedNumbers.add('Mobile: ${phoneNumbers["mobile"]}');
    }

    // Join each phone number with a newline
    return formattedNumbers.join('\n');
  }

  String formatEmails(Map<String, String> emails) {
    List<String> formattedEmails = [];

    // Check for each phone number and add it to the list if it's not empty
    if (emails["primary"]!.isNotEmpty) {
      formattedEmails.add('Office: ${emails["primary"]}');
    }
    if (emails["secondary"]!.isNotEmpty) {
      formattedEmails.add('Other: ${emails["secondary"]}');
    }

    // Join each phone number with a newline
    return formattedEmails.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    // Client Details Section
    String clientEmail = formatEmails(renewal.client!.emailAddresses);
    String clientPhoneNumber = formatPhoneNumbers(renewal.client!.phoneNumbers);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Renewal Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client Details Section
            Text('Client Details',
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 10),
            Text('System Name: ${renewal.client?.systemName}'),
            Text('First Name: ${renewal.client?.firstName}'),
            Text('Last Name: ${renewal.client?.lastName}'),
            Text('Client Type: ${renewal.client?.clientType}'),
            Text('Firm Type: ${renewal.client?.firmName}'),
            Text('Address1: ${renewal.client?.address1}'),
            Text('Address2: ${renewal.client?.address2}'),
            Text('Email:\n$clientEmail'),
            Text('Phone Numbers:\n$clientPhoneNumber'),
            SizedBox(height: 20),

            // Policy Details Section
            Text('Policy Details',
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 10),
            Text('Policy Number: ${renewal.policyNumber}'),
            Text('Product Code: ${renewal.productCode}'),
            Text('Product Name: ${renewal.productName}'),
            Text('LOB Description: ${renewal.lobDescription}'),
            Text(
                'Policy Inception Date: ${renewal.policyInceptionDate.toLocal().toString().split(' ')[0]}'),
            Text(
                'Policy Expiry Date: ${renewal.policyExpiryDate.toLocal().toString().split(' ')[0]}'),
            Text('Policy Holder Code: ${renewal.policyHolderCode}'),
            SizedBox(height: 20),

            // Premium Details Section
            Text('Premium Details',
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 10),
            Text('Sum Insured: ${renewal.sumInsured}'),
            Text('Gross Premium: ${renewal.grossPremium}'),
            Text('Service Tax: ${renewal.serviceTax}'),
            SizedBox(height: 20),
            // Action Buttons Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _openEmailApp,
                  child: const Text('Email'),
                ),
                ElevatedButton(
                  onPressed: _openWhatsApp,
                  child: const Text('WhatsApp'),
                ),
                ElevatedButton(
                  onPressed: () => _makeCall(context),
                  child: const Text('Call'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
