#!/bin/zsh
# ------------------------------------------------------
# ImageRotation.zsh
#   EXIF情報を元に画像自体を回転するシェル.
#   カレントディレクトリ内のJPEGファイルを対象に処理する.
# ------------------------------------------------------
function ImageRotation() {

  # ---------------------------------------------------
  # 画像回転処理
  # ---------------------------------------------------
  rotate() {
      echo "  -> 回転処理を行います."

      # 画像自体を回転
      echo "  -> sips -r $1 $2"
      sips -r "$1" "$2"

      # 回転情報の削除
      echo "  -> exiftool -Orientation=1 -n -overwrite_original $2"
      exiftool -Orientation=1 -n -overwrite_original "$2"
  }

  # ---------------------------------------------------
  # メイン処理
  # ---------------------------------------------------
  # ディレクトリ内のJPEGファイル数を取得
  cntAll=`ls -U1 *.jp*g | wc -l | tr -d ' '`

  # 各ファイルのOrientationを取得
  cntNow="0"
  for file in *.jp*g
  do
    cntNow=`echo $(( $cntNow + 1 ))`
    orientation=`exiftool $file | grep Orientation | awk -F": " '{print $2}'`
    echo "$file ($cntNow/$cntAll) : $orientation" 

    # orientationに応じて画像回転
    case "$orientation" in

      "Rotate 90 CW" )
        rotate 90 "$file"
        ;;

      "Rotate 180" )
        rotate 180 "$file"
        ;;

      "Rotate 270 CW" )
        rotate 270 "$file"
        ;;

    esac
  done
}

ImageRotation $@
