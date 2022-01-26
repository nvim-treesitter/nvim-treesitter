#!/usr/bin/env bash

DEBUG=

function debug() {
  if [[ -n "${DEBUG}" ]]; then
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*"
  fi
}

################################################################################
# Get the abi version number from a github remote
# Arguments:
#   Repo to be queried, e.g "elm-tooling/tree-sitter-elm"
# Outputs:
#   Writes the version number to stdout
################################################################################
function get_abi_version() {
  local repo="$1"
  local tree_path="repos/${repo}/contents/src"
  echo "checking $repo at $tree_path"
  gh api "${tree_path}" --jq '.[] | select(.name="parser.c").download_url' \
    | xargs curl -LSs \
    | grep -oP "define LANGUAGE_VERSION \K(\d+)" >&2
}

################################################################################
# Update the abi version number for all applicable parsers
# Arguments:
#   lockfile path
# Outputs:
#   None
################################################################################
function update_all_abi() {
  local -A list=()
  local lockfile="${1:-lockfile.json}"
  local repo abi_version temp
  temp="$(mktemp)"

  while IFS=$" " read -r parser url; do
    repo=$(echo "${url}" | sed s"#https://github.com/##"g)
    echo "fetching $parser at: $repo"
    if [[ -n "${repo}" ]]; then
      abi_version=$(gh api "repos/${repo}/contents/src" --jq '.[] | select(.name="parser.c").download_url' \
        | xargs curl -LSs \
        | grep -oP "define LANGUAGE_VERSION \K(\d+)")

      list+=(["${parser}"]=${abi_version})
    fi
  done < <(
    jq -r '
    to_entries[]
    | [ .key, (.value.url) ]
    | join(" ")
    ' "${lockfile}"
  )

  for parser in "${!list[@]}"; do
    local version=${list[$parser]}
    debug "$parser ${version}"
    if [[ -z ${version} ]]; then
      continue;
    fi
    jq ".${parser}.abi=${version}" "${lockfile}" >"${temp}"
    mv "${temp}" "${lockfile}"
  done
}

if [[ -n "$1" ]]; then
  get_abi_version "$@"
else
  update_all_abi "lockfile.json"
fi
