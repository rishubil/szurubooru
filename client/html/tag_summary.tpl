<div class='content-wrapper tag-summary'>
    <section class='details'>
        <section>
            카테고리:
            <span class='<%= ctx.makeCssName(ctx.tag.category, 'tag') %>'><%- ctx.tag.category %></span>
        </section>

        <section>
        별칭:<br/>
        <ul><!--
            --><% for (let name of ctx.tag.names.slice(1)) { %><!--
                --><li><%= ctx.makeTagLink(name, false, false, ctx.tag) %></li><!--
            --><% } %><!--
        --></ul>
        </section>

        <section>
        포함 태그:<br/>
        <ul><!--
            --><% for (let tag of ctx.tag.implications) { %><!--
                --><li><%= ctx.makeTagLink(tag.names[0], false, false, tag) %></li><!--
            --><% } %><!--
        --></ul>
        </section>

        <section>
        제안 태그:<br/>
        <ul><!--
            --><% for (let tag of ctx.tag.suggestions) { %><!--
                --><li><%= ctx.makeTagLink(tag.names[0], false, false, tag) %></li><!--
            --><% } %><!--
        --></ul>
        </section>
    </section>

    <section class='description'>
        <hr/>
        <%= ctx.makeMarkdown(ctx.tag.description || '이 태그는 아직 설명이 없습니다.') %>
        <p>이 태그는 <a href='<%- ctx.formatClientLink('posts', {query: ctx.tag.names[0]}) %>'><%- ctx.tag.postCount %>번</a> 사용되었습니다.</p>
    </section>
</div>
