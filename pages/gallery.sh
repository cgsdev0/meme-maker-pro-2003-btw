
find static/shared -type f -printf "%T@ %Tc %p\n" | sort -nr | cut -d' ' -f7 \
    | awk '{print "<img src=\""$0"\" />" }'