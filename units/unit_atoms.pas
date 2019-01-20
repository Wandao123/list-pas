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
    function Add(X: TInteger): TInteger;
    function Subtract(X: TInteger): TInteger;
    function Multiply(X: TInteger): TInteger;
    function Divide(X: TInteger): TInteger;
    function Equals(X: TInteger): TBoolean;
    procedure Print(var OutputStream: TextFile); override;
    property Value: Integer read FValue;
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

function TInteger.Add(X: TInteger): TInteger;
begin
  Result := TInteger.Create(FValue + X.Value)
end;

function TInteger.Subtract(X: TInteger): TInteger;
begin
  Result := TInteger.Create(FValue - X.Value)
end;

function TInteger.Multiply(X: TInteger): TInteger;
begin
  Result := TInteger.Create(FValue * X.Value)
end;

{ ToDo: Implementing a fraction class, make this function return such class. }
/// <returns>
/// nil if division by zero occurs; otherwise, the quotient of Self.FValue and X.Value.
/// </returns>
function TInteger.Divide(X: TInteger): TInteger;
begin
  if X.Value = 0 then
    Result := nil
  else
    Result := TInteger.Create(FValue div X.Value)
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

