(*******************************
  file: lisp.lpr
  brief: LISP interpreter made with Object Pascal
  author:
  date: 2019/01/14
  details:
*******************************)
program lisp;

uses
  Classes, SysUtils, unit_cell, unit_atoms, unit_functions;

var
  OutputStream: TextFile;
  Head: TList;
  plus: TPrimitiveFunction;
  zero, one, two: TInteger;
  result: ISExpression;

begin
  // 未開放のクラスがあるかどうかを確認できる。ログはheap.trcに記録される。
  // ファイルを参照するときは View --> Leaks and Traces で表示されるビューアを利用する。
  {$if declared(UseHeapTrace)}
  if UseHeapTrace then
  begin
    if FileExists('heap.trc') then
      DeleteFile('heap.trc');
    SetHeapTraceOutput('heap.trc')
  end;
  {$endif}

  OutputStream := Output;    // Asign output of this program to stdout.
  try
    plus := TPrimitiveFunction.Create;   plus.Print(OutputStream);
    zero := TInteger.Create(0);   zero.Print(OutputStream);
    one := TInteger.Create(1);   one.Print(OutputStream);
    two := TInteger.Create(2);   two.Print(OutputStream);
    writeln(OutputStream);

    Head := TList.Create(plus, TList.Create(one, TList.Create(two, TLispNil.Create)));
    Head.Print(OutputStream);
    writeln(OutputStream);

    result := one.Add(two);   result.Print(OutputStream);  write(OutputStream, ', ');
    result := one.Subtract(two);   result.Print(OutputStream);   write(OutputStream, ', ');
    result := one.Multiply(two);   result.Print(OutputStream);   write(OutputStream, ', ');
    try
      result := one.Divide(two);   result.Print(OutputStream);   write(OutputStream, ', ');
      // 例外が投げられるとresultには何も代入されない。そのため、Divideの返り値が解放されずに残る。
      result := one.Divide(zero);   result.Print(OutputStream)
    except
      on E: Exception do
        writeln(ErrOutput, #13#10 + 'Error: ' + E.Message)
    end;
    writeln(OutputStream)
  finally
    zero.Free;
    // Headが解放されると、そのフィールドのinterface型変数にはnilが代入される。このとき、interfaceの仕様により、
    // interface型変数に入っていたクラスも解放される。これがリストの末尾まで繰り返されるので、Headを解放すると
    // 結果的にplus, one, two, TLispNil.FInstanceも解放される。その一方で、Headから辿れる状態でplus, one, two,
    // TLispNil.FInstanceのどれか一つでも解放しようとすると、二重解放になる。
    Head.Free
  end;
  readln
end.

