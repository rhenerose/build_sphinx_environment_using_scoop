# python venv path for sphinx
$SPHINX_VENV_PATH="c:\venv\sphinx"

# create choices
$typename = "System.Management.Automation.Host.ChoiceDescription"
$yes = new-object $typename("&Yes", "Confirm")
$no  = new-object $typename("&No", "Abort")

# create choice collection
$assembly= $yes.getType().AssemblyQualifiedName
$choice = new-object "System.Collections.ObjectModel.Collection``1[[$assembly]]"
$choice.add($yes)
$choice.add($no)

# display choice prompt
Write-Host "#############################" -ForegroundColor Yellow -BackgroundColor Black
Write-Host "#####      WARNING      #####" -ForegroundColor Yellow -BackgroundColor Black
Write-Host "#############################" -ForegroundColor Yellow -BackgroundColor Black
Write-Host "This script creates New Python virtual environment in '${SPHINX_VENV_PATH}'. " -ForegroundColor Red -BackgroundColor Black
$answer = $host.ui.PromptForChoice("Execution confirmation", "Do you want to run it?", $choice, 1)

if ($answer -eq 1) {
    exit
}

##################################################
# install Scoop
##################################################

try {
    # Check Scoop
    get-command scoop -ErrorAction Stop
} 
catch [Exception] {
    # Install Scoop
    Write-Host "install scoop!!" -ForegroundColor Green
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

try {
    # install basic module
    scoop install aria2
    try {
        # Check Git
        get-command git -ErrorAction Stop
        Write-Host "git command Exists!!" -ForegroundColor Yellow
    } 
    catch [Exception] {
        # Install Git
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
        # Check Python3
        get-command python3 -ErrorAction Stop
        $py3_command = 'python3'
    }
    catch [Exception] {
        try {
            # Check Python
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
        # Install Python37
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

    # *** After that, execute it in the virtual environment(venv) ***

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
    pip install sphinxcontrib-svg2pdfconverter

    # for `.ipynb`
    pip install ipython
    pip install nbsphinx
    try {
        # Check pandoc
        get-command pandoc -ErrorAction Stop
        Write-Host "pandoc command Exists!!" -ForegroundColor Yellow
    } 
    catch [Exception] {
        # Install pandoc
        Write-Host "install pandoc!!" -ForegroundColor Green
        scoop install pandoc
    }

    # install latex for pdf output
    try {
        # Check latex
        get-command latex -ErrorAction Stop
        Write-Host "latex command Exists!!" -ForegroundColor Yellow
    } 
    catch [Exception] {
        # Instal latex
        Write-Host "install latex!!" -ForegroundColor Green
        scoop install latex
    }
    try {
        # Check perl
        get-command perl -ErrorAction Stop
        Write-Host "perl command Exists!!" -ForegroundColor Yellow
    } 
    catch [Exception] {
        # Install perl
        Write-Host "install perl!!" -ForegroundColor Green
        scoop install perl
    }
    try {
        # Check inkscape
        get-command inkscape -ErrorAction Stop
        Write-Host "inkscape command Exists!!" -ForegroundColor Yellow
    } 
    catch [Exception] {
        # install inkscape
        Write-Host "install inkscape!!" -ForegroundColor Green
        scoop install inkscape
    }
}
catch [Exception] {
    $error[0] | Format-List -force
}
