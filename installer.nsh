﻿!define INSTALL_DIR "$LOCALAPPDATA\${PRODUCT_NAME}"
!define INSTALL_ICON_PATH "$LOCALAPPDATA\${MUI_ICON}"

# Modern UI
!include MUI2.nsh
# nsDialogs
!include nsDialogs.nsh
# LogicLib
!include LogicLib.nsh

# アプリケーション名
Name "${PRODUCT_NAME}"

BrandingText "${PRODUCT_NAME} v${VERSION}"

# 作成されるインストーラ
OutFile "Install.exe"

# インストールされるディレクトリ
InstallDir "${INSTALL_DIR}"

# アイコン
Icon "${MUI_ICON}"
UninstallIcon "${MUI_ICON}"

# ページ
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE LICENSE.txt
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "Japanese"

# デフォルト セクション
Section
    # 出力先を指定します。
    SetOutPath "$INSTDIR"

    # インストールされるファイル
    File /r "${PUBLISH_DIR}\\*.*"
    File "${MUI_ICON}"

    # アンインストーラを出力
    WriteUninstaller "$INSTDIR\\Uninstall.exe"

    # スタート メニューにショートカットを登録
    CreateDirectory "$SMPROGRAMS\\${PRODUCT_NAME}"
    SetOutPath "$INSTDIR"
    CreateShortcut "$SMPROGRAMS\\${PRODUCT_NAME}\\${PRODUCT_NAME}.lnk" "$INSTDIR\\${EXEC_FILE}" "" "$INSTDIR\${PRODUCT_NAME}.exe,0"

    # レジストリに登録
    WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_NAME}" "DisplayName" "${PRODUCT_NAME}"
    WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_NAME}" "UninstallString" '"$INSTDIR\Uninstall.exe"'
    WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_NAME}" "Publisher" "${PUBLISHER}"
    WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_NAME}" "DisplayIcon" "$INSTDIR\${PRODUCT_NAME}.exe,0"
    WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_NAME}" "DisplayVersion" "${VERSION}"
    WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_NAME}" "InstallDate" "${DATE}"
    WriteRegDWORD HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_NAME}" "EstimatedSize" "${SIZE}"
SectionEnd

# アンインストーラ
Section "Uninstall"
    # アンインストーラを削除
    Delete "$INSTDIR\\Uninstall.exe"

    # ファイルを削除
    Delete "$INSTDIR\\${EXEC_FILE}"

    # ディレクトリを削除
    RMDir /r "$INSTDIR"

    # スタート メニューから削除
    Delete "$SMPROGRAMS\\${PRODUCT_NAME}\\${PRODUCT_NAME}.lnk"
    RMDir "$SMPROGRAMS\\${PRODUCT_NAME}"

    # レジストリ キーを削除
    DeleteRegKey HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_NAME}"
SectionEnd