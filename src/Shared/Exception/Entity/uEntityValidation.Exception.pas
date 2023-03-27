unit uEntityValidation.Exception;

interface

uses
  System.SysUtils;

type
  TEntityValidationException = class(Exception)
  private
    FDataName: string;
  public
    constructor Create(const DataName: string);
    property DataName: string read FDataName;
  end;

implementation

{ EMissingData }

constructor TEntityValidationException.Create(const DataName: string);
begin
  inherited Create(DataName);
  FDataName := DataName;
end;

end.
