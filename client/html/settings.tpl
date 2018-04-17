<div class='content-wrapper' id='settings'>
    <form>
        <strong>브라우저 설정</strong>
        <p>이 설정은 브라우저의 로컬 저장소에 저장되며, 계정 설정과 무관합니다. 따라서 이 설정은 다른 기기 또는 브라우저에 적용되지 않습니다.</p>
        <ul class='input'>
            <li>
                <%= ctx.makeCheckbox({
                    text: "키보드 단축키 사용 <a class='append icon' href='" + ctx.formatClientLink('help', 'keyboard') + "'><i class='fa fa-question-circle-o'></i></a>",
                    name: 'keyboard-shortcuts',
                    checked: ctx.browsingSettings.keyboardShortcuts,
                }) %>
            </li>

            <li>
                <%= ctx.makeNumericInput({
                    text: '한 페이지에 출력할 짤 갯수',
                    name: 'posts-per-page',
                    checked: ctx.browsingSettings.postCount,
                    value: ctx.browsingSettings.postsPerPage,
                    min: 10,
                    max: 100,
                }) %>
            </li>

            <li>
                <%= ctx.makeCheckbox({
                    text: '작은 짤 키워보기',
                    name: 'upscale-small-posts',
                    checked: ctx.browsingSettings.upscaleSmallPosts}) %>
            </li>

            <li>
                <%= ctx.makeCheckbox({
                    text: '무한 스크롤 사용',
                    name: 'endless-scroll',
                    checked: ctx.browsingSettings.endlessScroll,
                }) %>
                <p class='hint'>페이지 이동 대신 스크롤하여 컨텐츠를 불러옵니다.</p>
            </li>

            <li>
                <%= ctx.makeCheckbox({
                    text: '투명 그리드 사용',
                    name: 'transparency-grid',
                    checked: ctx.browsingSettings.transparencyGrid,
                }) %>
                <p class='hint'>짤의 투명 배경에 체크무늬를 보여줍니다.</p>
            </li>

            <li>
                <%= ctx.makeCheckbox({
                    text: '제안 태그 보여주기',
                    name: 'tag-suggestions',
                    checked: ctx.browsingSettings.tagSuggestions,
                }) %>
                <p class='hint'>태그 수정 폼에서 제안 태그 팝업을 보여줍니다.</p>
            </li>

            <li>
                <%= ctx.makeCheckbox({
                    text: '동영상 짤 자동 재생',
                    name: 'autoplay-videos',
                    checked: ctx.browsingSettings.autoplayVideos,
                }) %>
            </li>
        </ul>

        <div class='messages'></div>
        <div class='buttons'>
            <input type='submit' value='설정 저장'/>
        </div>
    </form>
</div>
