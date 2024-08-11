package com.example.smartbet

import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
   init {
        System.loadLibrary("TrustWalletCore")
    }
}
