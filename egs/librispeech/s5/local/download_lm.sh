#!/usr/bin/env bash

# Copyright 2014 Vassil Panayotov
# Apache 2.0

if [ $# -ne "2" ]; then
  echo "Usage: $0 <base-url> <download_dir>"
  echo "e.g.: $0 http://www.openslr.org/resources/11 data/local/lm"
  exit 1
fi

base_url=$1
dst_dir=$2

# given a filename returns the corresponding file size in bytes
# The switch cases below can be autogenerated by entering the data directory and running:
# for f in *; do echo "\"$f\") echo \"$(du -b $f | awk '{print $1}')\";;"; done
function filesize() {
  case $1 in
    "3-gram.arpa.gz") echo "759636181";;
    "3-gram.pruned.1e-7.arpa.gz") echo "34094057";;
    "3-gram.pruned.3e-7.arpa.gz") echo "13654242";;
    "4-gram.arpa.gz") echo "1355172078";;
    "g2p-model-5") echo "20098243";;
    "librispeech-lexicon.txt") echo "5627653";;
    "librispeech-lm-corpus.tgz") echo "1803499244";;
    "librispeech-lm-norm.txt.gz") echo "1507274412";;
    "librispeech-vocab.txt") echo "1737588";;
    *) echo "";;
  esac
}

function check_and_download () {
  [[ $# -eq 1 ]] || { echo "check_and_download() expects exactly one argument!"; return 1; }
  fname=$1
  echo "Downloading file '$fname' into '$dst_dir'..."
  expect_size="$(filesize $fname)"
  [[ ! -z "$expect_size" ]] || { echo "Unknown file size for '$fname'"; return 1; }
  if [[ -s $dst_dir/$fname ]]; then
    # In the following statement, the first version works on linux, and the part
    # after '||' works on Linux.
    f=$dst_dir/$fname
    fsize=$(set -o pipefail; du -b $f 2>/dev/null | awk '{print $1}' || stat '-f %z' $f)
    if [[ "$fsize" -eq "$expect_size" ]]; then
      echo "'$fname' already exists and appears to be complete"
      return 0
    else
      echo "WARNING: '$fname' exists, but the size is wrong - re-downloading ..."
    fi
  fi
  wget --no-check-certificate -O $dst_dir/$fname $base_url/$fname || {
    echo "Error while trying to download $fname!"
    return 1
  }
  f=$dst_dir/$fname
  # In the following statement, the first version works on linux, and the part after '||'
  # works on Linux.
  fsize=$(set -o pipefail; du -b $f 2>/dev/null | awk '{print $1}' || stat '-f %z' $f)
  [[ "$fsize" -eq "$expect_size" ]] || { echo "$fname: file size mismatch!"; return 1; }
  return 0
}

mkdir -p $dst_dir

for f in 3-gram.arpa.gz 3-gram.pruned.1e-7.arpa.gz 3-gram.pruned.3e-7.arpa.gz 4-gram.arpa.gz \
         g2p-model-5 librispeech-lm-corpus.tgz librispeech-vocab.txt librispeech-lexicon.txt; do
  check_and_download $f || exit 1
done

cd $dst_dir
ln -sf 3-gram.pruned.1e-7.arpa.gz lm_tgmed.arpa.gz
ln -sf 3-gram.pruned.3e-7.arpa.gz lm_tgsmall.arpa.gz
ln -sf 3-gram.arpa.gz lm_tglarge.arpa.gz
ln -sf 4-gram.arpa.gz lm_fglarge.arpa.gz

exit 0
