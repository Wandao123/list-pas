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
  Cells: array [0..2] of ISExpression;
  plus, one, two: ISExpression;

begin
  OutputStream := Output;    // Asign output of this program to stdout.
  plus := TPrimitiveFunction.Create;   plus.Print(OutputStream);
  one := TInteger.Create(1);   one.Print(OutputStream);
  two := TInteger.Create(2);   two.Print(OutputStream);
  writeln(OutputStream);
  //Cells[2] := TList.Create(one, two);
  //Cells[1] := TList.Create;
  //Cells[1].Print(OutputStream);
  Cells[2] := TList.Create(two, TLispNil.Create);
  Cells[1] := TList.Create(one, Cells[2]);
  Cells[0] := TList.Create(plus, Cells[1]);
  Cells[0].Print(OutputStream);
  writeln(OutputStream);
  //readln
end.

