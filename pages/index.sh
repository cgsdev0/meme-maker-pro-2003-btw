
source config.sh

htmx_page << EOF
<center>
  <h1 _="init repeat forever
           transition my opacity to 0 over 1s
           transition my opacity to 1 over 1s">
    Meme Maker Pro 2003 - Enterprise Edition
  </h1>
  <h2>No Canadians, btw</h2>
</center>

<center>
  <form hx-post="/meme" hx-target="#meme"
        hx-trigger="submit, keyup delay:500ms">
    <table>
      <tr>
      <td>
        <label>Top Text</label>
      </td>
      <td>
        <input type="text" name="top_text"/>
      <td>
      </tr>
      <tr>
      <td>
        <label>Bottom Text</label>
      </td>
      <td>
        <input type="text" name="bottom_text"/>
      <td>
      </tr>
      <tr>
      <td colspan="2">
        <center>
    <select name="file" _="on input b1.click()">
      $(find static/templates -type f \
        | sed 's/\(.*\/\)\(.*\)\.\(.*\)/\1\2.\3 \2/' \
        | awk '{ print "<option value=\""$1"\">"$2"</option>" }')
    </select><br><br>
        </center>
      </td>
      </tr>
      <tr>
      <td colspan="2">
        <center>
          <button id="b1" _="init repeat forever
             transition my width to 100px
                           height to 50px over 1s
             transition my width to 50px 
                           hieght to 20px over 1s">
            Do it
          </button>
        </center>
      </td>
      </tr>
      </table>
  </form>
</center>
<br><br>
<br><br>

<center>
<output id="meme">
</output>
</center>
<br><br>
<marquee style="color:#e040fb;background-color:#76FF03;padding:16px;font-size:24px;font-weight:bold;border-radius:6px">Meme Maker Pro (2003)</marquee>

<center>
<h1>
Gallery
</h1>
<output hx-ext="sse" sse-connect="/sse" sse-swap="init,new_picture" id="gallery" hx-swap="afterbegin">
</output>
</center>
EOF
