unit uProduct.Show.UseCase;

interface

uses
  uProduct.Repository.Interfaces,
  uProduct.DTO;

type
  IProductShowUseCase = Interface
    ['{199D5379-FB97-45D0-98B1-D041FCAE34E1}']
    function Execute(const AId: Int64): TProductDTO;
  End;

  TProductShowUseCase = class(TInterfacedObject, IProductShowUseCase)
  private
    FRepository: IProductRepository;
    constructor Create(const ARepository: IProductRepository);
  public
    class function Make(const ARepository: IProductRepository): IProductShowUseCase;
    function Execute(const AId: Int64): TProductDTO;
  end;

implementation

{ TProductShowUseCase }

uses
  uEntityValidation.Exception,
  System.SysUtils,
  uProduct,
  uProduct.Mapper,
  uSmartPointer;

constructor TProductShowUseCase.Create(const ARepository: IProductRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TProductShowUseCase.Execute(const AId: Int64): TProductDTO;
var
  lFound: Shared<TProduct>;
begin
  Result := Nil;

  // Localizar Registro
  lFound := FRepository.Show(AId);
  if not Assigned(lFound.Value) then
    Exit;

  // Retornar DTO
  Result := TProductMapper.EntityToDTO(lFound);
end;

class function TProductShowUseCase.Make(const ARepository: IProductRepository): IProductShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
