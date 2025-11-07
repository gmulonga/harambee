import 'dart:convert';
import 'package:http/http.dart' as http;

/// A service for handling Kopokopo API operations such as authentication,
/// initiating incoming payments (STK Push), simulating payments (sandbox),
/// and fetching received payments.
class KopoKopoService {
  final String baseUrl = 'https://sandbox.kopokopo.com/api/v1';
  final String clientId = 'cSz_XalXO1rLHo14m0wv5vAjcE6ysbkN9mplaxAFqt0';
  final String clientSecret = 'fO9F35u1QQiYwU6iUHwsxlBke7bUDS4VIM1HU05j3f8';

  String? _accessToken;

  /// STEP 1: Authenticate with Kopokopo and get an access token
  Future<void> authenticate() async {
    final url = Uri.parse('https://sandbox.kopokopo.com/oauth/token');
    final body = jsonEncode({
      "client_id": clientId,
      "client_secret": clientSecret,
      "grant_type": "client_credentials",
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _accessToken = data['access_token'];
      print('✅ Kopokopo Authenticated Successfully');
    } else {
      print('❌ Auth Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to authenticate');
    }
  }

  Future<void> initiateSTKPush({
    required String phoneNumber,
    required double amount,
    required String tillNumber, // Your sandbox till
  }) async {
    if (_accessToken == null) await authenticate();

    final url = Uri.parse('$baseUrl/payments'); // correct endpoint
    final body = jsonEncode({
      "payment_channel": "M-PESA",
      "till_number": tillNumber,
      "amount": amount.toStringAsFixed(2),
      "currency": "KES",
      "customer": {
        "first_name": "Test",
        "last_name": "User",
        "phone_number": phoneNumber,
      },
      "callback_url": "https://webhook.site/YOUR-TEST-URL",
      "metadata": {"notes": "Test donation"}
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 201) {
      print('✅ STK Push initiated successfully: ${response.body}');
    } else {
      print('❌ STK Push failed: ${response.statusCode} - ${response.body}');
      throw Exception('STK Push failed');
    }
  }


  /// STEP 3: Fetch all incoming payments (donations)
  ///
  /// Retrieves a list of payments made to your account.
  Future<List<Map<String, dynamic>>> fetchIncomingPayments() async {
    if (_accessToken == null) await authenticate();

    final url = Uri.parse('$baseUrl/incoming_payments');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final payments = List<Map<String, dynamic>>.from(data['data']);
      print('✅ Retrieved ${payments.length} payments');
      return payments;
    } else {
      print('❌ Fetch Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to fetch payments');
    }
  }

  Future<void> initiateIncomingPayment({
    required String phoneNumber,
    required double amount,
    required String campaignName,
  }) async {
    if (_accessToken == null) await authenticate();

    final url = Uri.parse('https://sandbox.kopokopo.com/api/v1/incoming_payments');

    final body = jsonEncode({
      "payment_channel": "M-PESA",
      "till_number": "K000000",
      "amount": amount.toStringAsFixed(2),
      "currency": "KES",
      "customer": {
        "phone_number": phoneNumber,
      },
      "metadata": {
        "campaign_name": campaignName,
      },
      "callback_url": "https://webhook.site/YOUR-TEST-URL"
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('✅ Payment initiated successfully: ${response.body}');
    } else {
      print('❌ Payment initiation failed: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to initiate payment');
    }
  }


  /// STEP 4: Simulate a payment in sandbox (for testing)
  ///
  /// This allows you to mock an incoming payment in the sandbox environment.
  Future<void> simulatePayment({
    required String phoneNumber,
    required double amount,
    required String tillNumber,
  }) async {
    if (_accessToken == null) await authenticate();

    final url = Uri.parse('$baseUrl/payments/simulate'); // correct endpoint
    final body = jsonEncode({
      "payment_channel": "M-PESA",
      "till_number": tillNumber,
      "amount": amount.toStringAsFixed(2),
      "currency": "KES",
      "customer": {
        "first_name": "Test",
        "last_name": "User",
        "phone_number": phoneNumber,
      },
      "metadata": {"notes": "Test donation"},
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 201) {
      print('✅ Payment simulated successfully: ${response.body}');
    } else {
      print('❌ Simulation failed: ${response.statusCode} - ${response.body}');
      throw Exception('Payment simulation failed');
    }
  }


  // Helper method to format phone number
  String _formatPhoneNumber(String phone) {
    // Remove any spaces or special characters
    String cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');

    // Convert to 254 format if it's in 07... or 7... format
    if (cleaned.startsWith('07') && cleaned.length == 10) {
      return '254${cleaned.substring(1)}';
    } else if (cleaned.startsWith('7') && cleaned.length == 9) {
      return '254$cleaned';
    } else if (cleaned.startsWith('254') && cleaned.length == 12) {
      return cleaned;
    }

    return cleaned; // Return as is if already formatted
  }
}
