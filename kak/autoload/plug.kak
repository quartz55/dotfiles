decl str plug_dir ".local/share/kakplug"

def -hidden -allow-override plug-setup %{
    %sh{
        printf "%s\n" "echo -debug [plug]: Main directory: '$HOME/${kak_opt_plug_dir}'"
        [ ! -d "$HOME/${kak_opt_plug_dir}" ] && mkdir -p "$HOME/${kak_opt_plug_dir}"
        [ ! -d "$HOME/${kak_opt_plug_dir}/plugins" ] && mkdir -p "$HOME/${kak_opt_plug_dir}/plugins"
    }
}

def plug -params 1 \
  -docstring "Install and use specified plugin from Git" \
  -allow-override %{
    plug-setup
    %sh{
        readonly PLUGINS_DIR="$HOME/${kak_opt_plug_dir}/plugins"
        readonly PLUGIN_NAME="${1##*/}"
        readonly PLUGIN_DIR="${PLUGINS_DIR}/${PLUGIN_NAME}"

        # Download if first time
        if [ ! -d "${PLUGIN_DIR}" ]; then
            printf "echo -debug [plug]: Downloading plugin '%s'\n" "${1}"
            git clone --depth 1 https://github.com/"${1}" "${PLUGIN_DIR}" >/dev/null 2>&1
        fi

        # Check for rc folder
        if [ -d "${PLUGIN_DIR}/rc" ]; then SRC_DIR="${PLUGIN_DIR}/rc"
        else SRC_DIR="${PLUGIN_DIR}"; fi

        for file in $(find "${SRC_DIR}" -type f -name '*.kak'); do
            printf "echo -debug [plug]: Sourcing '%s' from '%s'\n" "${file##*/}" "${1}"
            printf "source %s\n" ${file}
        done
    }
}
