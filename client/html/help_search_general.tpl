<p>검색 쿼리는 띄어쓰기로 구분된 토큰으로 구성됩니다. 각 토큰은 다음과 같습니다.</p>

<table>
    <thead>
        <tr>
            <th>문법</th>
            <th>토큰 종류</th>
            <th>설명</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>&lt;value&gt;</code></td>
            <td>익명 토큰</td>
            <td>기본 필터에 사용됨</td>
        </tr>
        <tr>
            <td><code>&lt;key&gt;:&lt;value&gt;</code></td>
            <td>명명된 토큰</td>
            <td>고급 필터에 사용됨</td>
        </tr>
        <tr>
            <td><code>sort:&lt;style&gt;</code></td>
            <td>정렬 토큰</td>
            <td>검색 결과를 정렬하기 위해 사용됨</td>
        </tr>
        <tr>
            <td><code>special:&lt;value&gt;</code></td>
            <td>특수 토큰</td>
            <td>일반적으로 로그인한 사용자와 관련된 필터</td>
        </tr>
    </tbody>
</table>

<p>대부분의 익명 토큰과 명명된 토큰은 다음과 같은 범위와 복합 값을 지원합니다.</p>

<table>
    <tbody>
        <tr>
            <td><code>a,b,c</code></td>
            <td><code>a</code>,
            <code>b</code>, <code>c</code> 중 어느 하나라도 만족할 경우</td>
        </tr>
        <tr>
            <td><code>1..</code></td>
            <td>1보다 크거나 같을 경우</td>
        </tr>
        <tr>
            <td><code>..4</code></td>
            <td>4보다 작거나 같을 경우</td>
        </tr>
        <tr>
            <td><code>1..4</code></td>
            <td>1보다 크거나 같고, 4보다 같거나 작을 경우</td>
        </tr>
    </tbody>
</table>

<p>범위 값은 <code>-min</code> 또는
<code>-max</code> 접미사를 key로서, <code>score-min:1</code> 같이 사용할 수 있습니다.</p>

<p>날짜/시간 값은 다음과 같습니다.</p>

<ul>
    <li><code>today</code></li>
    <li><code>yesterday</code></li>
    <li><code>&lt;year&gt;</code></li>
    <li><code>&lt;year&gt;-&lt;month&gt;</code></li>
    <li><code>&lt;year&gt;-&lt;month&gt;-&lt;day&gt;</code></li>
</ul>

<p>닉네임과 같은 일부 속성은 와일드카드 (<code>*</code>)를 사용할 수 있습니다.</p>

<p>모든 토큰은 앞에 <code>-</code>를 붙이면 반대의 의미로 사용됩니다.</p>

<p>정렬 토큰은 <code>,asc</code> 또는
<code>,desc</code>를 뒤에 붙여 정렬 방향을 지정할 수 있으며, 토큰 전체에 <code>-</code>를 붙여 동일하게 사용할 수 있습니다.</p>

<p><code>:</code> 와 <code>-</code> 같은 특수 문자는 앞에 <code>\</code>를 붙여 이스케이프 처리할 수 있습니다.</p>

<h1>예제</h1>

<p>다음과 같은 검색 쿼리로 짤을 찾을 경우</p>

<pre><code>모자 -fav-count:8.. type:video uploader:Yeokka</code></pre>

<p>모자가 태그된 동영상 파일 중, 7명 미만이 반찬목록에 담았고 Yeokka가 업로드한 동영상 파일이 검색됩니다.</p>

<p><code>역:펀</code>와 같은 쿼리는 알 수 없는 명명된 토큰에 대한 오류 메시지를 출력합니다.</p>

<p><code>역\:펀</code>을 검색하면 <code>역:펀</code>이 태그된 짤을 정상적으로 검색합니다.</p>
