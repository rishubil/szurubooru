<div class='content-wrapper transparent' id='home'>
    <div class='messages'></div>
    <header>
        <h1><%- ctx.name %></h1>
        <h2><a href="https://tgd.kr/3947875">▷▶ 해외 국적 소유자를 찾습니다 ◁◀</a></h2>
    </header>
    <% if (ctx.canListPosts) { %>
        <form class='horizontal'>
            <%= ctx.makeTextInput({name: 'search-text', placeholder: '태그 입력'}) %>
            <input type='submit' value='검색'/>
            <span class=sep>또는</span>
            <a href='<%- ctx.formatClientLink('posts') %>'>모든 짤 보기</a>
        </form>
    <% } %>
    <div class='post-info-container'></div>
    <footer class='footer-container'></footer>
</div>
