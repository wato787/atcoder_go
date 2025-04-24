# AtCoder用シンプルMakefile
# 既存フォルダ構造を使用し、シェルスクリプトを呼び出す

# シェルスクリプトのパス
SCRIPT=./atcoder.sh

# デフォルトのターゲット
.PHONY: help
help:
	@echo "利用可能なコマンド:"
	@echo "  make new-contest ABC123     - 新しいコンテストディレクトリを作成"
	@echo "  make new-problem ABC123 A   - 新しい問題ディレクトリを作成"
	@echo "  make test PROBLEM=practice/A - 問題のテストを実行"
	@echo "  make run PROBLEM=practice/A  - 問題を手動入力で実行"
	@echo "  make new-practice NAME [URL] - 練習問題を作成"
	@echo "  make clean                  - 生成ファイルを削除"
	@echo "  make ojtest                 - ojを使ったテスト実行"

# 新しいコンテストディレクトリを作成
.PHONY: new-contest
new-contest:
	@$(SCRIPT) new-contest $(filter-out $@,$(MAKECMDGOALS))

# 新しい問題ディレクトリを作成
.PHONY: new-problem
new-problem:
	@$(SCRIPT) new-problem $(word 1,$(filter-out $@,$(MAKECMDGOALS))) $(word 2,$(filter-out $@,$(MAKECMDGOALS)))

# 問題のテスト実行
.PHONY: test
test:
	@$(SCRIPT) test $(PROBLEM)

# 問題の手動入力実行
.PHONY: run
run:
	@$(SCRIPT) run $(PROBLEM)

# 練習問題を追加
.PHONY: new-practice
new-practice:
	@$(SCRIPT) new-practice $(word 1,$(filter-out $@,$(MAKECMDGOALS))) $(word 2,$(filter-out $@,$(MAKECMDGOALS)))

# クリーンアップ
.PHONY: clean
clean:
	@$(SCRIPT) clean

# ojを使ってテスト実行
.PHONY: ojtest
ojtest:
	@$(SCRIPT) ojtest $(PROBLEM)

# 引数を無視して実行できるようにするハック
%:
	@: