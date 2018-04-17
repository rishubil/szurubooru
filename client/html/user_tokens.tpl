<div id='user-tokens'>
    <div class='messages'></div>
    <% if (ctx.tokens.length > 0) { %>
    <div class='token-flex-container'>
        <% _.each(ctx.tokens, function(token, index) { %>
        <div class='token-flex-row'>
            <div class='token-flex-column token-flex-labels'>
                <div class='token-flex-row'>토큰:</div>
                <div class='token-flex-row'>메모:</div>
                <div class='token-flex-row'>생성:</div>
                <div class='token-flex-row'>만료:</div>
                <div class='token-flex-row no-wrap'>마지막 사용:</div>
            </div>
            <div class='token-flex-column full-width'>
                <div class='token-flex-row'><%= token.token %></div>
                <div class='token-flex-row'>
                    <% if (token.note !== null) { %>
                        <%= token.note %>
                    <% } else { %>
                        No note
                    <% } %>
                    <a class='token-change-note' data-token-id='<%= index %>' href='#'>(수정)</a>
                </div>
                <div class='token-flex-row'><%= ctx.makeRelativeTime(token.creationTime) %></div>
                <div class='token-flex-row'>
                    <% if (token.expirationTime) { %>
                        <%= ctx.makeRelativeTime(token.expirationTime) %>
                    <% } else { %>
                        만료 없음
                    <% } %>
                </div>
                <div class='token-flex-row'><%= ctx.makeRelativeTime(token.lastUsageTime) %></div>
            </div>
        </div>
        <div class='token-flex-row'>
            <div class='token-flex-column full-width'>
                <div class='token-flex-row'>
                    <form class='token' data-token-id='<%= index %>'>
                        <% if (token.isCurrentAuthToken) { %>
                            <input type='submit' value='삭제 후 로그아웃'
                                title='현재 클라이언트에서 사용중인 토큰이므로 삭제시 로그아웃됩니다.'/>
                        <% } else { %>
                            <input type='submit' value='삭제'/>
                        <% } %>
                    </form>
                </div>
            </div>
        </div>
        <hr/>
        <% }); %>
    </div>
    <% } else { %>
        <h2>No Registered Tokens</h2>
    <% } %>
    <form id='create-token-form'>
        <ul class='input'>
            <li class='note'>
                <%= ctx.makeTextInput({
                    text: '메모',
                    id: 'note',
                }) %>
            </li>
            <li class='expirationTime'>
                <%= ctx.makeDateInput({
                    text: '만료',
                    id: 'expirationTime',
                }) %>
            </li>
        </ul>
        <div class='buttons'>
            <input type='submit' value='토큰 생성'/>
        </div>
    </form>
</div>
