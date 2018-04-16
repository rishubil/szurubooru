<div class='content-wrapper transparent post-view'>
    <aside class='sidebar'>
        <nav class='buttons'>
            <article class='previous-post'>
                <% if (ctx.prevPostId) { %>
                    <% if (ctx.editMode) { %>
                        <a rel='prev' href='<%= ctx.getPostEditUrl(ctx.prevPostId, ctx.parameters) %>'>
                    <% } else { %>
                        <a rel='prev' href='<%= ctx.getPostUrl(ctx.prevPostId, ctx.parameters) %>'>
                    <% } %>
                <% } else { %>
                    <a rel='prev' class='inactive'>
                <% } %>
                    <i class='fa fa-chevron-left'></i>
                    <span class='vim-nav-hint'>&lt; 이전 짤</span>
                </a>
            </article>
            <article class='next-post'>
                <% if (ctx.nextPostId) { %>
                    <% if (ctx.editMode) { %>
                        <a rel='next' href='<%= ctx.getPostEditUrl(ctx.nextPostId, ctx.parameters) %>'>
                    <% } else { %>
                        <a rel='next' href='<%= ctx.getPostUrl(ctx.nextPostId, ctx.parameters) %>'>
                    <% } %>
                <% } else { %>
                    <a rel='next' class='inactive'>
                <% } %>
                    <i class='fa fa-chevron-right'></i>
                    <span class='vim-nav-hint'>다음 짤 &gt;</span>
                </a>
            </article>
            <article class='edit-post'>
                <% if (ctx.editMode) { %>
                    <a href='<%= ctx.getPostUrl(ctx.post.id, ctx.parameters) %>'>
                        <i class='fa fa-reply'></i>
                        <span class='vim-nav-hint'>감상 모드로 돌아가기</span>
                    </a>
                <% } else { %>
                    <% if (ctx.canEditPosts || ctx.canDeletePosts || ctx.canFeaturePosts) { %>
                        <a href='<%= ctx.getPostEditUrl(ctx.post.id, ctx.parameters) %>'>
                    <% } else { %>
                        <a class='inactive'>
                    <% } %>
                        <i class='fa fa-pencil'></i>
                        <span class='vim-nav-hint'>짤 수정</span>
                    </a>
                <% } %>
            </article>
        </nav>

        <div class='sidebar-container'></div>
    </aside>

    <div class='content'>
        <div class='post-container'></div>

        <% if (ctx.canListComments) { %>
            <div class='comments-container'></div>
        <% } %>

        <% if (ctx.canCreateComments) { %>
            <h2>댓글 달기</h2>
            <div class='comment-form-container'></div>
        <% } %>
    </div>
</div>
