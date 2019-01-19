(*******************************
  file: unit_cell.pas
  brief: The cell system on LISP
  author:
  date: 2019/01/14
  details:
*******************************)
unit unit_cell;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { ISExpression }

  ISExpression = interface
    procedure Print(OutputStream: TStream);
  end;

  { TCell }

  TCell = class(TInterfacedObject)
  private
    FCar: ISExpression;
    FCdr: ISExpression;
  public
    constructor Create;
    constructor Create(Car, Cdr: ISExpression);
    destructor Destroy; override;
    property Car: ISExpression read FCar;
    property Cdr: ISExpression read FCdr;
  end;

  { TAtom }

  TAtom = class abstract(TInterfacedObject, ISExpression)
  public
    procedure Print(OutputStream: TStream); virtual; abstract;
  end;

  { TList }

  TList = class(TCell, ISExpression)
  public
    procedure Print(OutputStream: TStream); virtual;
  end;

  { TLispNil }

  TLispNil = class(TList)
  private
    constructor Create;
    class var FInstance: TLispNil;
  public
    class function GetInstance: TLispNil;
    procedure Print(OutputStream: TStream); override;
    class procedure ReleaseInstance;
  end;

implementation

{ TCell }

constructor TCell.Create;
begin
  FCar := TLispNil.GetInstance;
  FCdr := TLispNil.GetInstance
end;

constructor TCell.Create(Car, Cdr: ISExpression);
begin
  Self.FCar := Car;
  Self.FCdr := Cdr
end;

destructor TCell.Destroy;
begin
  inherited
end;

{ TLispNil }

constructor TLispNil.Create;
begin
  // Do nothing
end;

class function TLispNil.GetInstance: TLispNil;
begin
  if not Assigned(FInstance) then
    FInstance := Self.Create;
  Result := FInstance
end;

procedure TLispNil.Print(OutputStream: TStream);
begin
  OutputStream.Write(PChar('(')^, SizeOf(Char));
  OutputStream.Write(PChar(')')^, SizeOf(Char))
end;

class procedure TLispNil.ReleaseInstance;
begin
  if Assigned(FInstance) then
    FInstance.Free
end;

{ TList }

procedure TList.Print(OutputStream: TStream);
var
  CurrentCell: TCell;
begin
  OutputStream.Write(PChar('(')^, SizeOf(Char));
  CurrentCell := Self;
  while True do
  begin
    CurrentCell.Car.Print(OutputStream);
    if CurrentCell.Cdr = ISExpression(TLispNil.GetInstance) then
    begin
      OutputStream.Write(PChar(')')^, SizeOf(Char));
      break
    end
    else if CurrentCell.Cdr is TAtom then
    begin
      write(StdOut, ' . ');           // TODO:
      CurrentCell.Cdr.Print(OutputStream);
      write(StdOut, ')');
      break
    end
    else
    begin
      OutputStream.Write(PChar(' ')^, SizeOf(Char));
      CurrentCell := CurrentCell.Cdr as TList;
    end
  end
end;

initialization
  TLispNil.GetInstance;

finalization
  TLispNil.ReleaseInstance;

end.

