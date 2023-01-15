package com.zee.bsccs

import android.os.Bundle
import android.util.Log
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {
        private const val CHANNEL_NAME = "channel_downloader"
    }

    private lateinit var viewModel: DownloadViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewModel = ViewModelProvider(
            ViewModelStore(), DownloadViewModelFactory(this.context)
        )[DownloadViewModel::class.java]
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_NAME
        ).setMethodCallHandler { call, result ->
            if (call.method.equals("startDownload")) {
                startDownload(call, result)
            }

            if (call.method.equals("checkFileExists")) {
                checkFileExists(call, result)
            }
        }
    }

    private fun startDownload(call: MethodCall, result: MethodChannel.Result) {
        // getApplicationSupportDirectory => /data/user/0/com.zee.bsccs/files
        // context.filesDir => /data/user/0/com.zee.bsccs/files

        // getExternalStorageDirectory => /storage/emulated/0/Android/data/com.zee.bsccs/files
        // getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS) => /storage/emulated/0/Android/data/com.zee.bsccs/files/Download

        // getApplicationDocumentsDirectory /data/user/0/com.zee.bsccs/app_flutter (user/0)==data




        Log.e("zeeshan", "startDownload: ${call.arguments} ${viewModel.parentDirectoryPath?.path}")
        val link = call.argument<String>("link")
        if (link != null) {
            val taskId = viewModel.startDownload(link)
            result.success(taskId)
        }

    }

    private fun checkFileExists(call: MethodCall, result: MethodChannel.Result) {

        Log.e("zeeshan", "checkFileExists: ${call.arguments}")
        val fileName = call.argument<String>("fileName")
        if (fileName != null) {
            val exits = viewModel.checkFileExists(fileName)
            Log.e("zeeshan", "checkFileExists:result $exits")
            result.success(exits)
        }

    }


}
