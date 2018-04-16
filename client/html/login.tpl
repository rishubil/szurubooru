<div class='content-wrapper' id='login'>
    <h1>로그인</h1>
    <form>
        <ul class='input'>
            <li>
                <%= ctx.makeTextInput({
                    text: '닉네임(ID)',
                    name: 'name',
                    required: true,
                    pattern: ctx.userNamePattern,
                }) %>
            </li>
            <li>
                <%= ctx.makePasswordInput({
                    text: '비밀번호',
                    name: 'password',
                    required: true,
                    pattern: ctx.passwordPattern,
                }) %>
            </li>
            <li>
                <%= ctx.makeCheckbox({
                    text: '로그인 유지',
                    name: 'remember-user',
                }) %>
            </li>
        </ul>

        <div class='messages'></div>

        <div class='buttons'>
            <input type='submit' value='Log in'/>
            <a class='append' href='<%- ctx.formatClientLink('password-reset') %>'>비밀번호가 뭐더라?</a>
        </div>
    </form>
</div>
