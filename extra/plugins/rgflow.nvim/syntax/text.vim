if exists('b:current_syntax')
    finish
  endif

  let s:cpo_save = &cpoptions
  set cpoptions&vim

  " Moto Camera log syntax
  "---------------------------------------------------------------------------
  syn match motCameraTriggerError "ERROR_CLOSED\|ERROR_RETRY\|DRAG_FAILED\|LP_CAPTURE_FAIL\|CAPTURE_FAILED\|RECORDING_ERROR\|RECORDER_ERROR\|CURRENT_MEMORY_NOT_AVAILABLE\|MEMORY_NOT_AVAILABLE\|AUTO_FOCUS_TRACKING_CANCEL\|CAPTURE_CANCEL\|SHUTTER_BUTTON_CANCEL"
  hi link motCameraTriggerError Error
  syn match keyErrorFatal "Error\|ERROR\|error\|fatal\|Fatal\|ERR\|onError"
  hi link keyErrorFatal Error
  syn match keyInvalid "Invalid\|INVALID\|invalid"
  hi link keyInvalid Error
  syn match keyNullEmpty "Null\|Empty\|NULL\|empty\|null"
  hi link keyNullEmpty Error
  syn match keyTime "timeout\|Timeout\|TIMEOUT"
  hi link keyTime Error
  syn match keyKillCrash "killed\|Killed\|kill\|Kill\|crash\|Crash\|die\|died\|dying"
  hi link keyKillCrash Error
  " failed在前，优先级priority更高
  syn match keyFail "failed\|Failed\|Failutre\|FAILURE\|failure\|fail\|Fail"
  hi link keyFail Error
  syn match keyException "NullPointerException\|Exception\|EXCEPTION"
  hi link keyException Error
  syn match keyNo "\<not\>\|\<NOT\>\|\<Not\>\|\<no\>\|\<No\>\|\<NO\>"
  hi link keyNo Error
  syn match keyAbnormal "abnormal\|Abnormal\|Abnoraml\|ABNORMAL"
  hi link keyAbnormal Error
  syn match keyFreeze "freeze\|Freeze\|froze\|Froze\|frozen\|Frozen"
  hi link keyFreeze Error
  syn match keyAble "disable\|Disable\|DISABLE\|unable\|UNABLE"
  hi link keyAble Error
  syn match keyCancel "cancelling\|cancelled\|cancel\|Cancel\|CANCEL"
  hi link keyCancel Error
  syn match keyLeak "leak\|Leak\|LEAK"
  hi link keyLeak Error
  syn match keyQuit "quit\|Quit\|QUIT\|abort\|Abort\|ABORT\|exit\|Exit\|EXIT"
  hi link keyQuit Error
  syn match keyClose "Closing\|closing\|closed\|Closed\|close\|Close\|CLOSE"
  hi link keyClose Error
  syn match keyWait "wait for\|Wait for\|Wating for\|watting for\|waiting to\|Waiting to\|Wait to\|wait to"
  hi link keyWait Error

  syn match waitForMemoryRunnableError "handleStorageFull\|Throttling due to large save queue size\|Cannot do next capture, queue is full, aborting\|There is not enough free bytes for"
  hi link waitForMemoryRunnableError Error

  syn match motCamera "com.motorola.camera"
  hi link motCamera Constant

  syn match motCameraProcess "MotoCamera:\|switchMode fromMode\|CloseCameraRunnable\|OpenCameraRunnable\|SHUTTER_BUTTON_CLICKED\|playCaptureLottieAnimate shutterState:"
  hi motCameraProcess gui=NONE guifg=#F07000 ctermfg=Green 

  syn match fsm "\<Fsm\>" display
  hi fsm gui=NONE guifg=#F07000 ctermfg=Green 

  " 匹配fsm中的状态，高亮不同颜色
  syn match fsmTransitionState "\[.\{-}\]"hs=s+1,he=e-1 contained display
  hi fsmTransitionState gui=underline guifg=#ff0c39 ctermfg=Yellow
  " 匹配fsm transtion中的高亮
  " 匹配 Transition from [RESET] to [INIT, PERMISSIONS_OPTIONAL]
  syn match fsmTransition "Transition from \[.*\] to \[.*\]" contains=fsmTransitionState display
  hi fsmTransition gui=NONE guifg=#B501FF ctermfg=Blue 
  " 匹配fsm transtion中的高亮
  " 匹配 [RESET] to [INIT, PERMISSIONS_OPTIONAL]
  syn match fsmNonTransition "\[.*\] to \[.*\]" contains=fsmTransitionState display
  hi fsmNonTransition gui=NONE guifg=#B501FF ctermfg=Blue 

  syn match androidStackTraceLine "AndroidRuntime.*" contained display
  syn region stackTrace start="AndroidRuntime.*" skip="AndroidRuntime" end="$" 
  hi link stackTrace Error

  syn match captureStackTraceLine "CameraCaptureSession.*" contained display
  syn region captureStackTrace start="CameraCaptureSession.*" skip="CameraCaptureSession" end="$" 
  hi link stackTrace Error

  syn match cpupsi "cpupsi [56789]\d\.\d%\|cpupsi 100" contained display
  hi link cpupsi abnormalData

  hi abnormalData guifg=#FF0000 gui=bold ctermfg=15 ctermbg=0, cterm=bold


  " rgflow search 结果用 \30 给包裹起来，所以需要单独高亮
  syn match rgflowSearchPattern "\%d30.*\%d30" display
  hi link rgflowSearchPattern Identifier

  syn match longMcflkp "Mcflkp  : Alg benchmark.*process: \d\{4,} ms"  display
  hi link longMcflkp abnormalData

  syn match longMcfCapture "McfCaptureRequestRunnable: Capture time:\(\d\{5,}\|[3456789]\d\{3}\)" display
  hi link longMcfCapture abnormalData

  " 匹配 cpu load 大于50%，而且只能在 rgflowSearchPattern 才高亮
  syn match cpuload "cpuload [56789]\d\|cpuload 100" contained display
  hi link cpuload Constant

  syn match longMcfLkpDataInRgflowSearch "process: \d\{4,} ms" contained containedin=rgflowSearchPattern display
  hi link longMcflkpInRgSearch Error

  " syn cluster specialInRgSearch contains=longMcfLkpDataInRgflowSearch,cpuload

  " 匹配 lowmemorykiller: PARTIAL stall, KSWAPD reclaim，导致一行过长，故将其隐藏
  syn match lmkPartital "PARTIAL stall, KSWAPD reclaim, " containedin=rgflowSearchPattern conceal

  " syn region myFold start="{" end="}" transparent fold
  " syn sync fromstart
  " set foldmethod=syntax

  " 对logcat的 E/W进行高亮，且必须放置在syntax语法文件最后面，才有最高priority，否则无效
  syn keyword logLevelE "E" contained display
  syn keyword logLevelW "W" contained display
  syn match keyLogLevel " \(E\|W\) " containedin=logLevelE,logLevelW display
  hi link keyLogLevel Error

  let b:current_syntax = 'log'
  
  let &cpoptions = s:cpo_save
  unlet s:cpo_save