(*******************************
  file: unit_cell.pas
  brief: The cell system on LISP
  author: Y. Kamijima
  date: 2019/01/14
  details:
*******************************)
unit unit_cell;

{$mode objfpc}{$H+}
//{$modeSwitch advancedRecords}

interface

uses
  Classes, SysUtils;

type
  PCell = ^TCell;
  TCell = object
  type
    TFlag = (
      flagInteger,   // Atoms
      flagString,
      flagSymbol,
      flagPair,     // a cons cell
      flagSyntax,   // functions
      flagPrimitive,
      flagClosure
    );
    TLispFunction =  function(ParamList, Env: PCell): PCell;

    TCons = record
      Car, Cdr: PCell
    end;

    TLispObject = record
    case TFlag of
      flagInteger: (IntValue: Integer);
      flagString: (StrValue: PString);
      flagSymbol: (Key: Byte);   // An index of the table of identifiers
      flagPair: (Cons: TCons);
      flagSyntax, flagPrimitive: (Func: TLispFunction);
      flagClosure: (Lambda: PCell)
    end;

  var
    Flag: TFlag;
    LispObject: TLispObject
  end;

implementation

end.

