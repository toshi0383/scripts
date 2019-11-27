#!/bin/bash
#
# name:
#   sync-file.sh
#
# description:
#   指定されたディレクトリとカレントディレクトリの構成を、指定された1ファイルに対してのみ同期します.
#   指定されたファイルパスが見つからない場合、ファイル名として扱い `find` をかけます.
#   ディレクトリ階層がカレントディレクトリになければ `mkdir` します.
#
# parameters:
#   1: 同期したいディレクトリ
#   2: 同期したいファイルパス
#
# author:
#   鈴木 俊裕
#
# since:
#   2017-06-23
#   2019-11-27 copied
#
# copyright:
#   Copyright © 2017年 Abema TV, Inc. All rights reserved.
#   Copyright © 2019年 Toshihiro Suzuki All rights reserved.
#
ORIGIN_DIR=${1:?}
FILE_PATH=${2:?}

TARGET="${ORIGIN_DIR}/${FILE_PATH}"

if [ -d "$TARGET" -o -f "$TARGET" ]
then
    target_path="${TARGET}"
    destination="${FILE_PATH}"
else
    target_path=$(find ${ORIGIN_DIR} -name ${FILE_PATH})
    destination=$(echo ${target_path} | sed "s?${ORIGIN_DIR}/??")
fi

PARENT_DIR=$(dirname "${destination}")
if [ ! -d "${PARENT_DIR}" ]
then
    mkdir -p "${PARENT_DIR}"
fi

cp -R "${target_path}" "${PARENT_DIR}"
