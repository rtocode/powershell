﻿
Add-Type –assemblyName WindowsBase
Add-Type –assemblyName PresentationFramework
Add-Type –assemblyName PresentationCore

$code = @"
[DllImport("user32.dll", SetLastError = true)] 
public static extern int GetWindowLong(IntPtr hWnd, int nIndex); 
[DllImport("user32.dll")] 
public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);
"@

Add-Type -MemberDefinition $code -Name Win32Util -Namespace System

$WS_BORDER = 0x00800000
$WS_DLGFRAME = 0x00400000
$WS_CAPTION = $WS_BORDER -bor $WS_DLGFRAME
$WS_THICKFRAME = 0x00040000
$WS_MINIMIZE = 0x20000000
$WS_MAXIMIZE = 0x01000000
$WS_SYSMENU = 0x00080000
$WS_EX_DLGMODALFRAME = 0x00000001
$WS_EX_CLIENTEDGE = 0x00000200
$WS_EX_STATICEDGE = 0x00020000
$GWL_EXSTYLE = -20
$GWL_STYLE = -16
$MainWindowHandle = ([system.diagnostics.process]::GetCurrentProcess()).MainWindowHandle

$style = [System.Win32Util]::GetWindowLong($MainWindowHandle,$GWL_STYLE)
[System.Win32Util]::SetWindowLong($MainWindowHandle,$GWL_STYLE, $style -band -bnot($WS_CAPTION -bor $WS_THICKFRAME -bor $WS_MINIMIZE -bor $WS_MAXIMIZE -bor $WS_SYSMENU)) | out-null

$pshost = get-host
$pswindow = $pshost.ui.rawui
$newsize = $pswindow.windowsize 

$newsize.height = 15
$newsize.width = 120
$pswindow.windowsize = $newsize



function prompt
{
    Write-Host "`t`tChoose an account to log in with:" -nonewline -foregroundcolor White
    return " "
    
}
prompt

clear-host
$login_prompt = @"
`t`t   __  _______ ___    ___ 
`t`t  / / / / ___//   |  /   |
`t`t / / / /\__ \/ /| | / /| |
`t`t/ /_/ /___/ / ___ |/ ___ |
`t`t\____//____/_/  |_/_/  |_|
                          
`t`t[1] "A" account
`t`t[2] "***TC07"
`t`t[3] "***TC08"
`t`t[3] "***TC09"
"@

write-host $login_prompt

