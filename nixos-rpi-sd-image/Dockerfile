FROM multiarch/qemu-user-static:x86_64-aarch64 as qemu

FROM nixos/nix

COPY --from=qemu /usr/bin/qemu-aarch64-static /usr/bin

RUN \
  set -e; \
  echo 'extra-platforms = aarch64-linux' >> /etc/nix/nix.conf; \
  nix-env -f https://github.com/nix-community/nixos-generators/archive/450f39121c45b93951c52874fe233455d007d3bc.tar.gz -i;

COPY . /

CMD ["/generate-sd-image.sh"]
