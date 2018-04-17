<div class='content-wrapper tag-categories'>
    <form>
        <h1>태그 카테고리</h1>
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th class='name'>카테고리명</th>
                        <th class='color'>CSS 색상</th>
                        <th class='usages'>사용수</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

        <% if (ctx.canCreate) { %>
            <p><a href class='add'>새 카테고리 추가</a></p>
        <% } %>

        <div class='messages'></div>

        <% if (ctx.canCreate || ctx.canEditName || ctx.canEditColor || ctx.canDelete) { %>
            <div class='buttons'>
                <input type='submit' class='save' value='변경사항 저장'>
            </div>
        <% } %>
    </form>
</div>
