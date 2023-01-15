package com.zee.bsccs

import android.app.DownloadManager
import android.content.Context
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import java.io.File

class DownloadViewModel(
    context: Context,
) :
    ViewModel() {
    companion object {
        private const val TAG = "DownloadViewModel"
    }

    private val downloadManager: DownloadManager =
        context.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
     val parentDirectoryPath = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS)
    // filesDir =>/data/user/0/com.zee.bsccs/files

//    private val _progress = MutableStateFlow(0L)
//    private val _isCompleted = MutableStateFlow(false)
//    private val _isCancelled = MutableStateFlow(false)
//    private val _isDownloading = MutableStateFlow(false)
//    private var noOfDownloads = 0
//    private var job: Job? = null


//    val downloadState = combine(
//        _isDownloading,
//        _progress,
//        _isCompleted,
//        _isCancelled
//    ) { isDownloading, progress, isCompleted, isCancelled ->
//        val isAvailable = isCompleted && !isCancelled && !isDownloading
//
//        DownloadState(
//            isDownloading = isDownloading,
//            progress = progress,
//            isOfflineAvailable = isAvailable,
//            isCancelled = isCancelled
//
//        )
//    }.stateIn(viewModelScope, SharingStarted.Eagerly, DownloadState())
//

    //init {


//        viewModelScope.launch(Dispatchers.IO) {
//            _state.value = repository.getDocument(document.title)
//        }

//        _isDownloading.onEach { isDownloading ->
//            job?.cancel()
//            job = viewModelScope.launch {
//                while (isDownloading && this.isActive) {
//                    getProgress()?.let {
//                        _progress.value = it
//                    }
//                    delay(100)
//                }
//            }
//            job?.start()
//        }.launchIn(viewModelScope)


//    }


//    fun isDownloadManagerDownloading(): Boolean {
//        val status = DownloadManager.STATUS_RUNNING
//        val query = DownloadManager.Query()
//        query.setFilterByStatus(status)
//        val c: Cursor = downloadManager.query(query)
//        if (c.moveToFirst()) {
//            c.close()
//            return true
//        }
//        return false
//    }

    private fun getDownloadRequestLink(url: String): DownloadManager.Request {

        val fileName = url.substringAfter("id=").substringBeforeLast("&")
        val fileUri = Uri.parse(url)

        Log.d(TAG, "getPdfFileDownloadRequest: url $url filename $fileName")
        val request: DownloadManager.Request = DownloadManager.Request(fileUri)
        request.apply {
            setAllowedNetworkTypes(
                DownloadManager.Request.NETWORK_WIFI or
                        DownloadManager.Request.NETWORK_MOBILE
            )
//            {link=https://drive.google.com/u/0/uc?id=1ffEptVG4g0ZUrglQmlYUbN8_UPMxSW-4&export=download}
            setTitle(fileName)
            setDescription("Android Data download using DownloadManager.")
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                setRequiresCharging(false)
            }
            setAllowedOverRoaming(true)
            setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED)
            val file = File(parentDirectoryPath, "$fileName.pdf")
            setDestinationUri(Uri.fromFile(file))
        }
        return request
    }


    fun startDownload(link: String): Long {
        return downloadManager.enqueue(getDownloadRequestLink(link))
    }

    fun checkFileExists(fileName: String): Boolean {
        return File(parentDirectoryPath, fileName).exists()
    }


//    private fun getProgress(): Long? {
//        val query = DownloadManager.Query()
//        query.apply {
//            if (pdfDownloadRequestId != null && videoDownloadRequestId != null)
//                setFilterById(pdfDownloadRequestId!!, videoDownloadRequestId!!)
//            else if (pdfDownloadRequestId != null)
//                setFilterById(pdfDownloadRequestId!!)
//            else if (videoDownloadRequestId != null)
//                setFilterById(videoDownloadRequestId!!)
//
//        }
//
//        val list = mutableListOf<Boolean>()
//        val cursor = downloadManager.query(query)
//        if (cursor.count < noOfDownloads) {
//            _isCancelled.value = true
//            _isDownloading.value = false
//            _isCompleted.value = true
//            return null
//        }
//
//        var dLProgress = 0L
//
//        cursor.moveToFirst()
//
//
//        do {
//            val bytesDownloaded =
//                cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_BYTES_DOWNLOADED_SO_FAR))
//            val bytesTotal =
//                cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_TOTAL_SIZE_BYTES))
//            val downloadStatus = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_STATUS))
//            val failedReason = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_REASON))
//
//            if (downloadStatus == DownloadManager.STATUS_SUCCESSFUL) {
//                list.add(true)
//
//            } else {
//                list.add(false)
//            }
//
//            dLProgress += ((bytesDownloaded * 100L) / bytesTotal) / 2
//        } while (cursor.moveToNext())
//
//        _isDownloading.value = list.any { !it }
//        _isCompleted.value = list.all { it }
//        list.clear()
//
//
//        cursor.close()
//        return dLProgress
//    }

    data class DownloadState(
        val isDownloading: Boolean = false,
        val isOfflineAvailable: Boolean = false,
        val isCancelled: Boolean = false,
        val progress: Long = 0
    )

}

class DownloadViewModelFactory(val context: Context) : ViewModelProvider.NewInstanceFactory() {
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        return DownloadViewModel(context) as T
    }
}
