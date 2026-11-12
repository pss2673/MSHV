# MSHV Section 2 UTC Date/Time Filter — Windows 11 build

This branch adds an optional inclusive UTC interval to the Text Highlight dialog's Section 2 log-history rules.

## User interface

In **Text Highlight → Section 2**, check **Limit Section 2 QSO history to a UTC date/time range**, and set Start and End times in UTC. The fields are interpreted as UTC even when Windows is in a different time zone.

Only QSOs whose **start** timestamp falls inside the interval can mark a callsign/grid as worked. The same interval applies to the Section 2 QSO-B4 warning. Existing By Band and By Mode rules remain active. The Section 1 text rules and Section 2 transmitted-message/QSY-message colors are not historical log queries and are unchanged.

The filter defaults to **off** to maintain the original behavior. Settings are saved using a separate `section2_time_range` key in the existing `ms_settings` format.

## Windows 11 GitHub Actions builds

Open the repository **Actions** tab, select **MSHV Windows 11 x64 installer**, and inspect the branch build. On success, download the artifact `MSHV-Section2-UTC-Windows-x64`.

The build uses MSYS2 MinGW-w64 Qt 5, plus the included Windows DirectSound/FFTW static libraries. It packages the Qt shared libraries and the application `bin` data. The artifact contains a portable ZIP and an NSIS setup EXE.

The setup installs per-user at `%LOCALAPPDATA%\Programs\MSHV-Section2-UTC` so MSHV can write logs/settings without administrator rights. **Backup your logs and settings before replacing an existing MSHV installation.** Its uninstaller intentionally leaves user data folders.

## Testing checklist

1. Confirm Windows 11 x64 launch and Qt plugin initialization.
2. Select a time range containing one logged QSO and confirm its callsign/grid is marked worked.
3. Select a range excluding the QSO and confirm its callsign/grid is not marked worked.
4. Check By Band and By Mode still apply.
5. Confirm start/end boundaries are inclusive.
6. Confirm turning off the filter restores the full history.
7. Restart MSHV and confirm interval persistence.
8. Confirm Section 1 highlight and message/QSY colors are unaffected.

**Status:** Source is prepared for CI compilation; a successful Actions run and an on-device smoke test are still required before this should be treated as a verified installer.
