(*******************************
  file: lisp.lpr
  brief: LISP interpreter made with Object Pascal
  author:
  date: 2019/01/14
  details:
*******************************)
program lisp;

uses
  Classes, SysUtils, IOStream, unit_cell, unit_atoms, unit_functions;

var
  OutputStream: TStream;
  Cells: array [0..2] of ISExpression;
  plus, one, two: ISExpression;
  a, b: TList;

begin
  OutputStream := TIOStream.Create(iosOutput);
  plus := TPrimitiveFunction.Create;
  one := TInteger.Create(1);
  two := TInteger.Create(2);
  Cells[2] := TList.Create(two, TLispNil.GetInstance);
  Cells[1] := TList.Create(one, Cells[2]);
  Cells[0] := TList.Create(plus, Cells[1]);
  try
    Cells[0].Print(OutputStream);
    OutputStream.writeAnsiString(#13#10);
    a := TLispNil.GetInstance;
    b := TLispNil.GetInstance;
    writeln(a = b);
  finally
    OutputStream.Free;
  end;
  readln
end.

