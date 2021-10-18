import-module au

$domain   = 'https://www.kinovea.org'
$releases = "$domain/download.html"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
    }
    ".\kinovea.nuspec" = @{
      "\<releaseNotes\>.+" = "<releaseNotes>$($Latest.ReleaseNotes)</releaseNotes>"
    }
  }
}

function global:au_GetLatest {

  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases
  $url = $download_page.links | ? href -match '\.exe$' | select -First 1 -expand href
  $version = ($url -split '/' | select -Last 1 -Skip 1)
  $version = $version -replace "kinovea.", ""
  $releaseNotesUrl = $domain + "/setup/kinovea." + $version + "/Changelog." + $version + ".txt"

  @{
    URL32 = $domain + $url
    Version = $version
    ReleaseNotes = $releaseNotesUrl
  }
}

update -ChecksumFor 32
