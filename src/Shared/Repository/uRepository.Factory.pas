unit uRepository.Factory;

interface

uses
  uProduct.Repository.Interfaces,
  uZLConnection.Interfaces,
  uZLConnection.Types;

type
  IRepositoryFactory = Interface
    ['{CCBA6BCF-06D3-42AD-A4BC-0EE9138CC693}']
    function Product: IProductRepository;
  End;

  TRepositoryFactory = class(TInterfacedObject, IRepositoryFactory)
  private
    FConn: IZLConnection;
    FRepoType: TZLRepositoryType;
    FDriverDB: TZLDriverDB;
    constructor Create(AConn: IZLConnection; ARepoType: TZLRepositoryType; ADriverDB: TZLDriverDB);
  public
    class function Make(AConn: IZLConnection = nil; ARepoType: TZLRepositoryType = rtDefault; ADriverDB: TZLDriverDB = ddDefault): IRepositoryFactory;

    function Product: IProductRepository;
  end;

implementation

uses
  uProduct.Repository,
  uConnection.Factory,
  uEnv;

{ TRepositoryFactory }

constructor TRepositoryFactory.Create(AConn: IZLConnection; ARepoType: TZLRepositoryType; ADriverDB: TZLDriverDB);
begin
  inherited Create;

  // Driver do Banco de Dados
  FDriverDB := ADriverDB;
  if (FDriverDB = ddDefault) then
    FDriverDB := Env.DriverDB;

  // Tipo de Repositório
  FRepoType := ARepoType;
  if (FRepoType = rtDefault) then
    FRepoType := Env.DefaultRepoType;

  // Conexão
  case Assigned(AConn) of
    True:  FConn := AConn;
    False: FConn := TConnectionFactory.Make;
  end;
end;

class function TRepositoryFactory.Make(AConn: IZLConnection = nil; ARepoType: TZLRepositoryType = rtDefault; ADriverDB: TZLDriverDB = ddDefault): IRepositoryFactory;
begin
  Result := Self.Create(AConn, ARepoType, ADriverDB);
end;

function TRepositoryFactory.Product: IProductRepository;
begin
  case FRepoType of
    rtSQL:    Result := TProductRepository.Make(FConn);
    rtMemory: {Result := TProductRepositoryMemory.Make};
  end;
end;

end.
