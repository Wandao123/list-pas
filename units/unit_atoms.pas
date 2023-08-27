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
  Classes, SysUtils,{ Math,} unit_cell;

type

  { TBoolean }

  TBoolean = class abstract(TAtom)
  end;

  { TLispTrue }

  TLispTrue = class(TBoolean)
  // This class is implemented as the singleton pattern like TLispNil,
  // so that this has a same problem as TLispNil.
  private
    constructor Init;
    class var FInstance: TLispTrue;
  public
    class function Create: TLispTrue;
    procedure Print(var OutputStream: TextFile); override;
  end;

  { TLispFalse }

  TLispFalse = class(TBoolean)
  // This class is implemented as the singleton pattern like TLispNil,
  // so that this has a same problem as TLispNil.
  private
    constructor Init;
    class var FInstance: TLispFalse;
  public
    class function Create: TLispFalse;
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
    function EqualTo(X: TInteger): TBoolean;
    function LessThan(X: TInteger): TBoolean;
    function GreaterThan(X: TInteger): TBoolean;
    function LessThanOrEqualTo(X: TInteger): TBoolean;
    function GreaterThanOrEqualTo(X: TInteger): TBoolean;
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
  private
    FName: string;
  public
    constructor Create(Name: string);
    procedure Print(var OutputStream: TextFile); override;
  end;

implementation

{ TSymbol }

constructor TSymbol.Create(Name: string);
begin
  FName := Name
end;

procedure TSymbol.Print(var OutputStream: TextFile);
begin
  write(OutputStream, FName)
end;

{ TLispFalse }

constructor TLispFalse.Init;
begin
  inherited Create
end;

class function TLispFalse.Create: TLispFalse;
begin
 if not Assigned(FInstance) then
   FInstance := TLispFalse.Init;
 Result := FInstance
end;

procedure TLispFalse.Print(var OutputStream: TextFile);
begin
  write(OutputStream, '#f')
end;

{ TLispTrue }

constructor TLispTrue.Init;
begin
  inherited Create
end;

class function TLispTrue.Create: TLispTrue;
begin
  if not Assigned(FInstance) then
   FInstance := TLispTrue.Init;
 Result := FInstance
end;

procedure TLispTrue.Print(var OutputStream: TextFile);
begin
  write(OutputStream, '#t')
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

function TInteger.EqualTo(X: TInteger): TBoolean;
begin
  if FValue = X.Value then
    Result := TLispTrue.Create
  else
    Result := TLispFalse.Create
end;

function TInteger.LessThan(X: TInteger): TBoolean;
begin
  if FValue < X.Value then
    Result := TLispTrue.Create
  else
    Result := TLispFalse.Create
end;

function TInteger.GreaterThan(X: TInteger): TBoolean;
begin
  if FValue > X.Value then
    Result := TLispTrue.Create
  else
    Result := TLispFalse.Create
end;

function TInteger.LessThanOrEqualTo(X: TInteger): TBoolean;
begin
  if FValue <= X.Value then
    Result := TLispTrue.Create
  else
    Result := TLispFalse.Create
end;

function TInteger.GreaterThanOrEqualTo(X: TInteger): TBoolean;
begin
  if FValue >= X.Value then
    Result := TLispTrue.Create
  else
    Result := TLispFalse.Create
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

