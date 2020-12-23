# Build Sphinx Environment Using Scoop

Build Sphinx environment using windows package management tool `scoop`.  
This script does these processes.

1. install Scoop
1. install Python37 (using scoop)
1. create python venv and activate
1. install Sphinx
    - install theme (sphinx_rtd_theme)
    - install some extentions
    - install pandoc, latex, perl (using scoop)
1. create sphinx document project template

## Requirements

- Windows 7 SP1+ / Windows Server 2008+
- PowerShell 5 (or later, include PowerShell Core) and .NET Framework 4.5 (or later)
- PowerShell must be enabled for your user account  
    e.g. `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

## Quick start

Run following command in PowerShell.

```powershell
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/rhenerose/build_sphinx_environment_using_scoop/main/create_sphinx_env.ps1')
```

## How to use

1. Clone this repository.
1. Change some parameters in `create_sphinx_env.ps1` and save.

    ```powershell
    # python venv path for sphinx
    # WARNNING: This script create new python venv!!
    $SPHINX_VENV_PATH='c:\venv\sphinx'
    ```

1. Open `PowerShell`
1. Run the following command to change policy.  

    ```powershell
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    ```

    if display some message, input `y` and `enter`.

1. Run script `create_sphinx_env.ps1`.

1. Change directory `./sample_project` and activate venv.

1. Enjoy Sphinx!!!  
    e.g.

    ```powershell
    c:/venv/sphinx/script/activate.ps1
    ./make html
    ./make latexpdf
    ```
