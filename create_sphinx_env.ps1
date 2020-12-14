# sphinx用のPython仮想環境のパス
$SPHINX_VENV_PATH='c:\venv\sphinx'
# sphinxのドキュメントディレクトリ
$SPHINX_DOC_PATH='c:\sphinx_doc'

# sphinxのプロジェクト設定
$PROJECT_NAME='your_project'
$AUTHOR_NAME='your_name'
$RELEASE_VERSION='1.0.0'

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
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

try {
    # install basic module
    scoop install aria2
    scoop install git

    # add bucket
    scoop bucket add extras
    scoop bucket add versions

    ##################################################
    # install Python
    ##################################################
    scoop install python37

    # create venv
    python37 -m venv ${SPHINX_VENV_PATH}
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
    scoop install pandoc

    # install latex for pdf output
    scoop install latex
    scoop install perl




    ##################################################
    # create sphinx document project directory
    ##################################################
    mkdir ${SPHINX_DOC_PATH}
    cd ${SPHINX_DOC_PATH}

    # create template project
    # 必要に応じてオプションの project, author, release を変更してください
    sphinx-quickstart --sep --project=${PROJECT_NAME} --author=${AUTHOR_NAME} --release=${RELEASE_VERSION} --language='ja'


}
catch [Exception] {
    $error[0] | Format-List -force
}