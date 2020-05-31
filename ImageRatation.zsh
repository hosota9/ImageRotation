#!/bin/zsh
# ------------------------------------------------------
# ImageRotation.zsh
#   EXIF情報を元に画像自体を回転するシェル.
#   カレントディレクトリ内のJPEGファイルを対象に処理する.
# ------------------------------------------------------
function ImageRotation() {

  # ディレクトリ内のJPEGファイル数を取得
  cntAll=`ls -U1 *.jpg | wc -l | tr -d ' '`

  # 各ファイルのOrientationを取得
  cntNow="0"
  for file in *.jpg
  do
    cntNow=`echo $(( $cntNow + 1 ))`
    orientation=`exiftool $file | grep Orientation | awk -F": " '{print $2}'`
    echo "$file ($cntNow/$cntAll) : $orientation" 

    # orientationが"Rotate 90 CW"の場合、画像回転
    if [ "$orientation" = "Rotate 90 CW" ]; then
      echo "  -> 回転処理を行います."

      # 画像自体を回転
      echo "  -> sips -r 90 $file"
      sips -r 90 "$file"

      # 回転情報の削除
      echo "  -> exiftool -Orientation=1 -n -overwrite_original $file"
      exiftool -Orientation=1 -n -overwrite_original "$file"
    fi

    # orientationが"Rotate 180"の場合、画像回転
    if [ "$orientation" = "Rotate 180" ]; then
      echo "  -> 回転処理を行います."

      # 画像自体を回転
      echo "  -> sips -r 180 $file"
      sips -r 180 "$file"

      # 回転情報の削除
      echo "  -> exiftool -Orientation=1 -n -overwrite_original $file"
      exiftool -Orientation=1 -n -overwrite_original "$file"
    fi

    # orientationが"Rotate 270 CW"の場合、画像回転
    if [ "$orientation" = "Rotate 270 CW" ]; then
      echo "  -> 回転処理を行います."

      # 画像自体を回転
      echo "  -> sips -r 270 $file"
      sips -r 270 "$file"

      # 回転情報の削除
      echo "  -> exiftool -Orientation=1 -n -overwrite_original $file"
      exiftool -Orientation=1 -n -overwrite_original "$file"
    fi

  done
}

ImageRotation $@
