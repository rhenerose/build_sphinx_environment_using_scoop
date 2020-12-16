# sphinxのドキュメントディレクトリ
$SPHINX_DOC_PATH='./your_project'

# sphinxのプロジェクト設定
$PROJECT_NAME='your_project'
$AUTHOR_NAME='your_name'
$RELEASE_VERSION='1.0.0'

##################################################
# create sphinx document project directory
##################################################
mkdir ${SPHINX_DOC_PATH}
cd ${SPHINX_DOC_PATH}

# create template project
# 必要に応じてオプションの project, author, release を変更してください
sphinx-quickstart --sep --project=${PROJECT_NAME} --author=${AUTHOR_NAME} --release=${RELEASE_VERSION} --language='ja'
