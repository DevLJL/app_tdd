unit uController.Factory;

interface

uses
  uProduct.Controller.Interfaces,
  uProduct.Controller;

type
  TControllerFactory = class
  public
    class function Product: IProductController;
  end;

implementation

{ TControllerFactory }

class function TControllerFactory.Product: IProductController;
begin
  Result := TProductController.Make;
end;

end.
