# AtCoder用Makefile

# 変数
PRACTICE_DIR = practice
TEMPLATE_FILE = template.go
CONTESTS_DIR = contests

# デフォルトのターゲット
.PHONY: help
help:
	@echo "利用可能なコマンド:"
	@echo "  make new-contest ABC123     - 新しいコンテストディレクトリを作成"
	@echo "  make new-problem ABC123 A   - 新しい問題ディレクトリを作成"
	@echo "  make test PROBLEM=practice/A - 問題のテストを実行"
	@echo "  make run PROBLEM=practice/A  - 問題を手動入力で実行"
	@echo "  make clean                  - 生成ファイルを削除"

# 新しいコンテストディレクトリを作成
.PHONY: new-contest
new-contest:
	@contest="$${1}"; \
	mkdir -p $(CONTESTS_DIR)/$$contest; \
	echo "コンテスト $$contest のディレクトリを作成しました"; \
	for problem in A B C D E F; do \
		mkdir -p $(CONTESTS_DIR)/$$contest/$$problem; \
		cp $(TEMPLATE_FILE) $(CONTESTS_DIR)/$$contest/$$problem/main.go; \
		touch $(CONTESTS_DIR)/$$contest/$$problem/input.txt; \
		touch $(CONTESTS_DIR)/$$contest/$$problem/output.txt; \
		echo "問題 $$problem のディレクトリを作成しました"; \
	done

# 新しい問題ディレクトリを作成
.PHONY: new-problem
new-problem:
	@contest="$${1}"; \
	problem="$${2}"; \
	if [ -z "$$contest" ] || [ -z "$$problem" ]; then \
		echo "コンテスト名と問題名を指定してください (例: make new-problem ABC123 A)"; \
		exit 1; \
	fi; \
	mkdir -p $(CONTESTS_DIR)/$$contest/$$problem; \
	cp $(TEMPLATE_FILE) $(CONTESTS_DIR)/$$contest/$$problem/main.go; \
	touch $(CONTESTS_DIR)/$$contest/$$problem/input.txt; \
	touch $(CONTESTS_DIR)/$$contest/$$problem/output.txt; \
	echo "問題 $$contest $$problem のディレクトリを作成しました"

# 問題のテスト実行
.PHONY: test
test:
	@if [ -z "$(PROBLEM)" ]; then \
		echo "問題パスを指定してください (例: make test PROBLEM=practice/A)"; \
		exit 1; \
	fi; \
	dir=$$(dirname $(PROBLEM)); \
	file=$$(basename $(PROBLEM)); \
	cd "$$dir" && go run main.go < input.txt | tee output.txt

# 問題の手動入力実行
.PHONY: run
run:
	@if [ -z "$(PROBLEM)" ]; then \
		echo "問題パスを指定してください (例: make run PROBLEM=practice/A)"; \
		exit 1; \
	fi; \
	dir=$$(dirname $(PROBLEM)); \
	file=$$(basename $(PROBLEM)); \
	cd "$$dir" && go run main.go

# practiceディレクトリに新しい問題を追加
.PHONY: new-practice
new-practice:
	@problem="$${1}"; \
	if [ -z "$$problem" ]; then \
		echo "問題名を指定してください (例: make new-practice A)"; \
		exit 1; \
	fi; \
	mkdir -p $(PRACTICE_DIR)/$$problem; \
	cp $(TEMPLATE_FILE) $(PRACTICE_DIR)/$$problem/main.go; \
	touch $(PRACTICE_DIR)/$$problem/input.txt; \
	touch $(PRACTICE_DIR)/$$problem/output.txt; \
	echo "練習問題 $$problem のディレクトリを作成しました"

# クリーンアップ
.PHONY: clean
clean:
	@find . -name "*.exe" -type f -delete
	@find . -name "*.out" -type f -delete
	@echo "生成ファイルを削除しました"

# ojを使ってテストケースをダウンロード
.PHONY: download
download:
	@if [ -z "$(URL)" ]; then \
		echo "問題URLを指定してください (例: make download URL=https://atcoder.jp/contests/practice/tasks/practice_1)"; \
		exit 1; \
	fi; \
	oj d $(URL)

# ojを使ってテスト実行
.PHONY: ojtest
ojtest:
	oj t -c "go run main.go"

# 引数を無視して実行できるようにするハック
%:
	@: