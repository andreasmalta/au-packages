$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'kinovea'
  fileType      = 'exe'
  url           = 'https://www.kinovea.org/setup/kinovea.0.9.5/Kinovea-0.9.5-x64.exe'
  checksum      = '489fbcc5006b97830511490b251772bbcc7d23689cb8a635b8bf75590c2b7656'
  checksumType  = 'sha256'
  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}
Install-ChocolateyPackage @packageArgs
