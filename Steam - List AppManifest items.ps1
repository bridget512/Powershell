Clear-Host

Write-Host "Navigate to the steamapps folder"
Write-Host "E.g. D:\Steam\SteamLibrary\steamapps"

function Dialog-OpenFolder(){
    Add-Type -AssemblyName System.Windows.Forms

    $Select_Folder = New-Object System.Windows.Forms.FolderBrowserDialog
    $Select_Folder.ShowDialog()
    $Select_Folder.RootFolder
    cd  $Select_Folder.SelectedPath
}

Dialog-OpenFolder
    

$num = 0
$names = Select-String -path *.acf -Pattern "name"

Write-Host "ID`t FileName                                                           Game "

ForEach($name in $names){

    Write-Host "$num`t $($name)"
    $num++

}

pause

