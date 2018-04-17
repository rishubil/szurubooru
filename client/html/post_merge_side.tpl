<header>
    <label for='merge-id-<%- ctx.name %>'>짤 #</label>
    <% if (ctx.editable) { %>
        <input type='text' id='merge-id-<%-ctx.name %>' pattern='^[0-9]+$' value='<%- ctx.post ? ctx.post.id : '' %>'/>
        <input type='button' value='검색'/>
    <% } else { %>
        <input type='text' id='merge-id-<%-ctx.name %>' pattern='^[0-9]+$' value='<%- ctx.post ? ctx.post.id : '' %>' readonly/>
    <% } %>
</header>

<% if (ctx.post) { %>
    <div class='post-thumbnail'>
        <a rel='external' href='<%- ctx.post.contentUrl %>'>
            <%= ctx.makeThumbnail(ctx.post.thumbnailUrl) %>
        </a>
    </div>
    <div class='target-post'>
        <%= ctx.makeRadio({
            required: true,
            text: '이 짤로 병합<br/><small>' +
                ctx.makeUserLink(ctx.post.user) +
                ', ' +
                ctx.makeRelativeTime(ctx.post.creationTime) +
                '</small>',
            name: 'target-post',
            value: ctx.name,
        }) %>
    </div>
    <div class='target-post-content'>
        <%= ctx.makeRadio({
            required: true,
            text: '이 파일 사용<br/><small>' +
                ctx.makeFileSize(ctx.post.fileSize) + ' ' +
                {
                    'image/gif': 'GIF',
                    'image/jpeg': 'JPEG',
                    'image/png': 'PNG',
                    'video/webm': 'WEBM',
                    'application/x-shockwave-flash': 'SWF',
                }[ctx.post.mimeType] +
                ' (' +
                (ctx.post.canvasWidth ?
                    `${ctx.post.canvasWidth}x${ctx.post.canvasHeight}` :
                    '?') +
                ')</small>',
            name: 'target-post-content',
            value: ctx.name,
        }) %>
        <p>
        </p>
    </div>
<% } %>
