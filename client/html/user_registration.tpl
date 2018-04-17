<div class='content-wrapper' id='user-registration'>
    <h1>가입</h1>
    <form autocomplete='off'>
        <input class='anticomplete' type='text' name='fakeuser'/>
        <input class='anticomplete' type='password' name='fakepass'/>

        <ul class='input'>
            <li>
                <%= ctx.makeTextInput({
                    text: '닉네임(ID)',
                    name: 'name',
                    placeholder: '알파벳, 숫자, _, -',
                    required: true,
                    pattern: ctx.userNamePattern,
                }) %>
            </li>
            <li>
                <%= ctx.makePasswordInput({
                    text: '비밀번호',
                    name: 'password',
                    placeholder: '5글자 이상',
                    required: true,
                    pattern: ctx.passwordPattern,
                }) %>
            </li>
            <li>
                <%= ctx.makeEmailInput({
                    text: '이메일',
                    name: 'email',
                    placeholder: '선택사항',
                }) %>
                <p class='hint'>
                    이메일 주소는 비밀번호 변경과 <a href='http://gravatar.com/'>Gravatar</a>를 위해 사용됩니다.
                    이메일을 입력하지 않으면 Gravatar는 랜덤으로 생성됩니다.
                </p>
            </li>
        </ul>

        <div class='messages'></div>
        <div class='buttons'>
            <input type='submit' value='가입'/>
        </div>
    </form>

    <div class='info'>
        <p>가입한 사용자의 권한</p>
        <ul>
            <li><i class='fa fa-upload'></i> 짤 업로드</li>
            <li><i class='fa fa-heart'></i> 반찬모음 등록</li>
            <li><i class='fa fa-commenting-o'></i> 댓글 등록</li>
            <li><i class='fa fa-star-half-o'></i> 짤과 댓글의 추천/비추천</li>
        </ul>
        <hr/>
        <p>가입 버튼을 클릭함으로써, 귀하는 <a href='<%- ctx.formatClientLink('help', 'tos') %>'>약관 및 개인정보 취급방침</a>을 읽고 동의하였음을 인정합니다.</p>
    </div>
</div>
