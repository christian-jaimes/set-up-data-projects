@echo off
setlocal enabledelayedexpansion

set "base_dir=%cd%"
set /p projectName="Project name: "
mkdir "%base_dir%\%projectName%"
cd "%base_dir%\%projectName%"

:FolderCreation
set "folders=archive data data\raw data\processed data\cleaned docs img python utils"

REM Git configuration
set /p folderCreation="Create folder structure? (y/n): "

if /i "%folderCreation%"=="y" (
    REM List of folders to create


    REM Creating the folders
    for %%f in (%folders%) do (
        mkdir "%%f" 2>nul
        )

    echo. > "README.md"
) else if /i "%folderCreation%"=="n" (
    goto GitInit
) else (
    echo Invalid input. Please enter 'y' or 'n'.
    goto :FolderCreation
)

:GitInit
set /p gitInit="Initialize Git? (y/n): "
if /i "%gitInit%"=="y" (
    git init
) else if /i "%gitInit%"=="n" (
    goto GitConfiguration
) else (
    echo Invalid input. Please enter 'y' or 'n'.
    goto :GitInit
)

:GitConfiguration
set /p configureGit="Configure Git locally? (y/n): "

if /i "%configureGit%"=="y" (
    REM Git username
    set /p gitUsername="Enter your Git username: "
    REM Git email
    set /p gitEmail="Enter your Git email: "

    REM Create the .gitconfig file
    (
        echo [user]
        echo    name = !gitUsername!
        echo    email = !gitEmail!
        echo [core]
        echo    editor = code --wait
        echo    autocrlf = true
        echo [init]
        echo    defaultBranch = main
        echo [difftool "vscode"]
        echo    cmd = code --wait --diff $LOCAL $REMOTE
        echo [alias]
        echo    gl = log --oneline --graph
    ) > ".gitconfig"

) else if /i "%configureGit%"=="n" (
    goto GitIgnoreCreation
) else (
    echo Invalid input. Please enter 'y' or 'n'.
    goto :GitConfiguration
)

:GitIgnoreCreation
set /p configureGitIgnore="Create .gitignore? (y/n): "

if /i "%configureGitIgnore%"=="y" (
    REM Create the .gitignore file with some common exclusions
    (
        echo .*
        echo ~*
        echo _*
        echo -*
        echo data/
    ) > ".gitignore"
    REM echo .gitignore file created successfully.
) else if /i "%configureGitIgnore%"=="n" (
    goto OpenVScode
) else (
    echo Invalid input. Please enter 'y' or 'n'.
    goto :GitIgnoreCreation
)

:OpenVScode
set /p openVScode="Open vscode? (y/n): "

if /i "%openVScode%"=="y" (
    code "%base_dir%\%projectName%"
    REM echo Opening Visual Studio code at "%base_dir%"

) else if /i "%openVScode%"=="n" (
    goto CloseTerminal
) else (
    echo Invalid input. Please enter 'y' or 'n'.
    goto :OpenVScode
)

:CloseTerminal
set /p closeTerminal="Close the terminal? (y/n): "

if /i "%closeTerminal%"=="y" (
    exit
) else if /i "%closeTerminal%"=="n" (
    cmd /k
) else (
    echo Invalid input. Please enter 'y' or 'n'.
    goto :CloseTerminal
)