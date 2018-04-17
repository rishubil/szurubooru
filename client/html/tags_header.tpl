<div class='tag-list-header'>
    <form class='horizontal'>
        <ul class='input'>
            <li>
                <%= ctx.makeTextInput({text: '검색 쿼리', id: 'search-text', name: 'search-text', value: ctx.parameters.query}) %>
            </li>
        </ul>

        <div class='buttons'>
            <input type='submit' value='Search'/>
            <a class='button append' href='<%- ctx.formatClientLink('help', 'search', 'tags') %>'>문법 도움말</a>
            <% if (ctx.canEditTagCategories) { %>
                <a class='append' href='<%- ctx.formatClientLink('tag-categories') %>'>태그 카테고리</a>
            <% } %>
        </div>
    </form>
</div>
