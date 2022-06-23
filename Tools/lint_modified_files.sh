# Support for binaries installed via Homebrew on Apple Silicon
# https://github.com/realm/SwiftLint/issues/2992
if test -d "/opt/homebrew/bin/"; then
  PATH="/opt/homebrew/bin/:${PATH}"
fi

BNPP_SWIFTLINT_LOCATION="${HOME}/Applications/swiftlint"
SWIFTLINT=$(which swiftlint)

if which $BNPP_SWIFTLINT_LOCATION >/dev/null; then
    SWIFTLINT=$BNPP_SWIFTLINT_LOCATION
fi

if which $SWIFTLINT >/dev/null; then
    count=0
    
    for file_path in $(git ls-files -om --exclude-from=.gitignore | grep ".swift$"); do
        export SCRIPT_INPUT_FILE_$count=$file_path
        count=$((count + 1))
    done
    
    for file_path in $(git diff --cached --name-only | grep ".swift$"); do
        export SCRIPT_INPUT_FILE_$count=$file_path
        count=$((count + 1))
    done
    
    export SCRIPT_INPUT_FILE_COUNT=$count

    if (( $count > 0 )); then
        $SWIFTLINT lint --use-script-input-files
        echo "${count} file(s) linted"
    else
        echo "No file to lint"
    fi
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    exit 1
fi

