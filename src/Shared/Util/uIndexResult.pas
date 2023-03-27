unit uIndexResult;

interface

uses
  uZLMemTable.Interfaces;

type
  IIndexResult = Interface
    ['{4B85FE74-FD97-4965-BEA0-70D83695D1F3}']
    function Data: IZLMemTable; overload;
    function Data(AValue: IZLMemTable): IIndexResult; overload;
  End;

  TIndexResult = class(TInterfacedObject, IIndexResult)
  private
    FData: IZLMemTable;
    constructor Create;
  public
    class function Make: IIndexResult;
    function Data: IZLMemTable; overload;
    function Data(AValue: IZLMemTable): IIndexResult; overload;
  end;

implementation

{ TIndexResult }

uses
  uMemTable.Factory;

constructor TIndexResult.Create;
begin
  inherited Create;
  FData := TMemTableFactory.Make;
end;

function TIndexResult.Data: IZLMemTable;
begin
  Result := FData;
end;

function TIndexResult.Data(AValue: IZLMemTable): IIndexResult;
begin
  Result := Self;
  FData := AValue;
end;

class function TIndexResult.Make: IIndexResult;
begin
  Result := Self.Create;
end;

end.
