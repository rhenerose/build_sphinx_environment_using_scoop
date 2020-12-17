# sphinx用のPython仮想環境のパス
$SPHINX_VENV_PATH="c:\venv\sphinx"

#選択肢の作成
$typename = "System.Management.Automation.Host.ChoiceDescription"
$yes = new-object $typename("&Yes", "Confirm")
$no  = new-object $typename("&No", "Abort")

#選択肢コレクションの作成
$assembly= $yes.getType().AssemblyQualifiedName
$choice = new-object "System.Collections.ObjectModel.Collection``1[[$assembly]]"
$choice.add($yes)
$choice.add($no)

#選択プロンプトの表示
Write-Host "###################" -ForegroundColor Red -BackgroundColor Black
Write-Host "##### WARNING #####" -ForegroundColor Red -BackgroundColor Black
Write-Host "###################" -ForegroundColor Red -BackgroundColor Black
Write-Host "This script creates New Python virtual environment in '${SPHINX_VENV_PATH}'. " -ForegroundColor Red -BackgroundColor Black
$answer = $host.ui.PromptForChoice("Execution confirmation", "Do you want to run it?", $choice, 1)

if ($answer -eq 1) {
    Write-Host "################### " -ForegroundColor Red -BackgroundColor Black
    exit
}

##################################################
# install Scoop
##################################################
# インストールディレクトリの設定 (user)
#$env:SCOOP='D:\Applications\Scoop'
#[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')

# インストールディレクトリの設定 (global)
#$env:SCOOP_GLOBAL='D:\GlobalScoopApps'
#[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')

try {
    # Scoopのインストール確認
    get-command scoop -ErrorAction Stop
} 
catch [Exception] {
    # Scoopのインストール
    Write-Host "install scoop!!" -ForegroundColor Green
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

try {
    # install basic module
    scoop install aria2
    try {
        # Gitのインストール確認
        get-command git -ErrorAction Stop
        Write-Host "git command Exists!!" -ForegroundColor Yellow
    } 
    catch [Exception] {
        # Gitのインストール
        Write-Host "install git!!" -ForegroundColor Green
        scoop install git
    }

    # add bucket
    scoop bucket add extras
    scoop bucket add versions

    ##################################################
    # install Python
    ##################################################
    $py3_command = $null
    $py3_installed = $true
    try {
        # Python3のインストール確認
        get-command python3 -ErrorAction Stop
        $py3_command = 'python3'
    }
    catch [Exception] {
        try {
            # Pythonのインストール確認
            # check python version
            $py_ver = (get-command python -ErrorAction Stop).Version
            if ($py_ver.Major -eq 3) {
                $py3_command = 'python'
            }
            else {
                $py3_installed = $false
            }
        } 
        catch [Exception] {
            $py3_installed = $false
        }
    }

    if ($py3_installed -eq $false) {
        # Pythonのインストール
        Write-Host "install python37!!" -ForegroundColor Green
        scoop install python37
        $py3_command = 'python37'
    }
    else {
        Write-Host "${py3_command} command Exists!!" -ForegroundColor Yellow
    }

    # create venv
    invoke-expression "${py3_command} -m venv ${SPHINX_VENV_PATH}"
    invoke-expression ${SPHINX_VENV_PATH}\Scripts\activate.ps1

    # *** 以降は仮想環境(venv)上で実行する ***

    # upgrade pip
    python -m pip install --upgrade pip


    ##################################################
    # install sphinx
    ##################################################
    pip install sphinx

    # install theme `sphinx_rtd_theme`
    pip install sphinx_rtd_theme


    # install other extention
    # for `.md`
    pip install recommonmark
    pip install sphinx-markdown-tables

    # for `.ipynb`
    pip install ipython
    pip install nbsphinx
    try {
        # pandocのインストール確認
        get-command pandoc -ErrorAction Stop
        Write-Host "pandoc command Exists!!" -ForegroundColor Yellow
    } 
    catch [Exception] {
        # pandocのインストール
        Write-Host "install pandoc!!" -ForegroundColor Green
        scoop install pandoc
    }

    # install latex for pdf output
    try {
        # latexのインストール確認
        get-command latex -ErrorAction Stop
        Write-Host "latex command Exists!!" -ForegroundColor Yellow
    } 
    catch [Exception] {
        # latexのインストール
        Write-Host "install latex!!" -ForegroundColor Green
        scoop install latex
    }
    try {
        # perlのインストール確認
        get-command perl -ErrorAction Stop
        Write-Host "perl command Exists!!" -ForegroundColor Yellow
    } 
    catch [Exception] {
        # perlのインストール
        Write-Host "install perl!!" -ForegroundColor Green
        scoop install perl
    }
}
catch [Exception] {
    $error[0] | Format-List -force
}
