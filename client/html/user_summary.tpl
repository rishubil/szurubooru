<div id='user-summary'>
    <%= ctx.makeThumbnail(ctx.user.avatarUrl) %>
    <ul class='basic-info'>
        <li>가입일: <%= ctx.makeRelativeTime(ctx.user.creationTime) %></li>
        <li>최근 로그인: <%= ctx.makeRelativeTime(ctx.user.lastLoginTime) %></li>
        <li>등급: <%- ctx.user.rankName.toLowerCase() %></li>
    </ul>

    <div>
        <nav>
            <p><strong>바로가기</strong></p>
            <ul>
                <li><a href='<%- ctx.formatClientLink('posts', {query: 'submit:' + ctx.user.name}) %>'>업로드 <%- ctx.user.uploadedPostCount %></a></li>
                <li><a href='<%- ctx.formatClientLink('posts', {query: 'fav:' + ctx.user.name}) %>'>반찬모음 <%- ctx.user.favoritePostCount %></a></li>
                <li><a href='<%- ctx.formatClientLink('posts', {query: 'comment:' + ctx.user.name}) %>'>댓글 <%- ctx.user.commentCount %></a></li>
            </ul>
        </nav>

        <% if (ctx.isLoggedIn) { %>
            <nav>
                <p><strong>바로가기(나만 보임)</strong></p>
                <ul>
                    <li><a href='<%- ctx.formatClientLink('posts', {query: 'special:liked'}) %>'>추천 짤 <%- ctx.user.likedPostCount %></a></li>
                    <li><a href='<%- ctx.formatClientLink('posts', {query: 'special:disliked'}) %>'>비추천 짤 <%- ctx.user.dislikedPostCount %></a></li>
                </ul>
            </nav>
        <% } %>
    </div>
</div>
