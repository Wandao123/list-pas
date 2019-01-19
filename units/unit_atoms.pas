(*******************************
  file: unit_atoms.pas
  brief: Atoms data structure on the cell system
  author:
  date: 2019/01/18
  details:
*******************************)
unit unit_atoms;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, unit_cell;

type

  { TBoolean }

  TBoolean = class(TAtom)
  private
    FValue: Boolean;
  public
    constructor Create(StrValue: string);
    procedure Print(var OutputStream: TextFile); override;
  end;

  { TNumber }

  TNumber = class abstract(TAtom)
  end;

  { TInteger }

  TInteger = class(TNumber)
  private
    FValue: Integer;
  public
    constructor Create(Value: Integer);
    function Add(Params: TList): TInteger;
    function Subtract(Params: TList): TInteger;
    function Multiply(Params: TList): TInteger;
    function Divide(Params: TList): TInteger;
    function Equals(X: TInteger): TBoolean;
    procedure Print(var OutputStream: TextFile); override;
  end;

  { TString }

  TString = class(TAtom)
  private
    FStrValue: string;
  public
    constructor Create(StrValue: string);
    procedure Print(var OutputStream: TextFile); override;
  end;

  { TSymbol }

  TSymbol = class(TAtom)

  end;

implementation

{ TBoolean }

constructor TBoolean.Create(StrValue: string);
begin

end;

procedure TBoolean.Print(var OutputStream: TextFile);
begin

end;

{ TInteger }

constructor TInteger.Create(Value: Integer);
begin
  FValue := Value
end;

function TInteger.Add(Params: TList): TInteger;
begin

end;

function TInteger.Subtract(Params: TList): TInteger;
begin

end;

function TInteger.Multiply(Params: TList): TInteger;
begin

end;

function TInteger.Divide(Params: TList): TInteger;
begin

end;

function TInteger.Equals(X: TInteger): TBoolean;
begin

end;

procedure TInteger.Print(var OutputStream: TextFile);
begin
  write(OutputStream, FValue.ToString)
end;

{ TString }

constructor TString.Create(StrValue: string);
begin
  FStrValue := StrValue
end;

procedure TString.Print(var OutputStream: TextFile);
begin
  write(OutputStream, FStrValue)
end;

end.

