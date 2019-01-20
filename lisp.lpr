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
    result := one.Divide(two);   result.Print(OutputStream);   write(OutputStream, ', ');
    writeln(OutputStream);
    result := one.Divide(zero);
    if result <> nil then
      result.Print(OutputStream)
    else
      writeln(ErrOutput, #13#10 + 'Error: division by zero')
  finally
    zero.Free;
    Head.Free
  end;
  readln
end.

