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
    procedure Print(OutputStream: TStream); virtual; abstract;
  end;

  { TSpecialForm }

  TSpecialForm = class(TLispFunction)
  private
    FFunction: function(ParamList, Env: TList): ISExpression;
  public
    procedure Print(OutputStream: TStream); override;
  end;

  { TPrimitiveFunction }

  TPrimitiveFunction = class(TLispFunction)
  private
    FFunction: function(ParamList, Env: TList): ISExpression;
  public
    procedure Print(OutputStream: TStream); override;
  end;

  { TClosure }

  TClosure = class(TLispFunction)
  private
    FLambda: TList;
  public
    procedure Print(OutputStream: TStream); override;
  end;

implementation

{ TClosure }

procedure TClosure.Print(OutputStream: TStream);
begin
  OutputStream.Write(PChar('#<closure>')^, '#<closure>'.Length)
end;

{ TPrimitiveFunction }

procedure TPrimitiveFunction.Print(OutputStream: TStream);
begin
  OutputStream.Write(PChar('#<primitive>')^, '#<primitive>'.Length)
end;

{ TSpecialForm }

procedure TSpecialForm.Print(OutputStream: TStream);
begin
  OutputStream.Write(PChar('#<syntax>')^, '#<syntax>'.Length)
end;

end.
