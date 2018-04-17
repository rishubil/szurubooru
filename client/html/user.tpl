<div class='content-wrapper' id='user'>
    <h1><%- ctx.user.name %></h1>
    <nav class='buttons'><!--
        --><ul><!--
            --><li data-name='summary'><a href='<%- ctx.formatClientLink('user', ctx.user.name) %>'>요약</a></li><!--
            --><% if (ctx.canEditAnything) { %><!--
                --><li data-name='edit'><a href='<%- ctx.formatClientLink('user', ctx.user.name, 'edit') %>'>설정</a></li><!--
            --><% } %><!--
            --><% if (ctx.canListTokens) { %><!--
                --><li data-name='list-tokens'><a href='<%- ctx.formatClientLink('user', ctx.user.name, 'list-tokens') %>'>로그인 토큰</a></li><!--
            --><% } %><!--
            --><% if (ctx.canDelete) { %><!--
                --><li data-name='delete'><a href='<%- ctx.formatClientLink('user', ctx.user.name, 'delete') %>'>삭제</a></li><!--
            --><% } %><!--
        --></ul><!--
    --></nav>
    <div id='user-content-holder'></div>
</div>
