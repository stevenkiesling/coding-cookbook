#!/bin/sh
set -e

main() {
	if [ -z "$1" ]; then
    echo "No destination dir provided"
    exit 1
  fi
	DEST="$1"

  mkdir -p "$DEST"
  DEST=$(readlink -f "$DEST")
  echo "=== destination directory: $DEST"

  TMPDIR=$(mktemp -d -t tmp.XXXXXXXXXX)

  echo $(date) : "=== Using tmpdir: $TMPDIR"

  echo "=== Copy HeatMap files"
	CWD="$PWD"
  cp setup.py "$TMPDIR"
  cp MANIFEST.in "$TMPDIR"
  cp LICENSE "$TMPDIR"
  rsync -avm -L --exclude='*_test.py' --exclude='cpp' --exclude='.vscode' heatmap "$TMPDIR"

  cd "$TMPDIR"
  echo $(date) : "=== Building wheel"

  python setup.py bdist_wheel > /dev/null

  cp dist/*.whl "$DEST"
  cd "$CWD"
  rm -rf "$TMPDIR"
  echo $(date) : "=== Output wheel file is in: $DEST"
}

main "$@"
