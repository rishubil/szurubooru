<div class='post-container'></div>
<% if (ctx.featuredPost) { %>
    <aside>
        대문 짤:&nbsp;<%= ctx.makePostLink(ctx.featuredPost.id, true) %>,<wbr>
        <%= ctx.makeRelativeTime(ctx.featuredPost.creationTime) %>&nbsp;에&nbsp;<%= ctx.makeUserLink(ctx.featuredPost.user) %>&nbsp;님이&nbsp;업로드
    </aside>
<% } %>
