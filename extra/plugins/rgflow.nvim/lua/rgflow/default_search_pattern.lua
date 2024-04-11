
-- lowmemorykiller杀死camera3导致camera3闪退
-- Kill 'com.motorola.camera3' 有问题，所以替换成 Kill .com.motorola.camera3
local default_patterns = {
    "拍照失败|CaptureFailed|camera2.*Exception|Dump ERROR Stack Trace|onCaptureFailed|One-shot did not succeed|processFrames failed|No frames found|not enough frames|E McfSnapshotManagementThread:|onSaveError|allFailed=true|BG-Process Job is cancelled|Unable to configure streams|No capture record|Capture failed|ToastUIComponent",
    "崩溃|Fatal exception|FATAL_EXCEPTION|AndroidRuntime|F DEBUG|NullPointerException|Kill .com.motorola.camera3. |Dump ERROR Stack Trace|Unable to configure streams|CameraAccessException|kill.*com.motorola.deviceguard",
    "黑屏|其他|NO CAMERAS|E SettingsManager|E MotoCameraController|W Error|E CameraCaptureSession",
    "camera生命周期|CameraLifeCycle|wm_.*activity.*Camera,|wm_on.*called,Camera,|am_proc_start.*camera3|am_kill.*camera3",
    "AutoFocusStateMachine|CameraKpiTag: AUTO_FOCUS",
    "lowmemorykiller.*cpuload ([456789]\\d|100)|lowmemorykiller.*cpu psi [456789]\\d|mempsi \\d\\d|low memory|cpuload ([789]\\d|100)|CPU usage.*\\d\\d\\d\\dms|CameraKpiTag.*\\d\\d\\d\\d ms|ActivityManager.*\\d\\d\\d\\dms",
    "MotoCamera: |CameraKpiTag",
    "lowmemorykiller",
    "ShotSlot=INVALID",
    "engine错误|E CamX : [ERROR]|E CamX.*Buffer|E CamX.*TimedWait|E CamX.*not|CAM_ERR.*Unexpected state|CamX.*error|CamX.*Failure|CamX.*failed|E CHI|E CHI.*bad state|CAM_ERR|there might be a leak|failed to get buffer|Unable to.*buffer|E MtkCam",
    "ANR at|anr traces|Input dispatching timed out.*camera3|blocked by|held by thread|waiting to lock|I am_anr.*camera|begin ANR dump all threads|ActivityManager.*error|Looper.*slow|Looper.*Drained",
    "系统重启|reboot|bootstat:|bootstat:.*kernel_panel",
    "点击事件|input_interaction: Interaction with|KPI-6PA-ID.*motion event",

}

return default_patterns
