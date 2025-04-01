{
  paths ? [ ],
  program,

  pkgsStatic,
  closureInfo,
  writeScript,
  runCommand,

  bash,
  nix,
}:

let
  bwrap = pkgsStatic.bubblewrap;
  script = writeScript "script" ''
    #!${bash}/bin/bash
    set -eu
    NIX_STATE_DIR=/nix/var/nix ${nix}/bin/nix-store --load-db < $1
    unset ENV_LINE
    unset ENV_DIR
    exec ${program}/bin/${program.meta.mainProgram}
  '';

  closure = closureInfo {
    rootPaths = paths ++ [
      program
      bwrap
      nix
      bash
      script
    ];
  };
  tarball = runCommand "env.tar.gz" { } ''
    cat ${closure}/store-paths | xargs tar czvf $out
  '';
in
runCommand "env" { } ''
  cat > $out <<EOF
  #!/usr/bin/env bash
  set -eu
  ENV_LINE=\$(awk '/^__CLOSURE__/ { print NR + 1 }' \''${BASH_SOURCE[0]})
  ENV_DIR=\$(mktemp -d)
  tail -n +\$ENV_LINE \''${BASH_SOURCE[0]} | tar xzf - -C \$ENV_DIR
  echo "$(cat ${closure}/registration)" > \$ENV_DIR/registration
  exec \$ENV_DIR${bwrap}/bin/bwrap \\
    --unshare-user \\
    --dev-bind / / \\
    --bind \$ENV_DIR/nix /nix \\
    ${script} \$ENV_DIR/registration
  __CLOSURE__
  EOF

  cat ${tarball} >> $out
  chmod +x $out
''
