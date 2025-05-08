
--[[   
关键字集合，保留用于测试test
    
Kill 'com.motorola.camera3'

Mcflkp  : Alg benchmark [0x15F0000-JGRawHDR]: prepare: 1 ms, process: 3244 ms

McfCaptureRequestRunnable: Capture time:5330 sceneMode:FALL_BACK

02-26 06:16:58.037   644   644 I lowmemorykiller: Kill 'com.motorola.camera5' (8163), uid 10209, oom_score_adj 0 to

02-25 14:41:28.767  2847  3084 W ActivityManager: Unable to launch app com.motorola.camera3/10209 for provider com.motorola.camera3.background.provider.filedatacontract.FileProviderCustom: launching app became null
02-25 14:41:28.769 20831 12366 E ActivityThread: Failed to find provider info for com.motorola.camera3.background.provider.filedatacontract.FileProviderCustom

02-26 06:16:50.100  1732  3406 I ActivityManager: no adj 200+ process, memory is very low, trigger a low memory report for perf team to check further
03-05 22:04:07.692  5850  5920 E AndroidRuntime: Process: com.motorola.camera3, PID: 5850
03-05 22:04:07.692  5850  5920 E AndroidRuntime: java.lang.ArrayIndexOutOfBoundsException: length=0; index=11
03-05 22:04:07.692  5850  5920 E AndroidRuntime: 	at android.util.ArrayMap.valueAt(ArrayMap.java:532)
03-05 22:04:07.692  5850  5920 E AndroidRuntime: 	at com.motorola.camera.fsm.camera.states.runnables.CaptureRequestRunnable.run(SourceFile:2)

--]]
local default_patterns = {
    "拍照失败|CaptureFailed|camera2.*Exception|Dump ERROR Stack Trace|onCaptureFailed|One-shot did not succeed|processFrames failed|No frames found|not enough frames|E McfSnapshotManagementThread:|onSaveError|allFailed=true|BG-Process Job is cancelled|Unable to configure streams|No capture record|Capture failed|ToastUIComponent|aborting capture|ALGORITHM_FAILURE|STATE_MACHINE_FAILURE|FRAME_COLLECTION_FAILURE|REPROCESS_FAILURE|SWJPEG_REPROC_FAILURE",

    -- 情况1: lowmemorykiller杀死camera3导致camera3闪退
    -- 02-26 06:16:58.037   644   644 I lowmemorykiller: Kill 'com.motorola.camera5' (8163), uid 10209, oom_score_adj 0 to
    -- 02-25 14:41:28.767  2847  3084 W ActivityManager: Unable to launch app com.motorola.camera3/10209 for provider com.motorola.camera3.background.provider.filedatacontract.FileProviderCustom: launching app became null
    -- 02-25 14:41:28.769 20831 12366 E ActivityThread: Failed to find provider info for com.motorola.camera3.background.provider.filedatacontract.FileProviderCustom
    -- 情况2:
    -- 03-05 22:04:07.692  5850  5920 E AndroidRuntime: Process: com.motorola.camera3, PID: 5850
    -- 03-05 22:04:07.692  5850  5920 E AndroidRuntime: java.lang.ArrayIndexOutOfBoundsException: length=0; index=11
    -- 03-05 22:04:07.692  5850  5920 E AndroidRuntime: 	at android.util.ArrayMap.valueAt(ArrayMap.java:532)
    -- 03-05 22:04:07.692  5850  5920 E AndroidRuntime: 	at android.os.BaseBundle.getValueAt(BaseBundle.java:399)
    -- 03-05 22:04:07.692  5850  5920 E AndroidRuntime: 	at com.motorola.camera.fsm.camera.states.runnables.CaptureRequestRunnable.run(SourceFile:2)
    -- 情况3: 
    -- 崩溃堆栈，没有。只有一条错误的日志。参考 https://idart.mot.com/browse/IKSWV-147587
    -- 05-06 10:38:16.444  1987  2029 I am_crash: [15282,0,com.motorola.camera5,819478085,java.lang.IllegalArgumentException, Each request must have at least one Surface target
    "崩溃|Fatal exception|FATAL_EXCEPTION|AndroidRuntime.*camera|com.motorola.camera.*IllegalArgumentException|F DEBUG|Kill .com.motorola.camera[35]. |Dump ERROR Stack Trace|Unable to configure streams|CameraAccessException|kill.*com.motorola.deviceguard|NO CAMERAS AVAILABLE|E SettingsManager|E MotoCameraController|W Error|E CameraCaptureSession|Unable to launch app com.motorola.camera[35]|Failed to find provider info for com.motorola.camera[35]",
    -- 情况1: 用户误触导致的假crash真退出
    -- 按home键，能看到 com.android.launcher 的日志，也会发送 android.intent.action.MAIN
    -- 参考：https://idart.mot.com/browse/IKSWV-122489
    "camera生命周期|CameraLifeCycle|wm_.*activity.*Camera,|wm_.*,Camera,|am_proc_start.*Camera|am_kill.*Camera|onResume|onPause|input_interaction: Interaction with|KPI-6PA-ID.*motion event|Inputdispatcher.*com.motorola.camera|BACK_KEY",
    "AutoFocusStateMachine|CameraKpiTag: AUTO_FOCUS",
    -- 情况1: 冻屏时，处理拍照非常的慢，有Mcflkp和McfCaptureRequestRunnable的日志
    -- Mcflkp  : Alg benchmark [0x15F0000-JGRawHDR]: prepare: 1 ms, process: 3244 ms
    -- McfCaptureRequestRunnable: Capture time:5330 sceneMode:FALL_BACK
    --
    -- 情况2: 对焦超时导致 FocusExposureLockRunnable: lock focus timeout日志
    -- 
    -- 情况3: activity low memory
    -- 02-26 06:16:50.100  1732  3406 I ActivityManager: no adj 200+ process, memory is very low, trigger a low memory report for perf team to check further
    --
    "冻屏_freeze|lowmemorykiller.*cpuload ([456789]\\d|100)|lowmemorykiller.*cpu psi [456789]\\d|mempsi \\d\\d|low memory|cpuload ([789]\\d|100)|CPU usage.*\\d\\d\\d\\dms|CameraKpiTag.*\\d\\d\\d\\d ms|ActivityManager.*\\d\\d\\d\\dms|Mcflkp  : Alg benchmark.*process: \\d{4,} ms|McfCaptureRequestRunnable: Capture time:(\\d{5,}|[3456789]\\d{3})|FocusExposureLockRunnable:.*lock focus timeout|memory is very low",
    --AF timeout导致无法拍照 https://idart.mot.com/browse/IKSWV-94659
    "CameraFsm| Fsm |MotoCamera: |CameraKpiTag| ActivityBase:|CameraModeSwitch|CameraStateManager|CloseAppRunnable|CloseCameraRunnable|CloseCameraRunnable|OpenCameraRunnable|OpenCameraCallable||SHUTTER_BUTTON_CLICKED|playCaptureLottieAnimate shutterState:",
    "engine错误|onCaptureFailed|E CameraFsm|E CameraDevice|W CameraDevice|E Camera3-Device|E CamX : [ERROR]|E CamX.*Buffer|E CamX.*TimedWait|E CamX.*not|CAM_ERR.*Unexpected state|CamX.*error|CamX.*Failure|CamX.*failed|CamxResultETimeout|E CHI|E CHI.*bad state|CAM_ERR|there might be a leak|failed to get buffer|Unable to.*buffer|E MtkCam|CameraService|CameraService_proxy|Camera3-Device",
    "ANR at|anr traces|Input dispatching timed out.*camera[35]|blocked by|held by thread|waiting to lock|I am_anr.*camera|begin ANR dump all threads|ActivityThread: main stack element",
    "系统重启|reboot|bootstat:|bootstat:.*kernel_panel",
    "模式和前后镜头切换|logicalCameraId is|logicalCameraId=|setupForMode",
    -- gesture 打印log很多，若是需要查看activity的生命周期由gesture引起，单独查询
    "TOUCH_GESTURE|Gesture|com.android.launcher|isActionMain|android.intent.action.MAIN"
}

return default_patterns
