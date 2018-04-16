<div class='post-list-header'><%
    %><form class='horizontal search'><%
        %><%= ctx.makeTextInput({text: '검색 쿼리', id: 'search-text', name: 'search-text', value: ctx.parameters.query}) %><%
        %><wbr/><%
        %><input class='mousetrap' type='submit' value='검색'/><%
        %><wbr/><%
        %><% if (ctx.enableSafety) { %><%
            %><input data-safety=safe type='button' class='mousetrap safety safety-safe <%- ctx.settings.listPosts.safe ? '' : 'disabled' %>'/><%
            %><input data-safety=sketchy type='button' class='mousetrap safety safety-sketchy <%- ctx.settings.listPosts.sketchy ? '' : 'disabled' %>'/><%
            %><input data-safety=unsafe type='button' class='mousetrap safety safety-unsafe <%- ctx.settings.listPosts.unsafe ? '' : 'disabled' %>'/><%
        %><% } %><%
        %><wbr/><%
        %><a class='mousetrap button append' href='<%- ctx.formatClientLink('help', 'search', 'posts') %>'>문법 도움말</a><%
    %></form><%
    %><% if (ctx.canBulkEditTags) { %><%
        %><form class='horizontal bulk-edit bulk-edit-tags'><%
            %><span class='append hint'>편집할 태그:</span><%
            %><a href class='mousetrap button append open'>일괄 태그 편집</a><%
            %><wbr/><%
            %><%= ctx.makeTextInput({name: 'tag', value: ctx.parameters.tag}) %><%
            %><input class='mousetrap start' type='submit' value='편집 시작'/><%
            %><a href class='mousetrap button append close'>편집 완료</a><%
        %></form><%
    %><% } %><%
    %><% if (ctx.enableSafety && ctx.canBulkEditSafety) { %><%
        %><form class='horizontal bulk-edit bulk-edit-safety'><%
            %><a href class='mousetrap button append open'>위험도 일괄 편집</a><%
            %><a href class='mousetrap button append close'>위험도 편집 종료</a><%
        %></form><%
    %><% } %><%
%></div>
