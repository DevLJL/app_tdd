unit uProduct.Index.UseCase;

interface

uses
  uProduct.Repository.Interfaces,
  uIndexResult;

type
  IProductIndexUseCase = Interface
    ['{9811D011-B4C0-4156-823B-6129D35832BC}']
    function Execute: IIndexResult;
  End;

  TProductIndexUseCase = class(TInterfacedObject, IProductIndexUseCase)
  private
    FRepository: IProductRepository;
    constructor Create(const ARepository: IProductRepository);
  public
    class function Make(const ARepository: IProductRepository): IProductIndexUseCase;
    function Execute: IIndexResult;
  end;

implementation

{ TProductIndexUseCase }

uses
  uEntityValidation.Exception,
  System.SysUtils;

constructor TProductIndexUseCase.Create(const ARepository: IProductRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TProductIndexUseCase.Execute: IIndexResult;
begin
  Result := FRepository.Index;
end;

class function TProductIndexUseCase.Make(const ARepository: IProductRepository): IProductIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
