<div class='tag-list table-wrap'>
    <% if (ctx.response.results.length) { %>
        <table>
            <thead>
                <th class='names'>
                    <% if (ctx.query == 'sort:name' || !ctx.query) { %>
                        <a href='<%- ctx.formatClientLink('tags', {query: '-sort:name'}) %>'>태그명</a>
                    <% } else { %>
                        <a href='<%- ctx.formatClientLink('tags', {query: 'sort:name'}) %>'>태그명</a>
                    <% } %>
                </th>
                <th class='implications'>
                    <% if (ctx.query == 'sort:implication-count') { %>
                        <a href='<%- ctx.formatClientLink('tags', {query: '-sort:implication-count'}) %>'>포함 태그</a>
                    <% } else { %>
                        <a href='<%- ctx.formatClientLink('tags', {query: 'sort:implication-count'}) %>'>포함 태그</a>
                    <% } %>
                </th>
                <th class='suggestions'>
                    <% if (ctx.query == 'sort:suggestion-count') { %>
                        <a href='<%- ctx.formatClientLink('tags', {query: '-sort:suggestion-count'}) %>'>제안 태그</a>
                    <% } else { %>
                        <a href='<%- ctx.formatClientLink('tags', {query: 'sort:suggestion-count'}) %>'>제안 태그</a>
                    <% } %>
                </th>
                <th class='usages'>
                    <% if (ctx.query == 'sort:usages') { %>
                        <a href='<%- ctx.formatClientLink('tags', {query: '-sort:usages'}) %>'>사용수</a>
                    <% } else { %>
                        <a href='<%- ctx.formatClientLink('tags', {query: 'sort:usages'}) %>'>사용수</a>
                    <% } %>
                </th>
                <th class='creation-time'>
                    <% if (ctx.query == 'sort:creation-time') { %>
                        <a href='<%- ctx.formatClientLink('tags', {query: '-sort:creation-time'}) %>'>생성일</a>
                    <% } else { %>
                        <a href='<%- ctx.formatClientLink('tags', {query: 'sort:creation-time'}) %>'>생성일</a>
                    <% } %>
                </th>
            </thead>
            <tbody>
                <% for (let tag of ctx.response.results) { %>
                    <tr>
                        <td class='names'>
                            <ul>
                                <% for (let name of tag.names) { %>
                                    <li><%= ctx.makeTagLink(name, false, false, tag) %></li>
                                <% } %>
                            </ul>
                        </td>
                        <td class='implications'>
                            <% if (tag.implications.length) { %>
                                <ul>
                                    <% for (let relation of tag.implications) { %>
                                        <li><%= ctx.makeTagLink(relation.names[0], false, false, relation) %></li>
                                    <% } %>
                                </ul>
                            <% } else { %>
                                -
                            <% } %>
                        </td>
                        <td class='suggestions'>
                            <% if (tag.suggestions.length) { %>
                                <ul>
                                    <% for (let relation of tag.suggestions) { %>
                                        <li><%= ctx.makeTagLink(relation.names[0], false, false, relation) %></li>
                                    <% } %>
                                </ul>
                            <% } else { %>
                                -
                            <% } %>
                        </td>
                        <td class='usages'>
                            <%- tag.postCount %>
                        </td>
                        <td class='creation-time'>
                            <%= ctx.makeRelativeTime(tag.creationTime) %>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</div>
