
zu = require '../src/zu'

html = '''
<div class="hello-example">
    <a class="a1" href="http://example.com">English:</a>
    <span class="s1" lang="en-us en-gb en-au en-nz">Hello World!</span>
</div>
<div class="hello-example">
    <a class="a2" href="#portuguese">Portuguese:</a>
    <span class="s2" lang="pt">Olá Mundo!</span>
</div>
<div class="hello-example">
    <a class="a3" href="http://example.cn">Chinese (Simplified):</a>
    <span class="s3" lang="zh-CN">世界您好！</span>
</div>
<div class="hello-example">
    <a class="a4" href="http://example.cn">Chinese (Traditional):</a>
    <span class="s4" lang="zh-TW">世界您好！</span>
    <span foo="" class="s5">Not lang</span>
</div>
'''

ns = zu.parse html

describe 'attrib', ->

    it 'selects just span[lang]', ->
        eql zu.find(ns, 'span[lang]'), ['<span.s1>', '<span.s2>', '<span.s3>', '<span.s4>']

    it 'selects span[lang="pt"]', ->
        eql zu.find(ns, 'span[lang=pt]'), ['<span.s2>']

    it 'selects span[lang=pt]', ->
        eql zu.find(ns, 'span[lang=pt]'), ['<span.s2>']

    it 'selects span[foo=""]', ->
        eql zu.find(ns, 'span[foo=""]'), ['<span.s5>']

    it 'selects span[lang~=en-us]', ->
        eql zu.find(ns, 'span[lang~=en-us]'), ['<span.s1>']

    it 'selects span[lang|=zh]', ->
        eql zu.find(ns, 'span[lang|=zh]'), ['<span.s3>', '<span.s4>']

    it 'selects a[href^="#"]', ->
        eql zu.find(ns, 'a[href^="#"]'), ['<a.a2>']

    it 'selects a[href$=".cn"]', ->
        eql zu.find(ns, 'a[href$=".cn"]'), ['<a.a3>', '<a.a4>']

    it 'selects a[href*="example"]', ->
        eql zu.find(ns, 'a[href*="example"]'), ['<a.a1>','<a.a3>','<a.a4>']
