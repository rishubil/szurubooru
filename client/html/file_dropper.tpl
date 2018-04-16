<div class='file-dropper-holder'>
    <input type='file' id='<%- ctx.id %>'/>
    <label class='file-dropper' for='<%- ctx.id %>' role='button'>
        <% if (ctx.allowMultiple) { %>
            여기에 파일을 드래그 &amp; 드랍!
        <% } else { %>
            여기에 파일을 드래그 &amp; 드랍!
        <% } %>
        <br/>
        또는 그냥 클릭하세요.
        <% if (ctx.extraText) { %>
            <br/>
            <small><%= ctx.extraText %></small>
        <% } %>
    </label>
    <% if (ctx.allowUrls) { %>
        <div class='url-holder'>
            <input type='text' name='url' placeholder='<%- ctx.urlPlaceholder %>'/>
            <% if (ctx.lock) { %>
                <button>적용</button>
            <% } else { %>
                <button>URL 추가</button>
            <% } %>
        </div>
    <% } %>
</div>
