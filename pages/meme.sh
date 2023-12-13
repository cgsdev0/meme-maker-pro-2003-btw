if [[ "$REQUEST_METHOD" != "POST" ]]; then
  # only allow POST to this endpoint
  return $(status_code 405)
fi

TOP_TEXT="${FORM_DATA[top_text]^^}"
BOTTOM_TEXT="${FORM_DATA[bottom_text]^^}"

# TODO: this is a vulnerability
FILE="$(basename ${FORM_DATA[file]})"

POINT_SIZE_TOP="${#TOP_TEXT}"
POINT_SIZE_TOP="$((80-POINT_SIZE_TOP*2))"
POINT_SIZE_BOTTOM="${#BOTTOM_TEXT}"
POINT_SIZE_BOTTOM="$((80-POINT_SIZE_BOTTOM*2))"


if [[ ! -z "${QUERY_PARAMS[share]}" ]]; then
  mkdir -p ./static/shared
  TEMP=$(mktemp --tmpdir=./static/shared XXXXXXX.png)
  convert ./static/templates/$FILE \
        -stroke black -strokewidth 2 -fill white \
         -pointsize $POINT_SIZE_TOP -gravity North -annotate +0+10 "$TOP_TEXT" \
        -pointsize $POINT_SIZE_BOTTOM -gravity South -annotate +0+10 "$BOTTOM_TEXT" \
        $TEMP
   # output a div w/ a image tag that references the above
   event "new_picture" "<img src='/static/shared/$(basename $TEMP)' />" | publish "gallery"
else
  cat <<-EOF
  <img src="data:image/jpeg;base64, $(convert ./static/templates/$FILE \
          -stroke black -strokewidth 2 -fill white \
          -pointsize $POINT_SIZE_TOP -gravity North -annotate +0+10 "$TOP_TEXT" \
          -pointsize $POINT_SIZE_BOTTOM -gravity South -annotate +0+10 "$BOTTOM_TEXT" \
          png:- | base64)" />
  <form _="on submit hide me"
         hx-post="/meme?share=true" hx-target="#gallery" hx-swap="none">
    <input type="hidden" name="top_text" value="$TOP_TEXT" />
    <input type="hidden" name="file" value="$FILE" />
    <input type="hidden" name="bottom_text" value="$BOTTOM_TEXT" />
    <button>Share</button>
  </form>
EOF
fi