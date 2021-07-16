
# 프로젝트 생성
PROJECT_NAME=$1
PACKAGE_NAME=$2

# root
mkdir $PROJECT_NAME

# root/README.md
README_CONTENT=(
    "$PROJECT_NAME"
    "<프로젝트 간략한 설명>\n"
    "# Development"
    '```bash'
    "# (필요시) 가상환경 생성"
    "$ python -m venv venv"

    "# 가상환경 활성화"
    "$ source ./venv/bin/activate"

    "# 개발 패키지 로컬 설치 (의존성 같이 설치됨)"
    '$ pip install -e ".[dev]"'

    "# 유닛 테스트 실행"
    "$ python setup.py test"

    "# cli 실행"
    "$ $PACKAGE_NAME"
    '```'
)
touch $PROJECT_NAME/README.md
for line in "${README_CONTENT[@]}"; do
    echo $line >> $PROJECT_NAME/README.md
done

# root/.gitignore
touch $PROJECT_NAME/.gitignore
echo """# build
dist
*.egg-info
.eggs
# venv
venv
# cache
__pycache__""" > $PROJECT_NAME/.gitignore

# root/requirements
mkdir $PROJECT_NAME/requirements
touch $PROJECT_NAME/requirements/base.txt
echo "click" > $PROJECT_NAME/requirements/base.txt
touch $PROJECT_NAME/requirements/dev.txt
touch $PROJECT_NAME/requirements/test.txt
echo "pytest" > $PROJECT_NAME/requirements/test.txt

# root/setup.py
# TODO: Add pyproject.toml
# what is pyproject.toml?
# see: https://stackoverflow.com/questions/62983756/what-is-pyproject-toml-file-for
touch $PROJECT_NAME/setup.py

cat <<EOF > $PROJECT_NAME/setup.py
from setuptools import find_packages, setup

install_requires = open("./requirements/base.txt").read().strip().split("\n")
dev_requires = open("./requirements/dev.txt").read().strip().split("\n")
test_requires = open("./requirements/test.txt").read().strip().split("\n")

extras = {
    "dev": dev_requires + test_requires,
}

extras["all_extras"] = sum(extras.values(), [])

setup(
    name="$PACKAGE_NAME",
    version='0.1.0',
    description="<패키지에 대한 간략한 설명>",
        author="<코드 작성자>",
    author_email="<작성자 이메일>",
    url="<git 저장소 주소>",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    entry_points={
        'console_scripts': [
            '$PACKAGE_NAME = $PACKAGE_NAME.scripts.$PACKAGE_NAME:main',
            ],
        },
    python_requires=">=3.7, <4.0",
    install_requires=install_requires,
    extras_require=extras,
    setup_requires=['pytest-runner']
)

EOF

# root/setup.cfg
cat <<EOF > $PROJECT_NAME/setup.cfg
[flake8]
ignore = F401

[aliases]
test = pytest

[tool:pytest]
addopts = --verbose
EOF

# src
mkdir $PROJECT_NAME/src
mkdir $PROJECT_NAME/src/$PACKAGE_NAME
mkdir $PROJECT_NAME/src/$PACKAGE_NAME/scripts
touch $PROJECT_NAME/src/$PACKAGE_NAME/scripts/$PACKAGE_NAME.py
echo "def main():\n  return \"main script\"" > $PROJECT_NAME/src/$PACKAGE_NAME/scripts/$PACKAGE_NAME.py
touch $PROJECT_NAME/src/$PACKAGE_NAME/__init__.py
touch $PROJECT_NAME/src/$PACKAGE_NAME/main.py
echo "def main():\n  return \"main func\"" > $PROJECT_NAME/src/$PACKAGE_NAME/main.py

# tests
mkdir $PROJECT_NAME/tests
touch $PROJECT_NAME/tests/test_main.py
echo "from $PACKAGE_NAME.main import main\n\ndef test_main():\n  assert main() == 'main func'" \
    > $PROJECT_NAME/tests/test_main.py


# welcome
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
echo "${red}Created project named: ${green}$PROJECT_NAME${reset}"
echo "${red}Please read ${green}README.md"
