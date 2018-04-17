<div class='tag-delete'>
    <form>
        <p>이 태그는 <a href='<%- ctx.formatClientLink('posts', {query: ctx.tag.names[0]}) %>'><%- ctx.tag.postCount %>번</a> 사용되었습니다.</p>

        <ul class='input'>
            <li>
                <%= ctx.makeCheckbox({
                    name: 'confirm-deletion',
                    text: '이 태그를 삭제하는 것을 확인합니다.',
                    required: true,
                }) %>
            </li>
        </ul>

        <div class='messages'></div>

        <div class='buttons'>
            <input type='submit' value='태그 삭제'/>
        </div>
    </form>
</div>
