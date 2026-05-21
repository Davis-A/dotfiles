function sv --wraps sv --description 'runit sv with git-style sv-<x> subcommand plugins'
    set -l builtins status up down once pause cont hup alarm interrupt quit \
        term kill exit start stop reload restart shutdown force-stop \
        force-reload force-restart force-shutdown try-restart check 1 2
    if test (count $argv) -ge 1
        and not contains -- $argv[1] $builtins
        and type -q sv-$argv[1]
        sv-$argv[1] $argv[2..-1]
        return
    end
    command sv $argv
end
