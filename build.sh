#!/usr/bin/env bash

set -u

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src_dir="$project_dir/src"
bin_dir="$project_dir/bin"
compiler="${CXX:-g++}"

mkdir -p "$bin_dir"

status=0
for source in "$src_dir"/*.cpp; do
    [[ -e "$source" ]] || {
        echo "Nessun file .cpp trovato in $src_dir" >&2
        exit 1
    }

    executable="$bin_dir/$(basename "${source%.cpp}")"
    echo "Compilo $(basename "$source")..."
    if "$compiler" -std=c++17 -Wall -Wextra -pedantic "$source" -o "$executable"; then
        echo "  -> $executable"
    else
        echo "Errore durante la compilazione di $(basename "$source")" >&2
        status=1
    fi
done

exit "$status"
