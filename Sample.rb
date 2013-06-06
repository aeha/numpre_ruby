nm = NumberPlace.new();
nm.init();
nm.show();

System.out.println("----------------");
nm.calc();
nm.show();


class NumberPlace
  numbers = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
  
  
  def init()
    #nm = NumberPlace.new()
  
    begin
       # 全てのボックスで数字が打たれるまで繰り返す
       self.setInitNumber();
    end while (nm.sum(nm.getBox(0, 0)) == 0) ||
       (nm.sum(nm.getBox(0, 2)) == 0) ||
       (nm.sum(nm.getBox(2, 0)) == 0) ||
       (nm.sum(nm.getBox(2, 2)) == 0)
  end
  
  # 行の情報を取得
  def getRow( i )
    n = numbers[i]
    result = [ n[0], n[1], n[2], n[3] ]
    return result
  end
      
  # 縦列の情報を取得
  def getColumn( i )
    n = self.numbers
    result = [ n[0][i], n[1][i], n[2][i], n[3][i] ]
    return result
  end
  
  # 2*2のボックスごとの情報を取得
  def getBox( y, x )
    n = numbers;
    base = [ ((y / 2).floor) * 2, ((x / 2).floor) * 2]
  
    result = [ n[base[0]][base[1]], n[base[0]][base[1] + 1], n[base[0] + 1][base[1]], n[base[0] + 1][base[1] + 1]]
    return result
  end
  
  # 配列内の計算
  def sum( array )
    result = 0;
    for i in array
      result += i
    end
    return result
  end
  
  # 表示用
  def show()
    for i in numbers
      for j in numbers[i]
        printf(numbers[i][j] + ",")
      end
      printf("\n")
    end
  end

  # ランダムに4点打つ
  def setInitNumber()
    numbers = int[4][4];
    dots1 = new ArrayList<Integer>();
          ArrayList<Integer> dots2 = new ArrayList<Integer>();
          for(int i = 0; i < 4; i++){
              dots1.add(i);
              dots2.add(i);
          }
  
          // ランダムな順序にする
          Collections.shuffle(dots1);
          Collections.shuffle(dots2);
  
          for(int i = 0; i < 4; i++){
              numbers[dots1.get(i)][dots2.get(i)] = i + 1;
          }
          return true;
      }
  
      // 作成メソッド
    public static void calc(){
      search(0, 0, numbers);
    }
  
    /**
     * 左上から右下方向に解を探索します。
     * 引数:numbersを参照渡しにして、解はnumbersに格納されます。
     *
     * @param x
     * @param y
     * @param numbers
     * @return 解が見つかった場合その数字、見つからなかった場合0
     */
    public static int search(int x, int y, int[][] numbers){
      // 全て探索した場合、0以外の数字を返して再帰を終了する
      if( y >= numbers.length ){
        return 1;
      }
  
      if( numbers[y][x] == 0 ){
        // 探索場所に数字が埋められていない場合、解を探索
        for( int ans = 1; ans <= 4; ans++ ){
          if( isOkMasu(y, x, ans)
              && isOkYoko(y, ans)
              && isOkTate(x, ans) ){
  
            // 解を仮置き
            numbers[y][x] = ans;
            if( x + 1 < numbers[y].length ){
              // 横方向の終端に達していない場合、横方向に探索
              if( search( x + 1, y, numbers ) != 0 ){
                return numbers[y][x];
              } else {
                // 解が見つからなかった場合、仮置きした解を初期値に戻し、再度探索する
                numbers[y][x] = 0;
              }
            } else {
              // 横方向の終端に達した場合、次の行を探索
              if( search( 0, y + 1, numbers ) != 0 ){
                return numbers[y][x];
              } else {
                numbers[y][x] = 0;
              }
            }
          }
        }
      } else {
        // 探索場所に数字が埋められている場合、次の解を探索
        // 数字が確定している為、解が見つからなかったかどうかは判定しない
        if( x + 1 < numbers[y].length ){
          return search( x + 1, y, numbers );
        } else {
          return search( 0, y + 1, numbers );
        }
      }
  
      // 解が見つからなかった場合は、探索をやり直す為、0を返却する
      return 0;
    }
  
  
    /**
     * n列目の立て業にnumの値がセットできるかを調べます。
     * @param n 列ナンバー
     * @param num 対象の候補数
     */
    public static boolean isOkTate(int n, int num){
      int[] tate = getColumn(n);
      for( int i = 0; i < tate.length; i++ ){
        // まだ値が設定されていない場合は読み飛ばし
        if( tate[i] == 0 ){
          continue;
        }
  
        if( num == tate[i] ){
          return false;
        }
      }
      return true;
    }
  
    /**
     * n行目の横列に、numの値がセット可能であるかを調べます。
     * @param n 行ナンバー
     * @param num 対象の候補数
     */
    public static boolean isOkYoko(int n, int num){
      int[] yoko = getRow(n);
      for( int i = 0; i < yoko.length; i++ ){
        // まだ値が設定されていない場合は読み飛ばし
        if( yoko[i] == 0 ){
          continue;
        }
  
        if( num == yoko[i] ){
          return false;
        }
      }
      return true;
    }
  
    /**
     * n行目の横列に、numの値がセット可能であるかを調べます。
     * @param n 行ナンバー
     * @param num 対象の候補数
     */
    public static boolean isOkMasu(int x, int y, int num){
      int[] masu = getBox(x, y);
      for( int i = 0; i < masu.length; i++ ){
        // まだ値が設定されていない場合は読み飛ばし
        if( masu[i] == 0 ){
          continue;
        }
  
        if( num == masu[i] ){
          return false;
        }
      }
      return true;
    }
  }
  
  
  
end