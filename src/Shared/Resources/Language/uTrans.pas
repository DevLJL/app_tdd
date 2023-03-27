unit uTrans;

interface

uses
  SysUtils,
  System.Classes;

type
  TLanguageType = (ltPtBr, ltEnUs);
  TTrans = class
  private
    FLanguageType: TLanguageType;
  public
    constructor Create;

    function FieldIsRequired(const AValue: String): String;
    function NumberIsLessThan(const ALabelNumber, AValueNumber: String): String;
    function DataInsertionFailure: String;
  end;

var
  Trans: TTrans;

implementation

{ TTrans }

uses
  uEnv;

constructor TTrans.Create;
begin
  if (Env.Language = 'PT-BR') then FLanguageType := TLanguageType.ltPtBr;
  if (Env.Language = 'EN-US') then FLanguageType := TLanguageType.ltEnUs;
end;

function TTrans.DataInsertionFailure: String;
begin
  case FLanguageType of
    ltPtBr: Result := 'Falha na inserção dos dados.';
    ltEnUs: Result := 'Data insertion failure.';
  end;
end;

function TTrans.FieldIsRequired(const AValue: String): String;
begin
  case FLanguageType of
    ltPtBr: Result := Format('O campo [%s] é obrigatório.', [AValue]);
    ltEnUs: Result := Format('The field [%s] is required.', [AValue]);
  end;
end;

function TTrans.NumberIsLessThan(const ALabelNumber, AValueNumber: String): String;
begin
  case FLanguageType of
    ltPtBr: Result := Format('O número [%s] é inferior a %s.', [ALabelNumber, AValueNumber]);
    ltEnUs: Result := Format('The number [%s] is less than %s.', [ALabelNumber, AValueNumber]);
  end;
end;

initialization
  Trans := TTrans.Create();

finalization
  FreeAndNil(TRANS);

end.

