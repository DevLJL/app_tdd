unit uRepository.Factory;

interface

uses
  uProduct.Repository.Interfaces;

type
  IRepositoryFactory = Interface
    ['{CCBA6BCF-06D3-42AD-A4BC-0EE9138CC693}']
    function Product: IProductRepository;
  End;

  TRepositoryFactory = class(TInterfacedObject, IRepositoryFactory)
  public
    class function Make: IRepositoryFactory;

    function Product: IProductRepository;
  end;

implementation

uses
  uProduct.Repository,
  uConnection.Factory;

{ TRepositoryFactory }

class function TRepositoryFactory.Make: IRepositoryFactory;
begin
  Result := Self.Create;
end;

function TRepositoryFactory.Product: IProductRepository;
begin
  Result := TProductRepository.Make(TConnectionFactory.Make);
end;

end.
