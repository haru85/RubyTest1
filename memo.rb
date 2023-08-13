require "csv"

def select_operate()
    puts "1(新規でメモを作成) 2(既存のメモを編集する)"
    operate_number = gets.chomp.to_i
    puts "--------------------------------------"

    if not operate_number == 1 || operate_number == 2
        while not(operate_number == 1 || operate_number == 2) do
            puts "1 または 2 を入力して下さい"
            operate_number = gets.chomp.to_i
            puts "--------------------------------------"
        end
    end

    if operate_number == 1
        create_memo_file()
    elsif operate_number == 2
        edit_memo_file()
    end
end

def create_memo_file()
    puts "新規でメモを作成します"
    puts "拡張子を除いたファイル名を記載して下さい"
    puts ""
    file_name = gets.chomp.to_s
    puts "--------------------------------------"

    if File.exist?("#{file_name}.csv")
        while File.exist?("#{file_name}.csv") do
            puts "a"
            puts "指定されたファイル名はすでに存在しています"
            puts "操作選択に戻ります"
            select_operate()
        end
    end

    p "メモしたい内容を記載して下さい"
    p "完了したらEnterを押してから、Ctrl＋Dを押します"
    puts ""

    memo = readlines(chomp: true)
    puts "--------------------------------------"

    new_memo = CSV.open("#{file_name}.csv", 'w') do |csv|
        memo.each do |line|
            csv << [line]
        end
    end

    puts "#{file_name}.csvを保存しました"
    
end

def edit_memo_file()
    puts "既存のメモを編集します"
    puts "拡張子を除いたファイル名を記載して下さい"
    puts ""
    file_name = gets.chomp.to_s
    puts "--------------------------------------"

    if not File.exist?("#{file_name}.csv")
        while File.exist?("#{file_name}.csv")==false do
            puts "指定されたファイル名は存在しません"
            puts "操作選択に戻ります"
            select_operate()
        end
    end

    puts "現在のメモの内容は下記の通りです"
    puts ""
    puts CSV.read("#{file_name}.csv")
    puts ""
    puts "--------------------------------------"

    p "新しい内容を記載して下さい"
    p "完了したらEnterを押してから、Ctrl＋Dを押します"
    puts ""

    memo = readlines(chomp: true)
    puts "--------------------------------------"

    new_memo = CSV.open("#{file_name}.csv", 'w') do |csv|
        memo.each do |line|
            csv << [line]
        end
    end

    puts "#{file_name}.csvを上書き保存しました"

end

select_operate()