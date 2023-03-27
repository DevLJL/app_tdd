unit uEnv;

interface

uses
  SysUtils,
  IniFiles,
  uZLConnection.Types,
  System.Classes;

type
  TEnv = class(TIniFile)
  private
    FStationId: Integer;
    procedure SetDatabase(const Value: String);
    procedure SetPassword(const Value: String);
    procedure SetPort(const Value: String);
    procedure SetServer(const Value: String);
    procedure SetUserName(const Value: String);
    procedure SetVendorLib(const Value: String);
    function GetDatabase: String;
    function GetPassword: String;
    function GetPort: String;
    function GetServer: String;
    function GetUserName: String;
    function GetVendorLib: String;
    procedure SetDriver(const Value: String);
    function GetDriver: String;
    function GetDefaultConnLibType: TZLConnLibType;
    procedure SetDefaultConnLibType(const Value: TZLConnLibType);
    function GetDefaultRepoType: TZLRepositoryType;
    procedure SetDefaultRepoType(const Value: TZLRepositoryType);
    procedure SetStationId(const Value: Integer);
    function GetStationId: Integer;
    function GetLanguage: String;
    procedure SetLanguage(const Value: String);
  public
    property Database: String read GetDatabase write SetDatabase;
    property UserName: String read GetUserName write SetUserName;
    property Password: String read GetPassword write SetPassword;
    property Server: String read GetServer write SetServer;
    property Port: String read GetPort write SetPort;
    property VendorLib: String read GetVendorLib write SetVendorLib;
    property Driver: String read GetDriver write SetDriver;
    property DefaultConnLibType: TZLConnLibType read GetDefaultConnLibType write SetDefaultConnLibType;
    property DefaultRepoType: TZLRepositoryType read GetDefaultRepoType write SetDefaultRepoType;
    property StationId: Integer read GetStationId write SetStationId;
    function DriverDB: TZLDriverDB;
    property Language: String read GetLanguage write SetLanguage;
    procedure CreateFileIfNotExists;
    class function EnvName: String;
  end;

var
  ENV: TEnv;
const
  ENV_PRODUCTION = 'env.ini';
  ENV_TEST = 'env_test.ini';

implementation

{ TEnv }

procedure TEnv.CreateFileIfNotExists;
begin
  // Criar arquivo se não existir
  if not FileExists(EnvName) then
  begin
    SetDatabase('dbase');
    SetUserName('root');
    SetPassword('root');
    SetServer('localhost');
    SetPort('3151');
    SetVendorLib('libmysql.dll');
    SetDriver('MySQL');
    SetDefaultConnLibType(TZLConnLibType.ctFireDAC);
    SetDefaultRepoType(TZLRepositoryType.rtSQL);
    SetStationId(1);
    SetLanguage('PT-BR');
  end;
end;

function TEnv.DriverDB: TZLDriverDB;
var
  lDriverStr: String;
begin
  lDriverStr := GetDriver.Trim.ToUpper;
  if (lDriverStr = 'MYSQL') then
    Result := TZLDriverDB.ddMySql;
end;

class function TEnv.EnvName: String;
begin
{$IFDEF TEST_FRAMEWORK}
  Result := ENV_TEST;
{$ELSE}
  Result := ENV_PRODUCTION;
{$ENDIF}
end;

function TEnv.GetDatabase: String;
begin
  Result := ReadString('CONNECTION','DATABASE','');
end;

function TEnv.GetDefaultConnLibType: TZLConnLibType;
var
  lLibType: String;
begin
  lLibType := ReadString('CONNECTION','LIBTYPE','FIREDAC').Trim.ToUpper;
  if (lLibType = 'FIREDAC') then
    Result := TZLConnLibType.ctFireDAC;
end;

function TEnv.GetDefaultRepoType: TZLRepositoryType;
var
  lRepoTypeStr: String;
begin
  lRepoTypeStr := ReadString('CONNECTION','REPOTYPE','SQL').Trim.ToUpper;
  if (lRepoTypeStr = 'SQL') then
    Result := TZLRepositoryType.rtSQL;
end;

function TEnv.GetDriver: String;
begin
  Result := ReadString('CONNECTION','DRIVER','');
end;

function TEnv.GetLanguage: String;
begin
  Result := ReadString('RESOURCE','LANGUAGE','').ToUpper;
end;

function TEnv.GetPassword: String;
begin
  Result := ReadString('CONNECTION','PASSWORD','');
end;

function TEnv.GetPort: String;
begin
  Result := ReadString('CONNECTION','PORT','');
end;

function TEnv.GetServer: String;
begin
  Result := ReadString('CONNECTION','SERVER','');
end;

function TEnv.GetStationId: Integer;
begin
  Result := ReadInteger('GENERAL','STATION_ID',1);
end;

function TEnv.GetUserName: String;
begin
  Result := ReadString('CONNECTION','USERNAME','');
end;

function TEnv.GetVendorLib: String;
begin
  Result := ReadString('CONNECTION','VENDORLIB','');
end;

procedure TEnv.SetDatabase(const Value: String);
begin
  WriteString('CONNECTION','DATABASE',Value);
end;

procedure TEnv.SetDefaultConnLibType(const Value: TZLConnLibType);
begin
  case Value of
    ctFireDAC: WriteString('CONNECTION','LIBTYPE','FIREDAC');
  end;
end;

procedure TEnv.SetDefaultRepoType(const Value: TZLRepositoryType);
var
  lRepoTypeStr: String;
begin
  case Value of
    rtDefault, rtSQL: lRepoTypeStr := 'SQL';
    rtMemory:         lRepoTypeStr := 'MEMORY';
    rtORMBr:          lRepoTypeStr := 'ORMBR';
    rtAurelius:       lRepoTypeStr := 'AURELIUS';
  end;
  WriteString('CONNECTION','REPOTYPE', lRepoTypeStr);
end;

procedure TEnv.SetDriver(const Value: String);
begin
  WriteString('CONNECTION','DRIVER',Value);
end;

procedure TEnv.SetLanguage(const Value: String);
begin
  WriteString('RESOURCE','LANGUAGE',Value);
end;

procedure TEnv.SetPassword(const Value: String);
begin
  WriteString('CONNECTION','PASSWORD',Value);
end;

procedure TEnv.SetPort(const Value: String);
begin
  WriteString('CONNECTION','PORT',Value);
end;

procedure TEnv.SetServer(const Value: String);
begin
  WriteString('CONNECTION','SERVER',Value);
end;

procedure TEnv.SetStationId(const Value: Integer);
begin
  WriteInteger('GENERAL','STATION_ID',Value);
end;

procedure TEnv.SetUserName(const Value: String);
begin
  WriteString('CONNECTION','USERNAME',Value);
end;

procedure TEnv.SetVendorLib(const Value: String);
begin
  WriteString('CONNECTION','VENDORLIB',Value);
end;

initialization
  ENV := TEnv.Create(ExtractFilePath(ParamStr(0)) + TEnv.EnvName);
  ENV.CreateFileIfNotExists;

finalization
  FreeAndNil(ENV);

end.

