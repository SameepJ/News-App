import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig remoteConfig;

  RemoteConfigService(this.remoteConfig);

  Future<void> fetchAndActivate() async {
    // Set the config settings
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 38),
      ),
    );

    // Set default values for remote config parameters
    await remoteConfig.setDefaults(const {
      '_Undermaintenance': false,
      '_countrycode': 'IN',
    });

    // Fetch and activate remote config
    await remoteConfig.fetchAndActivate();

    // Log the values
    print('_Undermaintenance ==> ${remoteConfig.getBool('_Undermaintenance')}');

    // Check if the app is under maintenance
    if (remoteConfig.getBool('_Undermaintenance')) {
      print("The app is currently under maintenance.");
    } else {
      print("The app is running normally.");
    }
  }

  // Method to fetch the country code from Firebase Remote Config
  String getCountryCode() {
    // Retrieve the country code from the remote config
    String countryCode = remoteConfig.getString('_countrycode');
    print('Country Code fetched from Remote Config: $countryCode');
    return countryCode;
  }

}
