package com.example.test_transmit

import android.util.Log
import androidx.annotation.NonNull
import com.transmit.identityverification.ITSIdentityVerificationStatus
import com.transmit.identityverification.TSIdentityVerification
import com.transmit.identityverification.TSIdentityVerificationError
import com.transmit.identityverification.TSRecaptureReason
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity(), ITSIdentityVerificationStatus {
  private val channel = "com.example.flutter_native_communication/platform_channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            if (call.method == "initTSSDk") {
                val clientId = call.argument<String>("clientId")
                if (clientId != null) {
                    TSIdentityVerification.initialize(this, clientId)
                    TSIdentityVerification.registerForStatus(this)
                } else {
                    result.error("MISSING_ARGUMENT", "clientId string is missing", null)
                }
            } else if (call.method == "startSession") {
                val startToken = call.argument<String>("startToken")
                if (startToken != null) {
                    TSIdentityVerification.start(this, startToken)
                } else {
                    result.error("MISSING_ARGUMENT", "clientId string is missing", null)
                }
            } else if (call.method == "recapture") {
                TSIdentityVerification.recapture(context)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun verificationStartCapturing() {
        println("verification start capturing")
        Log.d("startCapturing", "verificationStartCapturing")
    }

    override fun verificationStartProcessing() {
        println("verification start processing")
        Log.d("startProcessing", "verificationStartProcessing")
    }

    override fun verificationRequiresRecapture(p0: TSRecaptureReason?) {
        println("verification require recapture")
    }

    override fun verificationCompleted() {
        println("verification completed")
    }

    override fun verificationCanceled() {
        println("verification canceled")
        Log.d("verificationCanceled", "verificationCanceled")
    }

    override fun verificationFail(p0: TSIdentityVerificationError) {
        println("verification fail")
        Log.d("verificationCanceled", "verificationCanceled")
    }
}
