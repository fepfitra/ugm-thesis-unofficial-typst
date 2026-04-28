#!/bin/bash
set -e

PDF="main.pdf"
OUTDIR="./docs"
README="README.md"

if [ ! -f "$PDF" ]; then
    echo "Error: $PDF not found!"
    exit 1
fi

mkdir -p "$OUTDIR"

echo "Converting $PDF to images..."
# Use pdftoppm to convert each page to PNG, prefix with page number
pdftoppm -png -r 200 "$PDF" "$OUTDIR/page"

echo "Updating $README..."
# Append header only once if not already present
if ! grep -q "<!-- Generated PDF Preview -->" "$README"; then
    cat >> "$README" << 'EOF'

---

<!-- Generated PDF Preview -->
## Preview

EOF
fi

# For each generated image, add markdown link if not already present
for img in $(ls -1 "$OUTDIR"/page-*.png | sort -V); do
    filename=$(basename "$img")
    if ! grep -q "$filename" "$README"; then
        echo "![$filename]($img)" >> "$README"
        echo "" >> "$README"
    fi
done

echo "Done! Images saved to $OUTDIR and linked in $README."
