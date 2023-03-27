unit uProduct.Delete.UseCase;

interface

uses
  uProduct.Repository.Interfaces;

type
  IProductDeleteUseCase = Interface
    ['{F150E707-956D-4614-B0B6-9E6FAB823CE8}']
    procedure Execute(const AId: Int64);
  End;

  TProductDeleteUseCase = class(TInterfacedObject, IProductDeleteUseCase)
  private
    FRepository: IProductRepository;
    constructor Create(const ARepository: IProductRepository);
  public
    class function Make(const ARepository: IProductRepository): IProductDeleteUseCase;
    procedure Execute(const AId: Int64);
  end;

implementation

{ TProductDeleteUseCase }

uses
  uEntityValidation.Exception,
  System.SysUtils;

constructor TProductDeleteUseCase.Create(const ARepository: IProductRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

procedure TProductDeleteUseCase.Execute(const AId: Int64);
begin
  FRepository.Delete(AId);
end;

class function TProductDeleteUseCase.Make(const ARepository: IProductRepository): IProductDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
