<div class='post-merge'>
    <form>
        <ul class='input'>
            <li class='post-mirror'>
                <div class='left-post-container'></div>
                <div class='right-post-container'></div>
            </li>

            <li>
                <p>태그, 관련 짤, 점수, 반찬모음 및 댓글이 병합됩니다. 다른 모든 속성은 직접 수정해야 합니다.</p>

                <%= ctx.makeCheckbox({required: true, text: '이 짤들을 병합하는 것을 확인합니다.'}) %>
            </li>
        </ul>

        <div class='messages'></div>

        <div class='buttons'>
            <input type='submit' value='짤 병합'/>
        </div>
    </form>
</div>
