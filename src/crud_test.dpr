program app_tdd_tests;

// Rodar teste específico no terminal:
//./crud_test.exe --include:TProductControllerTest
{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  DataSetConverter4D.Helper in 'Vendor\DataSetConverter4Delphi\src\DataSetConverter4D.Helper.pas',
  DataSetConverter4D.Impl in 'Vendor\DataSetConverter4Delphi\src\DataSetConverter4D.Impl.pas',
  DataSetConverter4D in 'Vendor\DataSetConverter4Delphi\src\DataSetConverter4D.pas',
  DataSetConverter4D.Util in 'Vendor\DataSetConverter4Delphi\src\DataSetConverter4D.Util.pas',
  DataSet.Serialize.Config in 'Vendor\dataset-serialize\src\DataSet.Serialize.Config.pas',
  DataSet.Serialize.Consts in 'Vendor\dataset-serialize\src\DataSet.Serialize.Consts.pas',
  DataSet.Serialize.Export in 'Vendor\dataset-serialize\src\DataSet.Serialize.Export.pas',
  DataSet.Serialize.Import in 'Vendor\dataset-serialize\src\DataSet.Serialize.Import.pas',
  DataSet.Serialize.Language in 'Vendor\dataset-serialize\src\DataSet.Serialize.Language.pas',
  DataSet.Serialize in 'Vendor\dataset-serialize\src\DataSet.Serialize.pas',
  DataSet.Serialize.UpdatedStatus in 'Vendor\dataset-serialize\src\DataSet.Serialize.UpdatedStatus.pas',
  DataSet.Serialize.Utils in 'Vendor\dataset-serialize\src\DataSet.Serialize.Utils.pas',
  uEither in 'Vendor\Either\src\uEither.pas',
  uSmartPointer in 'Vendor\SmartPointer\src\uSmartPointer.pas',
  uZLConnection.Interfaces in 'Vendor\ZLConnection\src\uZLConnection.Interfaces.pas',
  uZLConnection.Types in 'Vendor\ZLConnection\src\uZLConnection.Types.pas',
  uZLMemTable.Interfaces in 'Vendor\ZLConnection\src\uZLMemTable.Interfaces.pas',
  uZLMigration in 'Vendor\ZLConnection\src\uZLMigration.pas',
  uZLQry.Interfaces in 'Vendor\ZLConnection\src\uZLQry.Interfaces.pas',
  uZLScript.Interfaces in 'Vendor\ZLConnection\src\uZLScript.Interfaces.pas',
  uZLConnection.FireDAC in 'Vendor\ZLConnection\src\FireDAC\uZLConnection.FireDAC.pas',
  uZLMemTable.FireDAC in 'Vendor\ZLConnection\src\FireDAC\uZLMemTable.FireDAC.pas',
  uZLQry.FireDAC in 'Vendor\ZLConnection\src\FireDAC\uZLQry.FireDAC.pas',
  uZLScript.FireDAC in 'Vendor\ZLConnection\src\FireDAC\uZLScript.FireDAC.pas',
  uProduct.Controller in 'Module\Stock\Product\Controller\uProduct.Controller.pas',
  uProduct.Repository.Interfaces in 'Module\Stock\Product\Repository\uProduct.Repository.Interfaces.pas',
  uProduct.Delete.UseCase in 'Module\Stock\Product\UseCase\uProduct.Delete.UseCase.pas',
  uProduct.Index.UseCase in 'Module\Stock\Product\UseCase\uProduct.Index.UseCase.pas',
  uProduct.Show.UseCase in 'Module\Stock\Product\UseCase\uProduct.Show.UseCase.pas',
  uProduct.Store.UseCase in 'Module\Stock\Product\UseCase\uProduct.Store.UseCase.pas',
  uProduct.Update.UseCase in 'Module\Stock\Product\UseCase\uProduct.Update.UseCase.pas',
  uProduct.DTO in 'Module\Stock\Product\DTO\uProduct.DTO.pas',
  uProduct.Mapper in 'Module\Stock\Product\Mapper\uProduct.Mapper.pas',
  uProduct in 'Module\Stock\Product\Domain\Entity\uProduct.pas',
  uProduct.Repository in 'Module\Stock\Product\Repository\uProduct.Repository.pas',
  uProduct.Controller.Interfaces in 'Module\Stock\Product\Controller\uProduct.Controller.Interfaces.pas',
  uRepository.Factory in 'Shared\Repository\uRepository.Factory.pas',
  uEnv in 'Shared\Environment\uEnv.pas',
  uHlp in 'Shared\Util\uHlp.pas',
  uIndexResult in 'Shared\Util\uIndexResult.pas',
  u2023_03_27_07_32_00_create_product_table.migration in 'Shared\Config\Migrations\u2023_03_27_07_32_00_create_product_table.migration.pas',
  uApplication.Exception in 'Shared\Exception\uApplication.Exception.pas',
  uBase.DTO in 'Shared\DTO\uBase.DTO.pas',
  uBase.Entity in 'Shared\Domain\Entity\uBase.Entity.pas',
  uBase.Migration in 'Shared\Config\uBase.Migration.pas',
  uConnection.Factory in 'Shared\Config\uConnection.Factory.pas',
  uConnMigration in 'Shared\Config\uConnMigration.pas',
  uController.Factory in 'Shared\Controller\uController.Factory.pas',
  uEntityValidation.Exception in 'Shared\Exception\Entity\uEntityValidation.Exception.pas',
  uMemTable.Factory in 'Shared\Config\uMemTable.Factory.pas',
  uSession.DTM in 'Shared\Config\uSession.DTM.pas' {SessionDTM: TDataModule},
  uTrans in 'Shared\Resources\Language\uTrans.pas',
  uProduct.Controller.Test in 'Tests\Module\Stock\Product\Controller\uProduct.Controller.Test.pas';

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
  ReportMemoryLeaksOnShutdown := true;
  SessionDTM := TSessionDTM.Create(nil);
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
  SessionDTM.Free;
end.

