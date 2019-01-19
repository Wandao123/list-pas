(*******************************
  file: unit_functions.pas
  brief: LISP functions data structure on the cell system
  author:
  date: 2019/01/18
  details:
*******************************)
unit unit_functions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, unit_cell;

type

  { TLispFunction }

  TLispFunction = class abstract(TInterfacedObject, ISExpression)
  public
    procedure Print(var OutputStream: TextFile); virtual; abstract;
  end;

  { TSpecialForm }

  TSpecialForm = class(TLispFunction)
  private
    FFunction: function(ParamList, Env: TList): ISExpression;
  public
    procedure Print(var OutputStream: TextFile); override;
  end;

  { TPrimitiveFunction }

  TPrimitiveFunction = class(TLispFunction)
  private
    FFunction: function(ParamList, Env: TList): ISExpression;
  public
    procedure Print(var OutputStream: TextFile); override;
  end;

  { TClosure }

  TClosure = class(TLispFunction)
  private
    FLambda: TList;
  public
    procedure Print(var OutputStream: TextFile); override;
  end;

implementation

{ TClosure }

procedure TClosure.Print(var OutputStream: TextFile);
begin
  write(OutputStream, '#<closure>')
end;

{ TPrimitiveFunction }

procedure TPrimitiveFunction.Print(var OutputStream: TextFile);
begin
  write(OutputStream, '#<primitive>')
end;

{ TSpecialForm }

procedure TSpecialForm.Print(var OutputStream: TextFile);
begin
  write(OutputStream, '#<syntax>')
end;

end.
