<div id='user-edit'>
    <form>
        <input class='anticomplete' type='text' name='fakeuser'/>
        <input class='anticomplete' type='password' name='fakepass'/>

        <ul class='input'>
            <% if (ctx.canEditName) { %>
                <li>
                    <%= ctx.makeTextInput({
                        text: '닉네임(ID)',
                        name: 'name',
                        value: ctx.user.name,
                        pattern: ctx.userNamePattern,
                    }) %>
                </li>
            <% } %>

            <% if (ctx.canEditPassword) { %>
                <li>
                    <%= ctx.makePasswordInput({
                        text: '비밀번호',
                        name: 'password',
                        placeholder: '수정하지 않으려면 입력하지 말것',
                        pattern: ctx.passwordPattern,
                    }) %>
                </li>
            <% } %>

            <% if (ctx.canEditEmail) { %>
                <li>
                    <%= ctx.makeEmailInput({
                        text: '이메일',
                        name: 'email',
                        value: ctx.user.email,
                    }) %>
                </li>
            <% } %>

            <% if (ctx.canEditRank) { %>
                <li>
                    <%= ctx.makeSelect({
                        text: '등급',
                        name: 'rank',
                        keyValues: ctx.ranks,
                        selectedKey: ctx.user.rank,
                    }) %>
                </li>
            <% } %>

            <% if (ctx.canEditAvatar) { %>
                <li class='avatar'>
                    <label>아바타</label>
                    <div id='avatar-content'></div>
                    <div id='avatar-radio'>
                        <%= ctx.makeRadio({
                            text: 'Gravatar',
                            name: 'avatar-style',
                            value: 'gravatar',
                            selectedValue: ctx.user.avatarStyle,
                        }) %>

                        <%= ctx.makeRadio({
                            text: '수동 등록',
                            name: 'avatar-style',
                            value: 'manual',
                            selectedValue: ctx.user.avatarStyle,
                        }) %>
                    </div>
                </li>
            <% } %>
        </ul>

        <div class='messages'></div>

        <div class='buttons'>
            <input type='submit' value='설정 저장'/>
        </div>
    </form>
</div>
