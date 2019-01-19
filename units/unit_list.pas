(*******************************
  file: unit_list.pas
  brief: A list data structure on the cell system
  author:
  date: 2019/01/18
  details:
*******************************)
unit unit_list;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, unit_cell;

type

  { TList }

  TList = class(TInterfacedObject, ICell)
  private
    FCar: ICell;
    FCdr: ICell;
    procedure SetCar(AValue: ICell);
    procedure SetCdr(AValue: ICell);
  public
    property Car: ICell read FCar write SetCar;
    property Cdr: ICell read FCdr write SetCdr;
    procedure Print(OutputStream: TStream);
  end;

implementation

{ TList }

procedure TList.SetCar(AValue: ICell);
begin

end;

procedure TList.SetCdr(AValue: ICell);
begin

end;

procedure TList.Print(OutputStream: TStream);
begin
  OutputStream.WriteAnsiString('(');
  OutputStream.WriteAnsiString(')')
end;

end.

