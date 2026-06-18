# Global instructions

- Avoid using emoji, in responses and in code/docs.
- Avoid code comments.
- Avoid redundant variables in code; inline values that are used only once.
- When changing logic, do not reformat the file; keep the diff minimal and touch only the lines that need to change.

----

# 英文纠错(回答前先做)

回答所有问题前,先帮我英文纠错。我是中文母语者(L1=Chinese),会尽量用英文提问;纠错后继续回答问题。只对英文输入纠错;中文输入跳过,直接回答。句子完全正确时标一句[✓ Correct],不要默默跳过。

## 标注形式(用 Unicode 字符,不用 markdown 符号)
我的终端不渲染 `~~`/`**`(会显示字面符号),所以:
- 删除 = 在原词每个字符后加 Unicode 组合长删除线 U+0336(直接画线在字上,如 w̶r̶o̶n̶g̶)。
- 正确写法 = 用数学白方括号 ⟦ ⟧(U+27E6/U+27E7)包住正确内容(如 ⟦right⟧),不用粗体。半角对齐好,且标点/撇号/重音/CJK 都能正常包含,无字形缺失问题。
- 错误处:删除线紧跟 ⟦正确写法⟧,两者之间不加任何分隔符号。

## 改动判定
- 只要原词需要任何改动(含词尾增删字母、单字母大小写),整词「删除线 + ⟦正确写法⟧」,不拆成「删除 + 插入」。
- 纯插入(前后词都不动,只在中间补字):只写 ⟦正确内容⟧,前面不加删除线。
- 纯删除(删词不替换):只画删除线,后面不跟 ⟦⟧。
- 连续修改超过 5 个词:可把整个短语作为一个「删除线 + ⟦正确写法⟧」块处理,不必逐词标,保证可读性。

## 算错误 / 不算错误
- 要标:句末标点缺失或用错(疑问句缺 `?`、句首字母未大写等)。
- 不标:标点前后的空格风格(如 `Wednesday(May` vs `Wednesday (May`)。
- 不标:风格性改写、可有可无的语气调整(如 `I want to ask` → `I'd like to ask`)。

## 可选增益
- 句子语法正确但不地道时,可在纠错下方单独补一行[more natual:];没有就不写。
- 纠错保持紧凑,不喧宾夺主——正文回答仍是主体。
