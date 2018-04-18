<div class='content-wrapper' id='password-reset'>
    <h1>비밀번호 재설정</h1>
    <% if (ctx.canSendMails) { %>
        <form autocomplete='off'>
            <ul class='input'>
                <li>
                    <%= ctx.makeTextInput({
                        text: '닉네임(ID) 또는 이메일',
                        name: 'user-name',
                        required: true,
                    }) %>
                </li>
            </ul>

            <p><small>비밀번호 재설정 링크가 포함된 이메일을 전송합니다. 비밀번호 재설정 링크를 클릭하면 새 비밀번호를 생성할 수 있습니다.</small></p>

            <div class='messages'></div>
            <div class='buttons'>
                <input type='submit' value='전송'/>
            </div>
        </form>
    <% } else { %>
        <p>현재 자동 비밀번호 재설정 기능을 제공하지 않습니다.</p>
        <% if (ctx.contactEmail) { %>
            <p><a href='mailto:<%- ctx.contactEmail %>'><%- ctx.contactEmail %></a>로 이메일을 보내주시면 수동으로 처리하여 드리겠습니다.</p>
        <% } %>
    <% } %>
</div>
