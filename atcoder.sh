#!/bin/bash
# atcoder.sh
# AtCoder用操作スクリプト

PRACTICE_DIR="practice"
TEMPLATE_FILE="template.go"
CONTESTS_DIR="contests"

new_contest() {
    local contest="$1"
    
    if [ -z "$contest" ]; then
        echo "エラー: コンテスト名を指定してください"
        exit 1
    fi
    
    mkdir -p "${CONTESTS_DIR}/${contest}"
    echo "コンテスト ${contest} のディレクトリを作成しました"
    
    for problem in A B C D E F; do
        mkdir -p "${CONTESTS_DIR}/${contest}/${problem}"
        cp "${TEMPLATE_FILE}" "${CONTESTS_DIR}/${contest}/${problem}/main.go"
        touch "${CONTESTS_DIR}/${contest}/${problem}/input.txt"
        touch "${CONTESTS_DIR}/${contest}/${problem}/output.txt"
        echo "問題 ${problem} のディレクトリを作成しました"
    done
}

new_problem() {
    local contest="$1"
    local problem="$2"
    
    if [ -z "$contest" ] || [ -z "$problem" ]; then
        echo "エラー: コンテスト名と問題名を指定してください (例: ABC123 A)"
        exit 1
    fi
    
    mkdir -p "${CONTESTS_DIR}/${contest}/${problem}"
    cp "${TEMPLATE_FILE}" "${CONTESTS_DIR}/${contest}/${problem}/main.go"
    touch "${CONTESTS_DIR}/${contest}/${problem}/input.txt"
    touch "${CONTESTS_DIR}/${contest}/${problem}/output.txt"
    echo "問題 ${contest} ${problem} のディレクトリを作成しました"
}

test_problem() {
    local problem_path="$1"
    
    if [ -z "$problem_path" ]; then
        echo "エラー: 問題パスを指定してください (例: practice/A)"
        exit 1
    fi
    
    local dir=$(dirname "$problem_path")
    
    cd "$dir" && go run main.go < input.txt | tee output.txt
}

run_problem() {
    local problem_path="$1"
    
    if [ -z "$problem_path" ]; then
        echo "エラー: 問題パスを指定してください (例: practice/A)"
        exit 1
    fi
    
    local dir=$(dirname "$problem_path")
    
    cd "$dir" && go run main.go
}

new_practice() {
    local url="$1"
    
    if [ -z "$url" ]; then
        echo "エラー: URLを指定してください (例: new_practice https://example.com/task/12345)"
        exit 1
    fi
    
    # URLからtask/XXXXXの部分を抽出
    local problem=$(echo "$url" | grep -o 'task/[0-9]*' | cut -d'/' -f2)
    
    if [ -z "$problem" ]; then
        echo "エラー: URLからtask IDを抽出できませんでした"
        exit 1
    fi
    
    mkdir -p "${PRACTICE_DIR}/${problem}"
    cp "${TEMPLATE_FILE}" "${PRACTICE_DIR}/${problem}/main.go"
    
    cd "${PRACTICE_DIR}/${problem}" && oj d "$url"
    echo "$url からテストケースをダウンロードしました"
    
    echo "練習問題 $problem のディレクトリを作成しました"
    echo "cd ${PRACTICE_DIR}/${problem} でディレクトリに移動できます"
}

clean() {
    find . -name "*.exe" -type f -delete
    find . -name "*.out" -type f -delete
    echo "生成ファイルを削除しました"
}

ojtest() {
    problem=$1
    project_root=$(git rev-parse --show-toplevel 2>/dev/null || echo "$PWD")
    
    if [ -z "$problem" ]; then
        # 問題が指定されていない場合は現在のディレクトリでテスト
        oj t -c "go run main.go"
    else
        # 問題が指定されている場合はプロジェクトルートから絶対パスを構築
        cd "$project_root/$problem" && oj t -c "go run main.go"
    fi
}

# コマンドライン引数に基づいて関数を実行
case "$1" in
    "new-contest")
        new_contest "$2"
        ;;
    "new-problem")
        new_problem "$2" "$3"
        ;;
    "test")
        test_problem "$2"
        ;;
    "run")
        run_problem "$2"
        ;;
    "new-practice")
        new_practice "$2" "$3"
        ;;
    "clean")
        clean
        ;;
    "ojtest")
        ojtest
        ;;
    *)
        echo "使用方法:"
        echo "  ./atcoder.sh new-contest <コンテスト名>"
        echo "  ./atcoder.sh new-problem <コンテスト名> <問題名>"
        echo "  ./atcoder.sh test <問題パス>"
        echo "  ./atcoder.sh run <問題パス>"
        echo "  ./atcoder.sh new-practice <問題名> [URL]"
        echo "  ./atcoder.sh clean"
        echo "  ./atcoder.sh ojtest"
        ;;
esac