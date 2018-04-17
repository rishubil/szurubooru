<div class='user-list-header'>
    <form class='horizontal'>
        <ul class='input'>
            <li>
                <%= ctx.makeTextInput({text: '검색 쿼리', id: 'search-text', name: 'search-text', value: ctx.parameters.query}) %>
            </li>
        </ul>

        <div class='buttons'>
            <input type='submit' value='검색'/>
            <a class='append' href='<%- ctx.formatClientLink('help', 'search', 'users') %>'>문법 도움말</a>
        </div>
    </form>
</div>
