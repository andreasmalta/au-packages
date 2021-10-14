import-module au

$domain   = 'https://www.kinovea.org'
$releases = "$domain/download.html"


function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
    ".\librecad.nuspec" = @{
      "\<releaseNotes\>.+" = "<releaseNotes>$($Latest.ReleaseNotes)</releaseNotes>"
    }
  }
}

#https://www.kinovea.org/setup/kinovea.0.9.5/Kinovea-0.9.5-x64.exe

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = '\.exe$'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

  $version  = ($url -split '/' | select -Last 1 -Skip 1)

  $releaseNotesUrl = "$domain/LibreCAD/LibreCAD/releases/tag/" + $version

  @{
    URL32 = $domain + $url
    Version = $version
    ReleaseNotes = $releaseNotesUrl
  }
}

update -ChecksumFor 32
