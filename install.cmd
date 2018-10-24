@PowerShell -ExecutionPolicy Bypass -Command Invoke-Expression $('$args=@(^&{$args} %*);'+[String]::Join(';',(Get-Content '%~f0') -notmatch '^^@PowerShell.*EOF$')) & goto :EOF

echo "                                           _           "
echo "       ___ _ __   __ _  ___ ___     __   _(_)_ __ ___  "
echo "      / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \ "
echo "      \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |"
echo "      |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|"
echo "          |_|                                          "
echo "                                                       "

Push-Location ~

$app_name    = "space-vim"
$repo_url    = "https://github.com/liuchengxu/space-vim.git"
$repo_name   = "space-vim"
$repo_path   = "$HOME\.space-vim"

if ((Get-Command "git.exe" -ErrorAction SilentlyContinue) -eq $null)
{
   Write-Host "Unable to find git.exe in your PATH"
   pause
   exit
}

if ((Get-Command "vim.exe" -ErrorAction SilentlyContinue) -eq $null)
{
   Write-Host "Unable to find vim.exe in your PATH"
   pause
   exit
}

if (!(Test-Path "$HOME\.space-vim")) {
    echo "==> Trying to clone $app_name"
    git clone $repo_url $repo_path
} else {
    echo "==> Trying to update $app_name"
    Push-Location $repo_path
    git pull origin master
}

echo ""

if (!(Test-Path "$HOME\.vim\autoload\plug.vim")) {
    echo "==> Trying to download vim-plug"
    md ~\.vim\autoload
    $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    (New-Object Net.WebClient).DownloadFile($uri,$ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\.vim\autoload\plug.vim"))
} else {
    echo "[OK] plug.vim is ready"
}

if (!(Test-Path "$HOME\.vimrc")) {
    cmd /c mklink $HOME\.vimrc $repo_path\init.vim
} else {
    echo "[OK] .vimrc already exists"
}

if (!(Test-Path "$HOME\.spacevim")) {
    echo "Generating .spacevim from the template"
    Copy-Item -Path $repo_path\init.spacevim -Destination $HOME\.spacevim -Force
} else {
    echo "[OK] .spacevim already exists"
}

echo ""
echo "Almost done!"
echo "===================================================================="
echo "==    Open GVim and it will install the plugins automatically     =="
echo "===================================================================="
echo ""
echo "That's it. Thanks for installing $app_name. Enjoy!"
echo ""

pause
