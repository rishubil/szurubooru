<div class='tag-merge'>
    <form>
        <ul class='input'>
            <li class='target'>
                <%= ctx.makeTextInput({name: 'target-tag', required: true, text: '병합할 태그', pattern: ctx.tagNamePattern}) %>
            </li>

            <li>
                <p>태그된 짤, 제안 태그 및 포함 태그가 병합됩니다. 태그 카테고리는 직접 수정해야 합니다.</p>

                <%= ctx.makeCheckbox({name: 'alias', text: '병합할 태그의 별칭으로 등록합니다.'}) %>

                <%= ctx.makeCheckbox({required: true, text: '이 태그를 병합하는 것을 확인합니다.'}) %>
            </li>
        </ul>

        <div class='messages'></div>

        <div class='buttons'>
            <input type='submit' value='태그 병합'/>
        </div>
    </form>
</div>
