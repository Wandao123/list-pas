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
  Head, LispNil: TList;
  plus: TPrimitiveFunction;
  zero, one, two: TInteger;
  LispTrue, LispFalse: TBoolean;
  result, env: ISExpression;

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

  LispNil := TLispNil.Create;
  LispTrue := TLispTrue.Create;
  LispFalse := TLispFalse.Create;
  env := TList.Create(TList.Create(TSymbol.Create('#t'), LispTrue),
      TList.Create(TList.Create(TSymbol.Create('#f'), LispFalse),
      TLispNil.Create));
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
    result := one.Divide(zero);
    if result <> nil then
      result.Print(OutputStream)
    else
      writeln(ErrOutput, #13#10 + 'Error: division by zero');
    result := one.EqualTo(zero);   result.Print(OutputStream);   write(OutputStream, ', ');
    result := one.LessThan(zero);   result.Print(OutputStream);   write(OutputStream, ', ');
    result := one.GreaterThan(zero);   result.Print(OutputStream);   write(OutputStream, ', ');
    result := one.LessThanOrEqualTo(zero);   result.Print(OutputStream);   write(OutputStream, ', ');
    result := one.GreaterThanOrEqualTo(zero);   result.Print(OutputStream);
    writeln(OutputStream);
  finally
    result := nil;
    zero.Free;
    Head.Free
  end;
  writeln('nil: ', LispNil = TLispNil.Create);
  writeln('true: ', (LispTrue as TBoolean) = TLispTrue.Create);
  writeln('false: ', (LispFalse as TBoolean) = TLispFalse.Create);
  readln
end.

