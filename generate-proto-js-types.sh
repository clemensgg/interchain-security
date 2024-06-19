#!/bin/bash

PROTO_DIR="./proto"
DEP_DIR="$HOME/go/pkg/mod"
OUT_DIR="./generated"

# Create the output directory if it doesn't exist
mkdir -p $OUT_DIR

# Find all .proto files in the PROTO_DIR and generate JS and TS files for each one
find $PROTO_DIR -name "*.proto" | while read -r proto_file; do
    base_name=$(basename "$proto_file" .proto)
    out_js="$OUT_DIR/$base_name.js"
    out_ts="$OUT_DIR/$base_name.d.ts"

    # Generate JS and TS files
    pbjs -t static-module -w commonjs -o "$out_js" "$proto_file" --path "$DEP_DIR" --path "$DEP_DIR/github.com" --path "$DEP_DIR/google.golang.org" --path "$DEP_DIR/cosmossdk.io"
    pbts -o "$out_ts" "$out_js"
done

echo "Generation complete."
