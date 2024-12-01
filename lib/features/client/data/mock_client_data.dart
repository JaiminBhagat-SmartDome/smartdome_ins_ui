import '../models/clients.dart';

List<Client> mockClientData = [
  Client(
    clientID: '1',
    systemName: 'SystemOne',
    initial: 'A',
    clientType: 'Individual',
    firstName: 'Alice',
    middleName: 'M.',
    lastName: 'Johnson',
    firmName: 'Alice Corp',
    address1: '123 Main Street',
    address2: 'Suite 456',
    pinCode: 110001,
    country: 'India',
    phoneNumbers: {
      'Mobile': '9876543210',
      'Work': '011-26543210',
      'Home': '011-26543211',
    },
    emailAddresses: {
      'primary': 'alice.johnson@invalid.com',
      'secondary': 'alice.johnsondomain@invalid.com',
    },
    agentID: 'A001',
    isActive: true,
    createdAt: DateTime.now(),
  ),
  Client(
    clientID: '2',
    systemName: 'SystemTwo',
    initial: 'B',
    clientType: 'Firm',
    firstName: 'Bob',
    middleName: '',
    lastName: 'Smith',
    firmName: 'Smith Enterprises',
    address1: '456 Business Road',
    address2: 'Block B',
    pinCode: 110002,
    country: 'India',
    phoneNumbers: {
      'Mobile': '9876554321',
      'Work': '011-26543212',
      'Home': '011-26543213',
    },
    emailAddresses: {
      'primary': 'bob.smith@invalid.cd',  // Invalid email
      'secondary': 'bob.smith@rrrr.com',  // Invalid email
    },
    agentID: 'A002',
    isActive: true,
    createdAt: DateTime.now(),
  ),
  Client(
    clientID: '3',
    systemName: 'SystemThree',
    initial: 'C',
    clientType: 'Individual',
    firstName: 'Charlie',
    middleName: 'D.',
    lastName: 'Brown',
    firmName: '',
    address1: '789 Elm Street',
    address2: 'Apartment 101',
    pinCode: 110003,
    country: 'India',
    phoneNumbers: {
      'Mobile': '9876543211',
      'Work': '011-26543214',
      'Home': '011-26543215',
    },
    emailAddresses: {
      'primary': 'charlie.brown@invalid.bg',  // Invalid email
      'secondary': 'charlie.brownnoDomain@invalid.com',  // Invalid email
    },
    agentID: 'A003',
    isActive: true,
    createdAt: DateTime.now(),
  ),
  Client(
    clientID: '4',
    systemName: 'SystemFour',
    initial: 'D',
    clientType: 'Firm',
    firstName: 'Diana',
    middleName: '',
    lastName: 'Prince',
    firmName: 'Diana Technologies',
    address1: '123 Tech Park',
    address2: 'Building 1',
    pinCode: 110004,
    country: 'India',
    phoneNumbers: {
      'Mobile': '9876554322',
      'Work': '011-26543216',
      'Home': '011-26543217',
    },
    emailAddresses: {
      'primary': 'diana.prince@invalid.rr',  // Invalid email
      'secondary': 'diana.princenvalid@domain.com',  // Invalid email
    },
    agentID: 'A004',
    isActive: true,
    createdAt: DateTime.now(),
  ),
  Client(
    clientID: '5',
    systemName: 'SystemFive',
    initial: 'E',
    clientType: 'Individual',
    firstName: 'Edward',
    middleName: 'S.',
    lastName: 'Norton',
    firmName: '',
    address1: '321 Oak Avenue',
    address2: 'Flat 12',
    pinCode: 110005,
    country: 'India',
    phoneNumbers: {
      'Mobile': '9876554323',
      'Work': '011-26543218',
      'Home': '011-26543219',
    },
    emailAddresses: {
      'primary': 'edward.norton@invalid.bb',  // Invalid email
      'secondary': 'edward.domain.com@invalid.fr',  // Invalid email
    },
    agentID: 'A005',
    isActive: true,
    createdAt: DateTime.now(),
  ),
];
