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
    procedure Print(var OutputStream: TextFile);
  end;

  { TCell }

  TCell = class(TInterfacedObject)
  private
    FCar: ISExpression;
    FCdr: ISExpression;
  public
    constructor Create;
    constructor Create(Car, Cdr: ISExpression);
    property Car: ISExpression read FCar;
    property Cdr: ISExpression read FCdr;
  end;

  { TAtom }

  TAtom = class abstract(TInterfacedObject, ISExpression)
  public
    procedure Print(var OutputStream: TextFile); virtual; abstract;
  end;

  { TList }

  TList = class(TCell, ISExpression)
  public
    procedure Print(var OutputStream: TextFile); virtual;
  end;

  { TLispNil }

  TLispNil = class(TList)
  private
    constructor Init;
    // When call the inherited destructor, an segmentation error occurs.
    // How should FInstance be released?
    class var FInstance: TLispNil;
  public
    class function Create: TLispNil;
    procedure Print(var OutputStream: TextFile); override;
  end;

implementation

{ TCell }

constructor TCell.Create;
begin
  FCar := TLispNil.Create;
  FCdr := TLispNil.Create
end;

constructor TCell.Create(Car, Cdr: ISExpression);
begin
  Self.FCar := Car;
  Self.FCdr := Cdr
end;

{ TLispNil }

constructor TLispNil.Init;
begin
  inherited Create(nil, nil)
end;

class function TLispNil.Create: TLispNil;
begin
  if not Assigned(FInstance) then
    FInstance := TLispNil.Init;
  Result := FInstance
end;

procedure TLispNil.Print(var OutputStream: TextFile);
begin
  write(OutputStream, '()')
end;

{ TList }

procedure TList.Print(var OutputStream: TextFile);
var
  CurrentCell: TList;
begin
  write(OutputStream, '(');
  CurrentCell := Self;
  while True do
  begin
    CurrentCell.Car.Print(OutputStream);
    if (CurrentCell.Cdr as TList) = TLispNil.Create then
    begin
      write(OutputStream, ')');
      break
    end
    else if CurrentCell.Cdr is TAtom then
    begin
      write(OutputStream, ' . ');
      CurrentCell.Cdr.Print(OutputStream);
      write(OutputStream, ')');
      break
    end
    else
    begin
      write(OutputStream, ' ');
      CurrentCell := CurrentCell.Cdr as TList;
    end
  end
end;

end.

