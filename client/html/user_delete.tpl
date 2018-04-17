<div id='user-delete'>
    <form>
        <ul class='input'>
            <li>
                <%= ctx.makeCheckbox({
                    name: 'confirm-deletion',
                    text: '이 계정을 삭제하는 것을 확인합니다.',
                    required: true,
                }) %>
            </li>
        </ul>

        <div class='messages'></div>
        <div class='buttons'>
            <input type='submit' value='계정 삭제'/>
        </div>
    </form>
</div>
