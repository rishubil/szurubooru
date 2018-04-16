<div class='content-wrapper' id='tag'>
    <h1><%- ctx.tag.names[0] %></h1>
    <nav class='buttons'><!--
        --><ul><!--
            --><li data-name='summary'><a href='<%- ctx.formatClientLink('tag', ctx.tag.names[0]) %>'>요약</a></li><!--
            --><% if (ctx.canEditAnything) { %><!--
                --><li data-name='edit'><a href='<%- ctx.formatClientLink('tag', ctx.tag.names[0], 'edit') %>'>편집</a></li><!--
            --><% } %><!--
            --><% if (ctx.canMerge) { %><!--
                --><li data-name='merge'><a href='<%- ctx.formatClientLink('tag', ctx.tag.names[0], 'merge') %>'>병합</a></li><!--
            --><% } %><!--
            --><% if (ctx.canDelete) { %><!--
                --><li data-name='delete'><a href='<%- ctx.formatClientLink('tag', ctx.tag.names[0], 'delete') %>'>삭제</a></li><!--
            --><% } %><!--
        --></ul><!--
    --></nav>
    <div class='tag-content-holder'></div>
</div>
