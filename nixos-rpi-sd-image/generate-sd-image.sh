#!/bin/sh

set -e

/root/.nix-profile/bin/nixos-generate \
  --format sd-aarch64-installer \
  --system aarch64-linux \
  --configuration /sd-image.nix \
    | tee /nixos-generate-output.txt

ARTIFACT="$(tail -1 /nixos-generate-output.txt)"

if echo $ARTIFACT | grep -q -E 'hydra-build-products$'
then
  IMG="$(head -1 $ARTIFACT | awk '{ print $3 }')"
else
  IMG=$ARTIFACT
fi

echo "Found img file: $IMG"

mkdir -p /output
cp $IMG /output/
