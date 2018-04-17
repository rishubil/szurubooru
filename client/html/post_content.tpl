<div class='post-content post-type-<%- ctx.post.type %>'>
    <% if (['image', 'animation'].includes(ctx.post.type)) { %>

        <img class='resize-listener' alt='' src='<%- ctx.post.contentUrl %>'/>

    <% } else if (ctx.post.type === 'flash') { %>

        <object class='resize-listener' width='<%- ctx.post.canvasWidth %>' height='<%- ctx.post.canvasHeight %>' data='<%- ctx.post.contentUrl %>'>
            <param name='wmode' value='opaque'/>
            <param name='movie' value='<%- ctx.post.contentUrl %>'/>
        </object>

    <% } else if (ctx.post.type === 'video') { %>

        <%= ctx.makeElement(
            'video', {
                class: 'resize-listener',
                controls: true,
                loop: (ctx.post.flags || []).includes('loop'),
                autoplay: ctx.autoplay,
            },
            ctx.makeElement('source', {
                type: ctx.post.mimeType,
                src: ctx.post.contentUrl,
            }),
            '브라우저가 HTML5 동영상을 지원하지 않습니다.')
        %>

    <% } else { console.log(new Error('Unknown post type')); } %>

    <div class='post-overlay resize-listener'>
    </div>
</div>
