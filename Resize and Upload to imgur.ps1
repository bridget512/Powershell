# Bridget512 - 7 June 2019
# https://github.com/bridget512
################################
## Requirements:
## Image Magick Portable folder in same directory (renamed) as the powershell script.
## Register an Application for the imgur API.
## Script uses Firefox as a browser. 

# Register an Application for the imgur API.
## https://api.imgur.com/oauth2/addclient
# Application Name: Whatever you want.
# Authorization Type: Anonymous useage without user authorization.
## Use "https://api.imgur.com/oauth2" as callback URL.
# You'll be given a ClientID and a ClientSecret ID. Paste the ClientID code into the $clientID Variable.
################################

$clientID = ""

$saveLocation = "F:\Desktop"
$file_renamed = "temp.jpg"
$file_maxDimension = 1280
$file_quality = 92


Add-Type -AssemblyName System.Windows.Forms

$selectImage = New-Object System.Windows.Forms.OpenFileDialog
$selectImage.ShowDialog()
$file = $selectImage.FileName

..\ImageMagickPortable\magick.exe convert $file -resize $file_maxDimension -quality $file_quality "$saveLocation\$file_renamed"

$convToBase64 = [convert]::ToBase64String((get-content "$saveLocation\$file_renamed" -encoding byte))

$upload = Invoke-WebRequest -uri "https://api.imgur.com/3/upload" -UseBasicParsing -method POST -body $convToBase64 -headers @{"Authorization" = "Client-ID $clientID"} -Verbose
$content = $upload.content
$contentObject = ConvertFrom-Json -InputObject $content
$imgurLink = $contentObject.data.link

Start-Process $imgurLink