# Build Sphinx Environment Using Scoop

Build Sphinx environment using windows package management tool `scoop`.  
This script does these processes.

1. install Scoop
1. install Python37 (using scoop)
1. install Sphinx
    - install theme (sphinx_rtd_theme)
    - install some extentions
    - install pandoc, latex, perl (using scoop)
1. create sphinx document project template

## Quick start

1. Clone this repository.
1. Change some parameters in `create_sphinx_env.ps1` and save.

    ```powershell:
    # python venv path for sphinx
    # this script create new python venv!!
    $SPHINX_VENV_PATH='c:\venv\sphinx'

    # sphinx document root directory
    $SPHINX_DOC_PATH='c:\sphinx_doc'

    # sphinx project settings
    $PROJECT_NAME='your_project'
    $AUTHOR_NAME='your_name'
    $RELEASE_VERSION='1.0.0'
    ```

1. Open `PowerShell`
1. Run this command to change policy.  

    ```powershell:
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    ```

    if display some message, input `y` and `enter`.

1. Run script `create_sphinx_env.ps1`

1. Copy `sample_conf.py` to `$SPHINX_DOC_PATH/source` and rename to `conf.py`

1. Enjoy Sphinx!!!  
    ex.)  

    ```powershell:
    ./make html
    ./make latexpdf
    ```
