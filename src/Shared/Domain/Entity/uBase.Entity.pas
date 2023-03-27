unit uBase.Entity;

interface

type
  TBaseEntity = class
  public
    function Validate: String; virtual; abstract;
  end;

implementation

end.
