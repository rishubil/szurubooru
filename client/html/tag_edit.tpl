<div class='content-wrapper tag-edit'>
    <form>
        <ul class='input'>
            <li class='names'>
                <% if (ctx.canEditNames) { %>
                    <%= ctx.makeTextInput({
                        text: '태그명',
                        value: ctx.tag.names.join(' '),
                        required: true,
                    }) %>
                <% } %>
            </li>
            <li class='category'>
                <% if (ctx.canEditCategory) { %>
                    <%= ctx.makeSelect({
                        text: '카테고리',
                        keyValues: ctx.categories,
                        selectedKey: ctx.tag.category,
                        required: true,
                    }) %>
                <% } %>
            </li>
            <li class='implications'>
                <% if (ctx.canEditImplications) { %>
                    <%= ctx.makeTextInput({text: '포함 태그'}) %>
                <% } %>
            </li>
            <li class='suggestions'>
                <% if (ctx.canEditSuggestions) { %>
                    <%= ctx.makeTextInput({text: '제안 태그'}) %>
                <% } %>
            </li>
            <li class='description'>
                <% if (ctx.canEditDescription) { %>
                    <%= ctx.makeTextarea({
                        text: '설명',
                        value: ctx.tag.description,
                    }) %>
                <% } %>
            </li>
        </ul>

        <% if (ctx.canEditAnything) { %>
            <div class='messages'></div>

            <div class='buttons'>
                <input type='submit' class='save' value='변경사항 저장'>
            </div>
        <% } %>
    </form>
</div>
