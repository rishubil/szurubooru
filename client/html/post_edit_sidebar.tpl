<div class='edit-sidebar'>
    <form autocomplete='off'>
        <input type='submit' value='Save' class='submit'/>

        <div class='messages'></div>

        <% if (ctx.enableSafety && ctx.canEditPostSafety) { %>
            <section class='safety'>
                <label>위험도</label>
                <div class='radio-wrapper'>
                    <%= ctx.makeRadio({
                        name: 'safety',
                        class: 'safety-safe',
                        value: 'safe',
                        selectedValue: ctx.post.safety,
                        text: '안-전'}) %>
                    <%= ctx.makeRadio({
                        name: 'safety',
                        class: 'safety-sketchy',
                        value: 'sketchy',
                        selectedValue: ctx.post.safety,
                        text: 'ㅗㅜㅑ'}) %>
                    <%= ctx.makeRadio({
                        name: 'safety',
                        value: 'unsafe',
                        selectedValue: ctx.post.safety,
                        class: 'safety-unsafe',
                        text: '퍄퍄퍄퍄퍄'}) %>
                </div>
            </section>
        <% } %>

        <% if (ctx.canEditPostRelations) { %>
            <section class='relations'>
                <%= ctx.makeTextInput({
                    text: '관련 짤',
                    name: 'relations',
                    placeholder: '띄어쓰기로 구분된 짤 번호',
                    pattern: '^[0-9 ]*$',
                    value: ctx.post.relations.map(rel => rel.id).join(' '),
                }) %>
            </section>
        <% } %>

        <% if (ctx.canEditPostFlags && ctx.post.type === 'video') { %>
            <section class='flags'>
                <label>기타</label>
                <%= ctx.makeCheckbox({
                    text: '동영상 반복',
                    name: 'loop',
                    checked: ctx.post.flags.includes('loop'),
                }) %>
            </section>
        <% } %>

        <% if (ctx.canEditPostTags) { %>
            <section class='tags'>
                <%= ctx.makeTextInput({}) %>
            </section>
        <% } %>

        <% if (ctx.canEditPostNotes) { %>
            <section class='notes'>
                <a href class='add'>메모 추가</a>
                <%= ctx.makeTextarea({disabled: true, text: '내용 (마크다운 사용가능)', rows: '8'}) %>
                <a href class='delete inactive'>선택된 메모 삭제</a>
                <% if (ctx.hasClipboard) { %>
                    <br/>
                    <a href class='copy'>클립보드로 메모 복사</a>
                    <br/>
                    <a href class='paste'>클립보드에서 메모 붙여넣기</a>
                <% } %>
            </section>
        <% } %>

        <% if (ctx.canEditPostContent) { %>
            <section class='post-content'>
                <label>짤 변경</label>
                <div class='dropper-container'></div>
            </section>
        <% } %>

        <% if (ctx.canEditPostThumbnail) { %>
            <section class='post-thumbnail'>
                <label>썸네일 변경</label>
                <div class='dropper-container'></div>
                <a href>커스텀 썸네일 삭제</a>
            </section>
        <% } %>

        <% if (ctx.canFeaturePosts || ctx.canDeletePosts || ctx.canMergePosts) { %>
            <section class='management'>
                <ul>
                    <% if (ctx.canFeaturePosts) { %>
                        <li><a href class='feature'>이 짤을 대문짤로</a></li>
                    <% } %>
                    <% if (ctx.canMergePosts) { %>
                        <li><a href class='merge'>다른 짤과 병합</a></li>
                    <% } %>
                    <% if (ctx.canDeletePosts) { %>
                        <li><a href class='delete'>짤 삭제</a></li>
                    <% } %>
                </ul>
            </section>
        <% } %>
    </form>
</div>
